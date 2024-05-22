package com.japanese.nihongobase.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.japanese.nihongobase.entity.Grammar;

@Repository
public interface GrammarRepository extends JpaRepository<Grammar,Integer>{
    @Query("SELECT g FROM Grammar g JOIN g.lesson l WHERE l.lesson_number = :lessonNumber")
    List<Grammar> findGrammarByLessonNumber(@Param("lessonNumber") int lesson_number);
} 
