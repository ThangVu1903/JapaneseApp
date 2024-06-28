package com.japanese.nihongobase.service.serviceIpmt;

import java.util.List;

import com.japanese.nihongobase.dto.VocabularyDTO;
import com.japanese.nihongobase.entity.Vocabulary;

public interface VocabularyServiceIpmt {
    List<Vocabulary> findVocabularyByLessonNumber(int lesson_number);
    public Vocabulary addVocabulary(VocabularyDTO vocabularyDTO);
    void deleteVocabulary(int vocabularyId);
    Vocabulary updateVocabulary(int vocabularyId, VocabularyDTO vocabularyDTO);

}
