package com.example.frontoffice.dto;

public class Response<T> {
    private String status;
    private T data;
    private String error;
    
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    
    public T getData() {
        return data;
    }
    public void setData(T data) {
        this.data = data;
    }
    public String getError() {
        return error;
    }
    public void setError(String error) {
        this.error = error;
    }
}
