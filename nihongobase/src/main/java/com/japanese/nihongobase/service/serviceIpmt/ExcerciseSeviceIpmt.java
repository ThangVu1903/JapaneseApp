package com.japanese.nihongobase.service.serviceIpmt;

import java.util.List;

import com.japanese.nihongobase.entity.Exercise;



public interface ExcerciseSeviceIpmt {
    
    List<Exercise> findExercisesByLessonNumberAndType(int lessonNumber,String type);
    List<Exercise> findExercisesByLessonNumber(int lessonNumber);
}
