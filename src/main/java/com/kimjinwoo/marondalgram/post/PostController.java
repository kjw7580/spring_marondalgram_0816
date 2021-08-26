package com.kimjinwoo.marondalgram.post;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kimjinwoo.marondalgram.post.bo.PostBO;
import com.kimjinwoo.marondalgram.post.model.Post;

@Controller
@RequestMapping("/post")
public class PostController {
	
	@Autowired
	private PostBO postBO;
	
	@GetMapping("/timeline")
	public String timeline(Model model
			, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		
		int userId = (Integer)session.getAttribute("userId");
		
		List<Post> timeline = postBO.getTimeline(userId);
		model.addAttribute("timeline", timeline);
		
		return "post/timeline";
	}
	
}
