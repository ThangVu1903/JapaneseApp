package com.japanese.nihongobase.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class ExerciseDTO {
     @NotNull(message = "Lesson ID is required")
    private Integer lessonId;
     @NotBlank(message = "type is required")
    private String type;
    @NotBlank(message = "questionNumber is required")
    private int questionNumber;
    private String kanjiQuestion;
    @NotBlank(message = "questionContent is required")
    private String questionContent;
    @NotBlank(message = "option1 is required")
    private String option1;
    @NotBlank(message = "option2 is required")
    private String option2;
    @NotBlank(message = "option3 is required")
    private String option3;
    @NotBlank(message = "correctOption is required")
    private int correctOption;
}
