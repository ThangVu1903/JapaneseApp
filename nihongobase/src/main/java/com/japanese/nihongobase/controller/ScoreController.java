package com.japanese.nihongobase.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.japanese.nihongobase.dto.ScoreDTO;
import com.japanese.nihongobase.dto.UserScoreDTO;
import com.japanese.nihongobase.entity.Lesson;
import com.japanese.nihongobase.entity.Score;
import com.japanese.nihongobase.entity.User;
import com.japanese.nihongobase.repository.LessonRepository;
import com.japanese.nihongobase.repository.UserRepository;
import com.japanese.nihongobase.service.ScoreService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@RestController
@RequestMapping("/public/api")
public class ScoreController {
    @Autowired
    private ScoreService scoreService;

    @PostMapping("add/score")
    public ResponseEntity<Score> addScore(@RequestBody ScoreDTO scoreDTO) {
        Score score = scoreService.addScore(scoreDTO);
        return new ResponseEntity<>(score, HttpStatus.CREATED);
    }

    @GetMapping("lesson/{lessonId}/test/score")
    public List<UserScoreDTO> getScoreByLessonIdDesc(@PathVariable int lessonId) {
        return scoreService.getHighestUserScoresByLessonId(lessonId);
    }

}
