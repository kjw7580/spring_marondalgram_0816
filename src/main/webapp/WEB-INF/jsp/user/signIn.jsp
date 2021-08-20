<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마론달그램 - 로그인</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>        
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
    
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>
	<div id="wrap">
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
		<section class="content d-flex justify-content-center">
			<div class="login-box h-100 d-flex justify-content-center align-items-center">
				<div class="w-100">
					<div class="logo d-flex form-control justify-content-center align-items-center"><h1>Marondalgram</h1></div>
					<input type="text" id="loginIdInput" class="form-control mt-3" placeholder="전화번호, 사용자 이름 또는 이메일">
					<input type="password" id="passwordInput" class="form-control mt-3" placeholder="비밀번호">
					<button id="loginBtn" type="submit" class="btn btn-primary btn-block mt-3 font-weight-bold">로그인</button>
					<br><hr><br>
					<div class="text-center font-weight-bold"><a href="#">Marondalbook으로 로그인</a></div>
					<div class="text-center mt-3">비밀번호를 잊으셨나요?</div>
					<div class="text-center"><a href="#">비밀번호 찾기</a></div>
					<div class="join-box d-flex justify-content-center align-items-center mt-3">
						<div>계정이 없으신가요?</div>
						<div class="join font-weight-bold"><a href="/user/signup_view">가입하기</a></div>
					</div>
				</div>
			</div>
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div>
	
	<script>
		$(document).ready(function() {
			
			$("#loginBtn").on("click", function() {
				var loginId = $("#loginIdInput").val();
				var password = $("#passwordInput").val();
				
				if(loginId == null || loginId == "") {
					alert("아이디를 입력해주세요.");
					return;
				}
				
				if(password == null || password == "") {
					alert("비밀번호를 입력해주세요.");
					return;
				}
				
			});
		});
	</script>
</body>
</html>