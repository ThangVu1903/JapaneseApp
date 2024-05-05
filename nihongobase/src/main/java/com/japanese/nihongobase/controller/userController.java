package com.japanese.nihongobase.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.neo4j.Neo4jProperties.Authentication;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.RestController;

import com.japanese.nihongobase.dto.ReqRes;
import com.japanese.nihongobase.entity.User;
import com.japanese.nihongobase.service.UserManagementSevice;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;

@RestController
public class userController {
    @Autowired
    private UserManagementSevice userManagementSevice;


    @PostMapping("/auth/register")
    public ResponseEntity<ReqRes> register(@RequestBody ReqRes reg) {
        return ResponseEntity.ok(userManagementSevice.register(reg));
    }


    @PostMapping("/auth/login")
    public ResponseEntity<ReqRes> login(@RequestBody ReqRes reg) {
        return ResponseEntity.ok(userManagementSevice.login(reg));
    }

    @PostMapping("/auth/refesh")
    public ResponseEntity<ReqRes> refeshToken(@RequestBody ReqRes reg) {
        return ResponseEntity.ok(userManagementSevice.refreshToken(reg));
    }
    
    @GetMapping("/admin/get-all-users")
    public ResponseEntity<ReqRes> getAllUsers() {
        return ResponseEntity.ok(userManagementSevice.getAllUsers());
    }

    @GetMapping("/admin/get-user/{userId}")
    public ResponseEntity<ReqRes> getUserById(Integer id) {
        return ResponseEntity.ok(userManagementSevice.getUsersById(id));
    }

    @PutMapping("/admin/update/{userId}")
    public ResponseEntity<ReqRes> updateUser(@PathVariable Integer id, @RequestBody User user) {
        return ResponseEntity.ok(userManagementSevice.updateUser(id,user));
    }

    @GetMapping("/adminuser/get-profile")
    public ResponseEntity<ReqRes> getMyProfile() {
        Authentication authentication = (Authentication) SecurityContextHolder.getContext().getAuthentication();
        String email = authentication.getUsername();
        ReqRes response =  userManagementSevice.getMyInfo(email);
        return ResponseEntity.status(response.getStatusCode()).body(response);
    }

    @DeleteMapping("/admin/delete/{userId}")
    public ResponseEntity<ReqRes> deleteUser(@PathVariable Integer id){
        return ResponseEntity.ok(userManagementSevice.deleteUser(id));
    }


    


    
}
