package com.japanese.nihongobase.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.japanese.nihongobase.dto.GrammarDTO;
import com.japanese.nihongobase.entity.Grammar;
import com.japanese.nihongobase.service.GrammarService;

import jakarta.validation.Valid;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;

@RestController
@RequestMapping("/public/api")
public class GrammarController {
    @Autowired
    private GrammarService grammarService;

    @GetMapping("lesson/{lessonNumber}/grammar")
    public List<Grammar> getListGrammar(@PathVariable int lessonNumber) {
        return grammarService.findGrammarByLessonNumber(lessonNumber);
    }

    @PostMapping("lesson/add/grammar")
    public ResponseEntity<?> addGrammar(@Valid @RequestBody GrammarDTO grammarDTO, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body(bindingResult.getAllErrors());
        }
        Grammar newGrammar = grammarService.addGrammar(grammarDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(newGrammar);
    }

    @PutMapping("/grammar/update/{grammarId}")
    public ResponseEntity<?> updateGrammar(@PathVariable int grammarId, @Valid @RequestBody GrammarDTO grammarDTO, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body(bindingResult.getAllErrors());
        }
        Grammar updatedGrammar = grammarService.updateGrammar(grammarId, grammarDTO);
        return ResponseEntity.ok(updatedGrammar);
    }

    @DeleteMapping("/grammar/delete/{grammarId}")
    public ResponseEntity<Void> deleteGrammar(@PathVariable int grammarId) {
        grammarService.deleteGrammar(grammarId);
        return ResponseEntity.noContent().build();
    }

}
