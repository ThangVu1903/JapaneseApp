package com.japanese.nihongobase.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.japanese.nihongobase.entity.Lesson;
import com.japanese.nihongobase.service.Lesson_sevice;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@RestController
@RequestMapping("/public/api")
public class LessonController {

    @Autowired
    private Lesson_sevice lesson_sevice;

    @GetMapping("courses/{course_name}/lesson")
    public ResponseEntity<List<Lesson>> getLessonByCourseName(@PathVariable String course_name) {
        List<Lesson> lessons = lesson_sevice.getLessonByCourseName(course_name);
        return ResponseEntity.ok(lessons);
    }

}
