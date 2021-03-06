package com.kimjinwoo.marondalgram.user.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.kimjinwoo.marondalgram.user.model.User;

@Repository
public interface UserDAO {
	
	public int insertUser(
			@Param("loginId") String loginId
			, @Param("password") String password
			, @Param("name") String name
			, @Param("email") String email);
	
	public int selectCountById(@Param("loginId") String loginId);
	
	public User selectUserByIdPassword(
			@Param("loginId") String loginId
			, @Param("password") String password);
}
