package com.japanese.nihongobase.dto;

public class UserScoreDTO {

    private String username;
    private Double totalScore;

    public UserScoreDTO(String username, Double totalScore) {
        this.username = username;
        this.totalScore = totalScore;
    }

    // Getters

    public String getUsername() {
        return username;
    }

    public Double getTotalScore() {
        return totalScore;
    }

    // Setters omitted for brevity
}
