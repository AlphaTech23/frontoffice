package com.example.frontoffice.service;

import com.example.frontoffice.model.Reservation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@Service
public class ApiService {

    @Value("${api.url.reservations}")
    private String reservationsApiUrl;

    private final RestTemplate restTemplate;

    public ApiService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public List<Reservation> getReservations(LocalDate date) {
        String dateStr = "";
        if (date != null) {
            dateStr = date.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        }

        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(reservationsApiUrl)
                .queryParam("date", dateStr);

        try {
            Reservation[] reservations = restTemplate.getForObject(builder.toUriString(), Reservation[].class);
            if (reservations != null) {
                return Arrays.asList(reservations);
            }
        } catch (Exception e) {
            e.printStackTrace(); // In a real app, use a logger
            // Handle exception (e.g., return empty list or rethrow custom exception)
        }
        return Collections.emptyList();
    }
}
