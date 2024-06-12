package com.japanese.nihongobase.dto;



public class ScoreDTO {
    private int userId;
    private int lessonId;
    private double totalScore;


    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }
    public int getLessonId() {
        return lessonId;
    }
    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }
    public double getTotalScore() {
        return totalScore;
    }
    public void setTotalScore(double totalScore) {
        this.totalScore = totalScore;
    }

    // Getters and Setters
}
