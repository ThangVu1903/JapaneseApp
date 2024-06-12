package com.japanese.nihongobase.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.japanese.nihongobase.entity.Exercise;
import com.japanese.nihongobase.repository.ExcerciseRepository;
import com.japanese.nihongobase.service.serviceIpmt.ExcerciseSeviceIpmt;

@Service
public class ExcerciseSevice implements ExcerciseSeviceIpmt {

    @Autowired
    private ExcerciseRepository excerciseRepository;

    @Override
    public List<Exercise> findExercisesByLessonNumberAndType(int lessonNumber, String type) {
        return excerciseRepository.findExercisesByLessonNumberAndType(lessonNumber, type);
    }

    @Override
    public List<Exercise> findExercisesByLessonNumber(int lessonNumber) {
       return excerciseRepository.findExercisesByLessonNumber(lessonNumber);
    }
        

    
    

}
