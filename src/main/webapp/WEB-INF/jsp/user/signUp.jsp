<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마론달그램 - 회원가입</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>        
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
    
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>
	<div id="wrap">
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
		<section class="content d-flex justify-content-center my-5">
			<div class="login-box h-100 d-flex justify-content-center align-items-center">
				<div class="w-100">
					<div class="logo d-flex form-control justify-content-center align-items-center"><h1>Marondalgram</h1></div>
					<form method="post" action="/user/sign_up" id="signupForm">
						<div class="d-flex mt-3">
							<input type="text" id="loginIdInput" name="loginId" class="form-control" placeholder="아이디">
							<button type="button" class="btn btn-info ml-1" id="isDuplicateBtn">중복확인</button>
						</div>
						<div class="d-none" id="duplicateDiv"><small class="text-danger">중복된 ID입니다.</small></div>
						<div class="d-none" id="noneDuplicateDiv"><small class="text-success">사용 가능한 ID입니다.</small></div>
						<input type="password" id="passwordInput" name="password" class="form-control mt-3" placeholder="비밀번호">
						<input type="password" id="passwordConfirmInput" class="form-control mt-3" placeholder="비밀번호 확인">
						<small id="errorPassword" class="text-danger d-none">비밀번호가 일치하지 않습니다.</small>
						<small id="successPassword" class="text-success d-none">비밀번호가 일치합니다.</small>
						<input type="text" id="nameInput" name="name" class="form-control mt-3" placeholder="이름">
						<input type="text" id="emailInput" name="email" class="form-control mt-3" placeholder="이메일 주소">
						<button id="signUpBtn" type="submit" class="btn btn-primary btn-block mt-3 font-weight-bold">가입</button>
						
						<div class="join-box d-flex justify-content-center align-items-center mt-3 form-control">
							<div>계정이 있으신가요?</div>
							<div class="join font-weight-bold"><a href="/user/signin_view">로그인</a></div>
						</div>
					</form>
				</div>
			</div>
		</section>
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div>
	
	<script type="text/javascript">
		$(document).ready(function() {
			
			var isIdCheck = false;
			var isDuplicateId = true;
			
			$("#signupForm").on("submit", function(e) {
				
				e.preventDefault();
				
				var loginId = $("#loginIdInput").val();
				var password = $("#passwordInput").val();
				var passwordConfirm = $("#passwordConfirmInput").val();
				var name = $("#nameInput").val().trim();
				var email = $("#emailInput").val().trim();
				
				if(loginId == null || loginId == "") {
					alert("아이디를 입력해주세요.");
					return;
				}
				
				if(password == null || password == "") {
					alert("비밀번호를 입력해주세요.");
					return;
				}
				
				if(password != passwordConfirm) {
					$("#errorPassword").removeClass("d-none");
					$("#successPassword").addClass("d-none");
					return;
				}
				
				if(password == passwordConfirm) {
					$("#successPassword").removeClass("d-none");
					$("#errorPassword").addClass("d-none");
				}
				
				if(name == null || name == "") {
					alert("이름을 입력해주세요.");
					return;
				}
				
				if(email == null || email == "") {
					alert("이메일을 입력해주세요.");
					return;
				}
				
				// 중복체크 했는지?
				if(isIdCheck == false) {
					alert("중복체크를 진행하세요");
					return ;
				}
						
				// 중복이 되었는지 안되었는지?
				if(isDuplicate == true) {
					alert("아이디가 중복되었습니다.");
					return ;
				}
				
				$.ajax({
					type:"post",
					url:"/user/sign_up",
					data:{"loginId":loginId, "password":password, "name":name, "email":email},
					success:function(data) {
						if(data.result == "success") {
							location.href="/user/signin_view";
							
						} else {
							alert("회원 가입 실패");
						}
					}, 
					error:function(e) {
						alert("회원 가입 실패");
					}
					
					
				});
			});
			
			$("#isDuplicateBtn").on("click", function() {
				
				var loginId = $("#loginIdInput").val();
				
				if(loginId == null || loginId == "") {
					alert("아이디를 입력하세요");
					return ;
				}
				
				$.ajax({
					type:"get",
					url:"/user/is_duplicate_id",
					data:{"loginId":loginId},
					success:function(data) {
						isIdCheck = true;
						
						if(data.is_duplicate) {
							isDuplicate = true;
							$("#duplicateDiv").removeClass("d-none");
							$("#noneDuplicateDiv").addClass("d-none");
						} else {
							isDuplicate = false;
							$("#duplicateDiv").addClass("d-none");
							$("#noneDuplicateDiv").removeClass("d-none");
						}
						//isDuplicate = data.is_duplicate;
						
					},
					error:function(e){
						alert("중복확인 실패");
					}
					
					
				});
				
			});
		});
	
	</script>
</body>
</html>