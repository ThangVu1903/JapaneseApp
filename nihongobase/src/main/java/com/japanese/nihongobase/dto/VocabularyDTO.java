package com.japanese.nihongobase.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class VocabularyDTO {

    @NotNull(message = "Lesson ID is required")
    private int lessonId; 
    @NotBlank(message = "Hiragana is required")
    private String hiragana;
    private String kanji;
    @NotBlank(message = "Meaning is required")
    private String meanning;
    private String example;
    private String example_meanning;
}
