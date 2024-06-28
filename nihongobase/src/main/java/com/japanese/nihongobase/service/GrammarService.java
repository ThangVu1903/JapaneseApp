package com.japanese.nihongobase.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.japanese.nihongobase.dto.GrammarDTO;
import com.japanese.nihongobase.entity.Grammar;
import com.japanese.nihongobase.entity.Lesson;
import com.japanese.nihongobase.repository.GrammarRepository;
import com.japanese.nihongobase.repository.LessonRepository;
import com.japanese.nihongobase.service.serviceIpmt.GrammarServiceIpmt;

@Service
public class GrammarService implements GrammarServiceIpmt{

    @Autowired
    private GrammarRepository grammarRepository;

    @Autowired
    private LessonRepository lessonRepository;

    @Override
    public List<Grammar> findGrammarByLessonNumber(int lesson_number) {
        return grammarRepository.findGrammarByLessonNumber(lesson_number);
    }

    public Grammar addGrammar(GrammarDTO grammarDTO) {
        Lesson lesson = lessonRepository.findById(grammarDTO.getLessonId())
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Lesson not found"));

        Grammar grammar = new Grammar();
        grammar.setLesson(lesson);
        grammar.setStructure(grammarDTO.getStructure());
        grammar.setExplain_grammar(grammarDTO.getExplain_grammar());
        grammar.setExample(grammarDTO.getExample());
        grammar.setExample_meanning(grammarDTO.getExample_meanning());

        return grammarRepository.save(grammar);
    }

    public Grammar updateGrammar(int grammarId, GrammarDTO grammarDTO) {
        Grammar grammar = grammarRepository.findById(grammarId)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Grammar not found with id: " + grammarId));

        // Cập nhật thông tin ngữ pháp từ grammarDTO
        grammar.setStructure(grammarDTO.getStructure());
        grammar.setExplain_grammar(grammarDTO.getExplain_grammar());
        grammar.setExample(grammarDTO.getExample());
        grammar.setExample_meanning(grammarDTO.getExample_meanning());

        return grammarRepository.save(grammar);
    }

    public void deleteGrammar(int grammarId) {
        try {
            // Kiểm tra xem ngữ pháp có tồn tại không
            if (!grammarRepository.existsById(grammarId)) {
                throw new ResponseStatusException(HttpStatus.NOT_FOUND,
                        "Grammar not found with id: " + grammarId);
            }

            // Thực hiện xóa ngữ pháp
            grammarRepository.deleteById(grammarId);
        } catch (Exception ex) {
            // Xử lý các ngoại lệ khác ở đây nếu cần (ví dụ: lỗi cơ sở dữ liệu)
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Error deleting grammar");
        }
    }
    
}
