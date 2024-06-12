package com.japanese.nihongobase.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.japanese.nihongobase.dto.ScoreDTO;
import com.japanese.nihongobase.dto.UserScoreDTO;
import com.japanese.nihongobase.entity.Lesson;
import com.japanese.nihongobase.entity.Score;
import com.japanese.nihongobase.entity.User;
import com.japanese.nihongobase.repository.LessonRepository;
import com.japanese.nihongobase.repository.ScoreRepository;
import com.japanese.nihongobase.repository.UserRepository;
import com.japanese.nihongobase.service.serviceIpmt.ScoreServiceIpmt;

@Service
public class ScoreService implements ScoreServiceIpmt {
    @Autowired
    private ScoreRepository scoreRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private LessonRepository lessonRepository;

    public Score addScore(ScoreDTO scoreDTO) {
    User user = userRepository.findById(scoreDTO.getUserId())
            .orElseThrow(() -> new RuntimeException("User not found"));
    Lesson lesson = lessonRepository.findById(scoreDTO.getLessonId())
            .orElseThrow(() -> new RuntimeException("Lesson not found"));

    Score score = new Score();
    score.setUser(user);
    score.setLesson(lesson);
    score.setTotal_score(scoreDTO.getTotalScore());

    return scoreRepository.save(score);
}

public List<UserScoreDTO> getHighestUserScoresByLessonId(Integer lessonId) {
        List<Object[]> results = scoreRepository.findHighestUserScoresByLessonId(lessonId);
        List<UserScoreDTO> userScores = new ArrayList<>();
        for (Object[] result : results) {
            String username = (String) result[0];
            Double totalScore = ((Number) result[1]).doubleValue(); // Casting to Number first to avoid potential ClassCastException
            userScores.add(new UserScoreDTO(username, totalScore));
        }
        return userScores;
    }
} 
