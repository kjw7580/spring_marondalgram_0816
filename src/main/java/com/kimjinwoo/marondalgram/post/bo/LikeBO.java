package com.kimjinwoo.marondalgram.post.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimjinwoo.marondalgram.post.dao.LikeDAO;

@Service
public class LikeBO {

	@Autowired
	private LikeDAO likeDAO;
	
	public boolean existLike(int postId, int userId) {
		int count = likeDAO.selectCountLike(postId, userId);
		
		if(count >=1) {
			return true;
		} else {
			return false;
		}
	}
	
	// 좋아요 상태가 되면 true, 좋아요 취소상태가 되면 false
	public boolean like(int postId, int userId) {
		
		// 만약 해당 포스트에 좋아요가 되어 있다면, 좋아요 취소
		if(this.existLike(postId, userId)) {
			likeDAO.deleteLike(postId, userId);
			return false;
		} else {	// 만약 해당 포스트에 좋아요가 안되어 있다면, 좋아요
			likeDAO.insertLike(postId, userId);
			return true;
		}
	}
	
	// 좋아요 갯수
	public int countLike(int postId) {
		return likeDAO.selectCountLikeByPostId(postId);
	}
	
	public int deleteLike(int postId) {
		return likeDAO.deleteLikeByPostId(postId);
	}

}
