package com.kimjinwoo.marondalgram.post.comment.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.kimjinwoo.marondalgram.post.comment.model.Comment;

@Repository
public interface CommentDAO {
	
	public int insertComment(
			@Param("userId") int userId
			, @Param("userName") String userName
			, @Param("postId") int postId
			, @Param("content") String content);
	
	public List<Comment> selectCommentByPostId(
			@Param("postId") int postId);
	
	public int deleteComment(@Param("postId") int postId);
	
}
