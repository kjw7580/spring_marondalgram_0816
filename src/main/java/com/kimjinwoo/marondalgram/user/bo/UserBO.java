package com.kimjinwoo.marondalgram.user.bo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kimjinwoo.marondalgram.user.common.EncryptUtils;
import com.kimjinwoo.marondalgram.user.dao.UserDAO;
import com.kimjinwoo.marondalgram.user.model.User;

@Service
public class UserBO {
	@Autowired
	private UserDAO userDAO;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	public int signUp(String loginId, String password, String name, String email) {
		
		String encryptPassword = EncryptUtils.md5(password);
		
		if(encryptPassword.equals("")) {
			logger.error("[UserBO signUP] 암호화 실패!!!!!!!!!!");
			return 0;
		}
		
		return userDAO.insertUser(loginId, encryptPassword, name, email);
	}
	
	public boolean isDuplicateId(String loginId) {
		if(userDAO.selectCountById(loginId) == 0) {
			return false;
		} else {
			return true;
		}
		
		// return (userDAO.selectCountById(loginId) != 0);
	}
	
	public User signIn(String loginId, String password) {
		// 비밀번호를 암호화 하고 DAO 로 전달한다.
		String encryptPassword = EncryptUtils.md5(password);
		
		return userDAO.selectUserByIdPassword(loginId, encryptPassword);
	}
}
