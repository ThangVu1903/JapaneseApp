package com.japanese.nihongobase.controller;
 

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.japanese.nihongobase.dto.VocabularyDTO;
import com.japanese.nihongobase.entity.Vocabulary;
import com.japanese.nihongobase.service.VocabularyService;

import jakarta.validation.Valid;


@RestController
@RequestMapping("/public/api")
public class VocabularyController {

    @Autowired
    private VocabularyService vocabularyService;

    @GetMapping("/lesson/{lessonNumber}/vocabulary")
    public List<Vocabulary> getVocabularyByLessonNumber(@PathVariable int lessonNumber) {
        return vocabularyService.findVocabularyByLessonNumber(lessonNumber);
    }

    @PostMapping("lesson/add/vocabulary")
    public ResponseEntity<Vocabulary> addVocabulary(@Valid @RequestBody VocabularyDTO vocabularyDTO) {
        Vocabulary savedVocabulary = vocabularyService.addVocabulary(vocabularyDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedVocabulary);
    }
     @PutMapping("lesson/update/vocabulary/{vocabularyId}") 
    public ResponseEntity<Vocabulary> updateVocabulary(@PathVariable int vocabularyId, @Valid @RequestBody VocabularyDTO vocabularyDTO) {
        Vocabulary updatedVocabulary = vocabularyService.updateVocabulary(vocabularyId, vocabularyDTO);
        return ResponseEntity.ok(updatedVocabulary);
    }

    @DeleteMapping("lesson/delete/vocabulary/{vocabularyId}")
    public ResponseEntity<Void> deleteVocabulary(@PathVariable int vocabularyId) {
        vocabularyService.deleteVocabulary(vocabularyId);
        return ResponseEntity.noContent().build();
    }
    @GetMapping("/vocabulary/{vocabularyId}")
    public ResponseEntity<Vocabulary> getVocabularyById(@PathVariable int vocabularyId) {
        Vocabulary vocabulary = vocabularyService.getVocabularyById(vocabularyId);
        return ResponseEntity.ok(vocabulary);
    }
}

