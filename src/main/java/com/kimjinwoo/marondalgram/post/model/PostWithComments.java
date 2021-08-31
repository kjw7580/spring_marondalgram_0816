package com.kimjinwoo.marondalgram.post.model;

import java.util.List;

import com.kimjinwoo.marondalgram.post.comment.model.Comment;

public class PostWithComments {
	
	private Post post;
	private List<Comment> commentList;
	
	public Post getPost() {
		return post;
	}
	public void setPost(Post post) {
		this.post = post;
	}
	public List<Comment> getCommentList() {
		return commentList;
	}
	public void setCommentList(List<Comment> commentList) {
		this.commentList = commentList;
	}
	
}
