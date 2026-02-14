package com.example.ecommerce.config;

import com.example.ecommerce.model.Product;
import com.example.ecommerce.repository.ProductRepository;
import com.example.ecommerce.model.User;
import com.example.ecommerce.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;
import java.math.BigDecimal;

@Configuration
public class DataInitializer {

        @Bean
        public CommandLineRunner initData(ProductRepository productRepository) {
                return args -> {
                        if (productRepository.count() == 0) {
                                Product p1 = new Product();
                                p1.setName("iPhone 15 Pro Max");
                                p1.setDescription(
                                                "Experience the next generation of mobile innovation. Featuring a titanium design, A17 Pro chip, and the most advanced camera system in an iPhone.");
                                p1.setPrice(new BigDecimal("1199.99"));
                                p1.setImageUrl(
                                                "https://images.unsplash.com/photo-1696446701796-da61225697cc?auto=format&fit=crop&q=80&w=800");
                                p1.setCategory("Electronics");

                                Product p2 = new Product();
                                p2.setName("MacBook Pro M3");
                                p2.setDescription(
                                                "The ultimate workstation for professionals. With the M3 chip, Liquid Retina XDR display, and up to 22 hours of battery life.");
                                p2.setPrice(new BigDecimal("2499.99"));
                                p2.setImageUrl(
                                                "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?auto=format&fit=crop&q=80&w=800");
                                p2.setCategory("Electronics");

                                Product p3 = new Product();
                                p3.setName("Sony WH-1000XM5");
                                p3.setDescription(
                                                "Industry-leading noise cancellation. Perfection in sound quality, call quality, and comfort for the ultimate listening experience.");
                                p3.setPrice(new BigDecimal("399.99"));
                                p3.setImageUrl(
                                                "https://images.unsplash.com/photo-1678103131342-fd820b335384?auto=format&fit=crop&q=80&w=800");
                                p3.setCategory("Audio");

                                Product p4 = new Product();
                                p4.setName("Premium Leather Chair");
                                p4.setDescription(
                                                "Ergonomic design meets Italian leather. The perfect blend of luxury and comfort for your dream office setup.");
                                p4.setPrice(new BigDecimal("599.99"));
                                p4.setImageUrl(
                                                "https://images.unsplash.com/photo-1592078615290-033ee584e267?auto=format&fit=crop&q=80&w=800");
                                p4.setCategory("Furniture");

                                productRepository.save(p1);
                                productRepository.save(p2);
                                productRepository.save(p3);
                                productRepository.save(p4);
                        }
                };
        }

        @Bean
        public CommandLineRunner initUser(UserRepository userRepository, PasswordEncoder passwordEncoder) {
                return args -> {
                        if (userRepository.findByUsername("admin").isEmpty()) {
                                User admin = new User();
                                admin.setUsername("admin");
                                admin.setPassword(passwordEncoder.encode("admin"));
                                admin.setEmail("admin@example.com");
                                admin.setRole("ROLE_ADMIN");
                                userRepository.save(admin);
                        }
                };
        }
}
