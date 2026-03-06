package com.example.frontoffice.service;

import com.example.frontoffice.dto.ListResponse;
import com.example.frontoffice.model.Reservation;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.time.LocalDate;
import java.util.Collections;
import java.util.List;

@Service
public class ApiService {

    private final RestTemplate restTemplate;

    @Value("${api.base.url}")
    private String baseUrl;

    public ApiService(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    public List<Reservation> getReservations(LocalDate date) {

        try {

            ResponseEntity<ListResponse<Reservation>> response = restTemplate.exchange(
                    baseUrl + "/reservations?date={date}",
                    HttpMethod.GET,
                    null,
                    new ParameterizedTypeReference<ListResponse<Reservation>>() {
                    },
                    date);

            ListResponse<Reservation> body = response.getBody();

            if (body == null)
                return Collections.emptyList();

            if ("error".equals(body.getStatus()))
                throw new IllegalStateException(body.getError());

            return body.getData() != null
                    ? body.getData().getItems()
                    : Collections.emptyList();

        } catch (Exception e) {
            throw new IllegalStateException("Token invalide ou expiré");
        }
    }

    public void sendTokenToBackOffice(String token) {
        String url = baseUrl + "/authentification?token={token}";

        String response = restTemplate.postForObject(url, null, String.class, token);
        System.out.println("Réponse API : " + response);
    }
}