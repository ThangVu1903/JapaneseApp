package com.japanese.nihongobase.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.japanese.nihongobase.entity.Lesson;

@Repository
public interface LessonRepository extends JpaRepository<Lesson, Integer> {

    @Query(value = "SELECT l.lesson_id, l.lesson_number, l.lesson_name " +
            "FROM Course c " +
            "JOIN Lesson l ON c.course_id = l.course.course_id " +
            "WHERE c.course_name = :courseName")
    List<Object[]> getLessonByCourseName(@Param("courseName") String courseName); // getlessonbyCourseName

}
