package com.japanese.nihongobase.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.japanese.nihongobase.entity.Exercise;
import com.japanese.nihongobase.service.ExcerciseSevice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@RestController
@RequestMapping("/public/api")
public class ExcerciseController {

    @Autowired
    private ExcerciseSevice exerciseSevice;

    @GetMapping("lesson/{lessonNumber}/exercise/{type}")
    public List<Exercise> getExerciseByLessonNumberAndType(@PathVariable int lessonNumber, @PathVariable String type) {
        return exerciseSevice.findExercisesByLessonNumberAndType(lessonNumber, type);
    }

    @GetMapping("lesson/{lessonNumber}/exercise")
    public List<Exercise> getExerciseByLessonNumber(@PathVariable int lessonNumber) {
        return exerciseSevice.findExercisesByLessonNumber(lessonNumber);
    }

}
