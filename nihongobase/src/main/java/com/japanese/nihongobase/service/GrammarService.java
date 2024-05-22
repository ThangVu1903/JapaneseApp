package com.japanese.nihongobase.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.japanese.nihongobase.entity.Grammar;
import com.japanese.nihongobase.repository.GrammarRepository;
import com.japanese.nihongobase.service.serviceIpmt.GrammarServiceIpmt;

@Service
public class GrammarService implements GrammarServiceIpmt{

    @Autowired
    private GrammarRepository grammarRepository;

    @Override
    public List<Grammar> findGrammarByLessonNumber(int lesson_number) {
        return grammarRepository.findGrammarByLessonNumber(lesson_number);
    }
    
}
