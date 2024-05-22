package com.japanese.nihongobase.service.serviceIpmt;

import java.util.List;

import com.japanese.nihongobase.entity.Grammar;

public interface GrammarServiceIpmt {
    List<Grammar> findGrammarByLessonNumber(int lesson_number);
}

