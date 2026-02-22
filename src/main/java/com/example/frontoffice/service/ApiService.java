package com.example.frontoffice.service;

import com.example.frontoffice.dto.ReservationResponse;
import com.example.frontoffice.model.Reservation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDate;
import java.util.Collections;
import java.util.List;

@Service
public class ApiService {

    private final RestTemplate restTemplate;

    @Value("${api.url.reservations}")
    private String reservationsUrl;

    public ApiService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public List<Reservation> getReservations(LocalDate date) {
        ReservationResponse response = restTemplate.getForObject(
                reservationsUrl + "?date={date}",
                ReservationResponse.class,
                date);

        return response != null ? response.getData() : Collections.emptyList();
    }
}