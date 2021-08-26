package com.kimjinwoo.marondalgram.post.comment;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kimjinwoo.marondalgram.post.comment.bo.CommentBO;
import com.kimjinwoo.marondalgram.post.comment.model.Comment;

@Controller
@RequestMapping("/post")
public class CommentController {

	@Autowired
	private CommentBO commentBO;
	
	@GetMapping("/comment")
	public String comment(Model model
			, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		int postId = (Integer)session.getAttribute("postId");
		
		List<Comment> comments = commentBO.getComment(postId);
		model.addAttribute("comments", comments);
		
		return "post/timeline";
	}
}
