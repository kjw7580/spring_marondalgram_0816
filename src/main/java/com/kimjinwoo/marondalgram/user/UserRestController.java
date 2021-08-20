package com.kimjinwoo.marondalgram.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kimjinwoo.marondalgram.user.bo.UserBO;

@RestController
@RequestMapping("/user")
public class UserRestController {
	@Autowired
	private UserBO userBO;
	
	@PostMapping("/sign_up")
	public Map<String, String> signUp(
			@RequestParam("loginId") String loginId
			, @RequestParam("password") String password
			, @RequestParam("name") String name
			, @RequestParam("email") String email) {
		
		Map<String, String> result = new HashMap<>();
		int count = userBO.signUp(loginId, password, name, email);
		
		if(count == 1) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		
		return result;
	}
	
	@GetMapping("/is_duplicate_id")
	public Map<String, Boolean> isDuplicatedId(@RequestParam("loginId") String loginId) {
		
		Map<String, Boolean> result = new HashMap<>();
		
		if(userBO.isDuplicateId(loginId)) {
			result.put("is_duplicate", true);
		} else {
			result.put("is_duplicate", false);
		}
		
		// result.put("is_duplicate", userBO.isDuplicateId(loginId));
		
		return result;
	}
}