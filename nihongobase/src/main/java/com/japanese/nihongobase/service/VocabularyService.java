package com.japanese.nihongobase.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.japanese.nihongobase.entity.Vocabulary;
import com.japanese.nihongobase.repository.VocabularyRepository;
import com.japanese.nihongobase.service.serviceIpmt.VocabularyServiceIpmt;

@Service
public class VocabularyService implements VocabularyServiceIpmt  {
    @Autowired
    private VocabularyRepository vocabularyRepository;

    @Override
    public List<Vocabulary> findVocabularyByLessonNumber(int lesson_number) {
       return vocabularyRepository.findVocabularyByLessonNumber(lesson_number);
    }
    
}
