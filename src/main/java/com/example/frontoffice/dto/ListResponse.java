package com.example.frontoffice.dto;

public class ListResponse<T> {
    private String status;
    private DataWrapper<T> data;
    private String error;

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public DataWrapper<T> getData() {
        return data;
    }
    public void setData(DataWrapper<T> data) {
        this.data = data;
    }
    public String getError() {
        return error;
    }
    public void setError(String error) {
        this.error = error;
    }
}