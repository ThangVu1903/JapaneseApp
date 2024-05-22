package com.japanese.nihongobase.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.japanese.nihongobase.entity.Grammar;
import com.japanese.nihongobase.service.GrammarService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@RestController
@RequestMapping("/public/api")
public class GrammarController {
    @Autowired
    private GrammarService grammarService;

    @GetMapping("lesson/{lessonNumber}/grammar")
    public List<Grammar> getListGrammar(@PathVariable int lessonNumber) {
        return grammarService.findGrammarByLessonNumber(lessonNumber);
    }

}
