package com.japanese.nihongobase.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.japanese.nihongobase.dto.CourseRequest;
import com.japanese.nihongobase.dto.ReqRes;
import com.japanese.nihongobase.service.CourseService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@RestController
@RequestMapping("/user")
public class courseController {
    @Autowired
    CourseService courseService;

    @SuppressWarnings("rawtypes")
    @PostMapping("/course/add")
    public ResponseEntity addCourseToUser(@RequestBody CourseRequest courseRequest) {
        System.out.println("Request received in addCourseToUser controller.");

        // Thêm khoá học cho người dùng
        courseService.addCourseToUser(courseRequest.getCourseName(), courseRequest.getLanguage());

        System.out.println("Course added successfully.");

        ReqRes response = new ReqRes();
        response.setStatusCode(200);
        response.setMessage("Course added successfully.");
        return ResponseEntity.ok(response);

    }

}
