package com.example.ecommerce.model;

import jakarta.persistence.*;
import lombok.Data;
import com.example.ecommerce.util.AttributeEncryptor;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Data
@Table(name = "orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @Column(nullable = false)
    private LocalDateTime orderDate;

    private BigDecimal totalAmount;

    private String status; // PENDING, COMPLETED

    @Convert(converter = com.example.ecommerce.util.AttributeEncryptor.class)
    private String shippingAddress;

    @Convert(converter = com.example.ecommerce.util.AttributeEncryptor.class)
    private String paymentInfo;
}
