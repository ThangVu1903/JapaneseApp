package com.japanese.nihongobase.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.japanese.nihongobase.entity.Score;

@Repository
public interface ScoreRepository extends JpaRepository<Score,Integer> {
    @Query(value = "SELECT u.username, MAX(s.total_score) as max_score " +
                   "FROM score s JOIN user u ON s.user_id = u.user_id " +
                   "WHERE s.lesson_id = ?1 " +
                   "GROUP BY u.username " +
                   "ORDER BY max_score DESC", nativeQuery = true)
    List<Object[]> findHighestUserScoresByLessonId(Integer lessonId);
}
