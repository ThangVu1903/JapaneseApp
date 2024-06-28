package com.japanese.nihongobase.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import com.japanese.nihongobase.dto.VocabularyDTO;
import com.japanese.nihongobase.entity.Lesson;
import com.japanese.nihongobase.entity.Vocabulary;
import com.japanese.nihongobase.repository.LessonRepository;
import com.japanese.nihongobase.repository.VocabularyRepository;
import com.japanese.nihongobase.service.serviceIpmt.VocabularyServiceIpmt;

@Service
public class VocabularyService implements VocabularyServiceIpmt  {
    @Autowired
    private VocabularyRepository vocabularyRepository;

    @Autowired
    private LessonRepository lessonRepository;

    @Override
    public List<Vocabulary> findVocabularyByLessonNumber(int lesson_number) {
       return vocabularyRepository.findVocabularyByLessonNumber(lesson_number);
    }

    @Transactional
    public Vocabulary addVocabulary(VocabularyDTO vocabularyDTO) {
        Lesson lesson = lessonRepository.findById(vocabularyDTO.getLessonId())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Lesson not found"));

        Vocabulary vocabulary = new Vocabulary();
        vocabulary.setLesson(lesson);
        vocabulary.setHiragana(vocabularyDTO.getHiragana());
        vocabulary.setKanji(vocabularyDTO.getKanji());
        vocabulary.setMeanning(vocabularyDTO.getMeanning());
        vocabulary.setExample(vocabularyDTO.getExample());
        vocabulary.setExample_meanning(vocabularyDTO.getExample_meanning());

        return vocabularyRepository.save(vocabulary);
    }

    @Transactional
    public void deleteVocabulary(int vocabularyId) {
        Optional<Vocabulary> vocabularyOptional = vocabularyRepository.findById(vocabularyId);

        if (vocabularyOptional.isPresent()) {
            vocabularyRepository.deleteById(vocabularyId);
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Vocabulary not found");
        }
    }
    public Vocabulary updateVocabulary(int vocabularyId, VocabularyDTO vocabularyDTO) {
        Vocabulary vocabulary = vocabularyRepository.findById(vocabularyId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Vocabulary not found"));

        // Cập nhật thông tin từ vựng từ vocabularyDTO
        vocabulary.setHiragana(vocabularyDTO.getHiragana());
        vocabulary.setKanji(vocabularyDTO.getKanji());
        vocabulary.setMeanning(vocabularyDTO.getMeanning());
        vocabulary.setExample(vocabularyDTO.getExample());
        vocabulary.setExample_meanning(vocabularyDTO.getExample_meanning());

        return vocabularyRepository.save(vocabulary);
    }
    public Vocabulary getVocabularyById(int vocabularyId) {
        return vocabularyRepository.findById(vocabularyId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Vocabulary not found with id: " + vocabularyId));
    }

    
    
}
