package com.japanese.nihongobase.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.japanese.nihongobase.entity.Exercise;

@Repository
public interface ExcerciseRepository extends JpaRepository<Exercise, Integer> {

    @Query("SELECT e FROM Exercise e WHERE e.lesson.lessonNumber = :lessonNumber AND e.type = :type")
    List<Exercise> findExercisesByLessonNumberAndType(@Param("lessonNumber") int lessonNumber,
            @Param("type") String type);

    @Query("SELECT e FROM Exercise e WHERE e.lesson.lessonNumber = :lessonNumber")
    List<Exercise> findExercisesByLessonNumber(@Param("lessonNumber") int lessonNumber);
}
