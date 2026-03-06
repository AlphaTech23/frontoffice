package com.example.frontoffice.controller;

import com.example.frontoffice.model.Reservation;
import com.example.frontoffice.service.ApiService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.util.List;

@Controller
public class ReservationController {

    private final ApiService apiService;

    public ReservationController(ApiService apiService) {
        this.apiService = apiService;
    }

    @GetMapping("/reservations")
    public String listReservations(
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
            Model model) {
        try {
            List<Reservation> reservations = apiService.getReservations(date);
            model.addAttribute("reservations", reservations);
        } catch(Exception e) {
            model.addAttribute("message", e.getMessage());
        }
        model.addAttribute("date", date); 
        return "reservation/list";
    }
}
