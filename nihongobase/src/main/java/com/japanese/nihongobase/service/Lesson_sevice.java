package com.japanese.nihongobase.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.japanese.nihongobase.entity.Lesson;
import com.japanese.nihongobase.repository.LessonRepository;
import com.japanese.nihongobase.service.serviceIpmt.Lesson_seviceIpmt;

@Service
public class Lesson_sevice implements Lesson_seviceIpmt {
    @Autowired
    private LessonRepository lessonRepository;

    @Override
    public List<Lesson> getLessonByCourseName(String courseName) {
        List<Object[]> resuList = lessonRepository.getLessonByCourseName(courseName);
        List<Lesson> lessonList = new ArrayList<>();
        for(Object[] row : resuList){
            Lesson lesson = new Lesson();
            lesson.setLesson_id((Integer) row[0]);
            lesson.setLessonNumber((int) row[1]);
            lesson.setLesson_name((String) row[2]);
            lessonList.add(lesson);
        }
        return lessonList;
    }

}
