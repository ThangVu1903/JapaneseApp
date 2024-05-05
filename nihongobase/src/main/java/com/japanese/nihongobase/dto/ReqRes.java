package com.japanese.nihongobase.dto;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.japanese.nihongobase.entity.User;

import lombok.Data;

@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonIgnoreProperties(ignoreUnknown = true)
public class ReqRes {
    private int statusCode;
    private String error; 
    private String message; 
    private String token; 
    private String refeshToken; 
    private String expirationTime; 
    private String email; 
    private String username; 
    private String password; 
    private User user; 
    private List<User> userList;
    
}
