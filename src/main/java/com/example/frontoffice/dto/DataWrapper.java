package com.example.frontoffice.dto;

import java.util.List;

public class DataWrapper<T> {
    private List<T> items;
    private int count;
    
    public List<T> getItems() {
        return items;
    }
    public void setItems(List<T> items) {
        this.items = items;
    }
    public int getCount() {
        return count;
    }
    public void setCount(int count) {
        this.count = count;
    }
}
