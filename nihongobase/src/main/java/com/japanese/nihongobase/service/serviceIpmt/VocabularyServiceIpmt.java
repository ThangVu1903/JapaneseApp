package com.japanese.nihongobase.service.serviceIpmt;

import java.util.List;

import com.japanese.nihongobase.entity.Vocabulary;

public interface VocabularyServiceIpmt {
    List<Vocabulary> findVocabularyByLessonNumber(int lesson_number);
}
