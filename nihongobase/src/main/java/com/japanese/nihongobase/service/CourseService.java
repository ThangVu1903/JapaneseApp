package com.japanese.nihongobase.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.japanese.nihongobase.entity.Course;
import com.japanese.nihongobase.entity.User;
import com.japanese.nihongobase.repository.CourseRepository;

@Service
public class CourseService {

    @Autowired
    CourseRepository courseRepository;

    public void addCourseToUser(String courseName, String language){
        // Lấy thông tin authentication
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.getPrincipal() instanceof User) {
            // Lấy userId từ đối tượng User trong authentication
            Integer userId = ((User) authentication.getPrincipal()).getUserId();
            
            // Tạo mới đối tượng Course và thiết lập các thông tin
            Course course = new Course();
            course.setUser_id(userId);
            course.setCourse_name(courseName);
            course.setLanguage(language);
            
            // Lưu đối tượng Course vào cơ sở dữ liệu
            courseRepository.save(course);
        } else {
            // Xử lý trường hợp authentication không hợp lệ
            throw new RuntimeException("User not authenticated or invalid authentication");
        }
    }
    
    
    
}
