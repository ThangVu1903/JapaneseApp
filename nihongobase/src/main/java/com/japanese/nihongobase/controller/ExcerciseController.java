package com.japanese.nihongobase.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.japanese.nihongobase.dto.ExerciseDTO;
import com.japanese.nihongobase.entity.Exercise;
import com.japanese.nihongobase.entity.Lesson;
import com.japanese.nihongobase.repository.LessonRepository;
import com.japanese.nihongobase.service.ExcerciseSevice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;

@RestController
@RequestMapping("/public/api")
public class ExcerciseController {

    @Autowired
    private ExcerciseSevice exerciseSevice;

    @GetMapping("lesson/{lessonNumber}/exercise/{type}")
    public List<Exercise> getExerciseByLessonNumberAndType(@PathVariable("lessonNumber") int lessonNumber,
            @PathVariable("type") String type) {
        return exerciseSevice.findExercisesByLessonNumberAndType(lessonNumber, type);
    }

    @GetMapping("lesson/{lessonNumber}/exercise")
    public List<Exercise> getExerciseByLessonNumber(@PathVariable("lessonNumber") int lessonNumber) {
        return exerciseSevice.findExercisesByLessonNumber(lessonNumber);
    }

    @PostMapping("/lesson/test/add")
    public ResponseEntity<Exercise> addExercise(@RequestBody ExerciseDTO exerciseDTO) {
        Exercise newExercise = exerciseSevice.addExercise(exerciseDTO);
        return new ResponseEntity<>(newExercise, HttpStatus.CREATED);
    }

    @PutMapping("/lesson/test/udate/{exerciseId}")
    public ResponseEntity<Exercise> updateExercise(@PathVariable Integer exerciseId,
            @RequestBody ExerciseDTO exerciseDTO) {
        Exercise updatedExercise = exerciseSevice.updateExercise(exerciseId, exerciseDTO);
        return ResponseEntity.ok(updatedExercise);
    }

    @DeleteMapping("/lesson/test/delete/{exerciseId}")
    public ResponseEntity<Void> deleteExercise(@PathVariable Integer exerciseId) {
        exerciseSevice.deleteExercise(exerciseId);
        return ResponseEntity.noContent().build();
    }

}
