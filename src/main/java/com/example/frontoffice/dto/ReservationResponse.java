package com.example.frontoffice.dto;

import com.example.frontoffice.model.Reservation;
import java.util.List;

public class ReservationResponse {
    private String status;
    private List<Reservation> data;

    // getters et setters
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<Reservation> getData() {
        return data;
    }

    public void setData(List<Reservation> data) {
        this.data = data;
    }
}