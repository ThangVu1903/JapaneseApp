package com.japanese.nihongobase.service.serviceIpmt;

import java.util.List;

import com.japanese.nihongobase.entity.Lesson;

public interface Lesson_seviceIpmt {
    List<Lesson> getLessonByCourseName(String courseName);
}
