package com.japanese.nihongobase.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.japanese.nihongobase.entity.Vocabulary;
import com.japanese.nihongobase.service.VocabularyService;


@RestController
@RequestMapping("/public/api")
public class VocabularyController {

    @Autowired
    private VocabularyService vocabularyService;

    @GetMapping("/lesson/{lessonNumber}/vocabulary")
    public List<Vocabulary> getVocabularyByLessonNumber(@PathVariable int lessonNumber) {
        return vocabularyService.findVocabularyByLessonNumber(lessonNumber);
    }
}

