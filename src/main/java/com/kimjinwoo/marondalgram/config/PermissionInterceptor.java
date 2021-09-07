package com.kimjinwoo.marondalgram.config;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

@Component
public class PermissionInterceptor implements HandlerInterceptor {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws IOException {
		
		// 로그인이 되어 있지 않을때, post 페이지 이동을 막는다
		HttpSession session = request.getSession();
		
		// 현재 path 알아 오기
		String uri = request.getRequestURI();
		
		// 로그인이 안된 상태
		if(session.getAttribute("userId") == null) {
			// /post/**
			// /post 로 시작하는 페이즈 못가도록
			if(uri.startsWith("/post")) {
				// 로그인 페이지로 이동
				response.sendRedirect("/user/signin_view");
				return false;
			}
		} else {	// 로그인이 된 상태
			// /user/**
			// /user로 시작하는 페이지
			if(uri.startsWith("/user")) {
				// 리스트 페이지로 이동
				response.sendRedirect("/post/timeline");
				return false;
			}
		}
		
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request
			, HttpServletResponse response
			, Object handler
			, ModelAndView modelAndView) {
		
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request
			, HttpServletResponse response
			, Object handler
			, Exception ex) {
		
	}
}
