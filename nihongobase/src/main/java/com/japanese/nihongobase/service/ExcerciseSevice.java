package com.japanese.nihongobase.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import com.japanese.nihongobase.dto.ExerciseDTO;
import com.japanese.nihongobase.entity.Exercise;
import com.japanese.nihongobase.entity.Lesson;
import com.japanese.nihongobase.repository.ExcerciseRepository;
import com.japanese.nihongobase.repository.LessonRepository;
import com.japanese.nihongobase.service.serviceIpmt.ExcerciseSeviceIpmt;

@Service
public class ExcerciseSevice implements ExcerciseSeviceIpmt {

    @Autowired
    private ExcerciseRepository excerciseRepository;

    @Autowired
    private LessonRepository lessonRepository;

    @Override
    public List<Exercise> findExercisesByLessonNumberAndType(int lessonNumber, String type) {
        return excerciseRepository.findExercisesByLessonNumberAndType(lessonNumber, type);
    }

    @Override
    public List<Exercise> findExercisesByLessonNumber(int lessonNumber) {
        return excerciseRepository.findExercisesByLessonNumber(lessonNumber);
    }
    @Transactional
    public Exercise addExercise(ExerciseDTO exerciseDTO) {
        Lesson lesson = lessonRepository.findById(exerciseDTO.getLessonId())
                .orElseThrow(() -> new RuntimeException("Lesson not found with id " + exerciseDTO.getLessonId()));

        Exercise exercise = new Exercise();
        exercise.setLesson(lesson);
        exercise.setType(exerciseDTO.getType());
        exercise.setQuestion_number(exerciseDTO.getQuestionNumber());
        exercise.setKanji_question(exerciseDTO.getKanjiQuestion());
        exercise.setQuestion_content(exerciseDTO.getQuestionContent());
        exercise.setOption1(exerciseDTO.getOption1());
        exercise.setOption2(exerciseDTO.getOption2());
        exercise.setOption3(exerciseDTO.getOption3());
        exercise.setCorrect_option(exerciseDTO.getCorrectOption());

        return excerciseRepository.save(exercise);
    }

    public Exercise updateExercise(Integer exerciseId, ExerciseDTO exerciseDTO) {
        Exercise exercise = excerciseRepository.findById(exerciseId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND,
                        "Exercise not found with id " + exerciseId));
        exercise.setType(exerciseDTO.getType());
        exercise.setQuestion_number(exerciseDTO.getQuestionNumber());
        exercise.setKanji_question(exerciseDTO.getKanjiQuestion());
        exercise.setQuestion_content(exerciseDTO.getQuestionContent());
        exercise.setOption1(exerciseDTO.getOption1());
        exercise.setOption2(exerciseDTO.getOption2());
        exercise.setOption3(exerciseDTO.getOption3());
        exercise.setCorrect_option(exerciseDTO.getCorrectOption());
        return excerciseRepository.save(exercise);
    }

    public void deleteExercise(Integer exerciseId) {
        if (!excerciseRepository.existsById(exerciseId)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Exercise not found with id " + exerciseId);
        }
        excerciseRepository.deleteById(exerciseId);
    }

}
