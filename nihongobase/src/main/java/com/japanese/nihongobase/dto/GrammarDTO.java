package com.japanese.nihongobase.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class GrammarDTO {
    @NotNull(message = "Lesson ID is required")
    private int lessonId; 

    @NotBlank(message = "structure is required")
    private String structure;
    @NotBlank(message = "explain_grammar is required")
    private String explain_grammar;
    @NotBlank(message = "example is required")
    private String example;
    @NotBlank(message = "example_meanning is required")
    private String example_meanning;
}
