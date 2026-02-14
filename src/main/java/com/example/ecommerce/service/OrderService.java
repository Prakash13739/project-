package com.example.ecommerce.service;

import com.example.ecommerce.model.Cart;
import com.example.ecommerce.model.Order;
import com.example.ecommerce.model.User;
import com.example.ecommerce.repository.CartRepository;
import com.example.ecommerce.repository.OrderRepository;
import com.example.ecommerce.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private UserRepository userRepository;

    /**
     * Places an order for the given user.
     * Calculates the total price, saves the order, and clears the user's cart.
     * 
     * @param username        The username of the customer
     * @param shippingAddress The full shipping address string
     * @param paymentInfo     The payment details (will be encrypted)
     * @return The saved Order entity
     */
    @Transactional
    public Order placeOrder(String username, String shippingAddress, String paymentInfo) {
        // 1. Fetch User and Cart
        User user = userRepository.findByUsername(username).orElseThrow();
        Cart cart = cartRepository.findByUser(user).orElseThrow(() -> new RuntimeException("Cart not found"));

        if (cart.getItems().isEmpty()) {
            throw new RuntimeException("Cart is empty");
        }

        BigDecimal total = cart.getItems().stream()
                .map(item -> item.getProduct().getPrice().multiply(new BigDecimal(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        Order order = new Order();
        order.setUser(user);
        order.setOrderDate(LocalDateTime.now());
        order.setTotalAmount(total);
        order.setStatus("COMPLETED"); // simplifying for now
        order.setShippingAddress(shippingAddress);
        // paymentInfo will be automatically encrypted by the AttributeEncryptor
        order.setPaymentInfo(paymentInfo);

        // In a real app, copy cart items to order items here

        orderRepository.save(order);

        // Clear cart
        cart.getItems().clear();
        cartRepository.save(cart);

        return order;
    }
}
