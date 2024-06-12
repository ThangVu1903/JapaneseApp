package com.japanese.nihongobase.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.japanese.nihongobase.entity.Vocabulary;

@Repository
public interface VocabularyRepository extends JpaRepository<Vocabulary, Integer> {
    @Query("SELECT v FROM Vocabulary v JOIN v.lesson l WHERE l.lessonNumber = :lessonNumber")
    List<Vocabulary> findVocabularyByLessonNumber(@Param("lessonNumber") int lesson_number);
}

