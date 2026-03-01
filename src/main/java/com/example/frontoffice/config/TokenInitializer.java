package com.example.frontoffice.config;

import jakarta.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import com.example.frontoffice.service.ApiService;

@Component
public class TokenInitializer {

    @Value("${api.token}")
    private String token;

    @Autowired
    private ApiService apiService;

    @PostConstruct
    public void onStartup() {
        apiService.sendTokenToBackOffice(token);
    }
}