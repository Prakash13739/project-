package com.example.ecommerce.controller;

import com.example.ecommerce.service.CartService;
import com.example.ecommerce.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.math.BigDecimal;
import java.security.Principal;

@Controller
public class OrderController {

    @Autowired
    private OrderService orderService;

    @Autowired
    private CartService cartService;

    @GetMapping("/checkout")
    public String checkoutPage(Model model, Principal principal) {
        if (principal == null)
            return "redirect:/login";

        var cart = cartService.getCart(principal.getName());
        if (cart.getItems().isEmpty())
            return "redirect:/cart";

        BigDecimal total = cart.getItems().stream()
                .map(item -> item.getProduct().getPrice().multiply(new BigDecimal(item.getQuantity())))
                .reduce(BigDecimal.ZERO, BigDecimal::add);

        model.addAttribute("total", total);
        return "checkout";
    }

    @PostMapping("/checkout")
    public String proceedToPayment(@RequestParam String fullName,
            @RequestParam String address,
            @RequestParam String city,
            Principal principal,
            Model model) {
        String shippingAddress = fullName + ", " + address + ", " + city;

        model.addAttribute("shippingAddress", shippingAddress);
        if (principal != null) {
            model.addAttribute("totalAmount", cartService.getCartTotal(principal.getName()));
        }

        return "payment";
    }

    @PostMapping("/process-order")
    public String processOrder(@RequestParam String shippingAddress,
            @RequestParam String cardNumber,
            @RequestParam String expiry,
            @RequestParam String cvv,
            Principal principal) {
        if (principal == null)
            return "redirect:/login";

        String paymentInfo = "Card: " + cardNumber + ", Expiry: " + expiry + ", CVV: " + cvv;
        orderService.placeOrder(principal.getName(), shippingAddress, paymentInfo);

        return "redirect:/order-confirmation";
    }

    @GetMapping("/order-confirmation")
    public String orderConfirmation() {
        return "order-confirmation";
    }
}
