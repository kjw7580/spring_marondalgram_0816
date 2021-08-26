package com.kimjinwoo.marondalgram.post.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.kimjinwoo.marondalgram.post.dao.PostDAO;
import com.kimjinwoo.marondalgram.post.model.Post;
import com.kimjinwoo.marondalgram.user.common.FileManagerService;

@Service
public class PostBO {

	@Autowired
	private PostDAO postDAO;
	
	public int addPost(int userId, String userName, String content, MultipartFile file) {
		
		String filePath = null;
		if(file != null) {
			FileManagerService fileManager = new FileManagerService();
			
			filePath = fileManager.saveFile(userId, file);
			
			if(filePath == null) {
				return -1;
			}
		}
		
		return postDAO.insertPost(userId, userName, content, filePath);
	}
	
	public List<Post> getTimeline(int userId) {
		return postDAO.selectTimeline(userId);
	}
}
