<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마론달 그램 - 타임라인</title>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>        
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
    
    <link rel="stylesheet" href="/static/css/style.css">
</head>
<body>
	<div id="wrap">
		<c:import url="/WEB-INF/jsp/include/header.jsp" />
		<section class="d-flex justify-content-center my-5">
			<div class="upload-box w-50 form-control">
				<!-- 사용자, 내용, 파일 업로드 -->
				
				<!--
				<div class="d-flex align-items-center">
					<label>사용자 : </label>
					<input type="text" class="form-control col-11 ml-3" id="userNameInput">
				</div>
				 -->
				 
				<textarea class="form-control" rows="5" id="contentInput" placeholder="내용을 입력해주세요."></textarea>
				<!-- MIME -->
				<div class="d-flex justify-content-between mt-3">
					<input type="file" accept="image/*" class="mt-2 d-none" id="fileInput" multiple>
					<a href="#" id="imageUploadBtn" class="ml-2"><i class="bi bi-images"></i></a>
					<button type="button" class="btn btn-success" id="saveBtn">업로드</button>
				</div>
			</div>
			
		</section>
		
		<c:forEach var="postWithComments" items="${postList }" varStatus="status">
			<div class="d-flex justify-content-center mb-5">
				<div class="content-box form-control">
					<div class="d-flex justify-content-between">
						<div class="font-weight-bold"><i class="bi bi-person-circle"></i> ${postWithComments.post.userName }</div>
						<div><i class="bi bi-three-dots"></i></div>
					</div>
					<hr>
					<div class="mt-2"><img src="${postWithComments.post.imagePath }"></div>
					
					<div class="d-flex mt-2">
						<i class="bi bi-heart"></i>
						<div class="font-weight-bold ml-2">좋아요 26개</div>
					</div>
					
					<div class="d-flex">
						<div class="font-weight-bold mr-2">${postWithComments.post.userName }</div>
						${postWithComments.post.content }
					</div>
					<small><fmt:formatDate value="${postWithComments.post.createdAt }" pattern="yyyy-MM-dd" /></small>
					<hr>
					<div class="font-weight-bold">댓글</div>
					<hr>
					<c:forEach var="comment" items="${postWithComments.commentList }" varStatus="status">
						<c:if test="${postWithComments.post.id eq comment.postId }">
							<div class="d-flex">
								<div class="font-weight-bold mr-2">${comment.userName }</div>
								<div>${comment.content }</div>
							</div>
						</c:if>
					</c:forEach>
					
					<div class="d-flex justify-content-between mt-2">
						<input type="text" class="form-control mr-1" placeholder="댓글 달기..." id="commentInput-${postWithComments.post.id }">
						<button type="button" class="btn btn-primary commentBtn" data-post-id="${postWithComments.post.id }">게시</button>
					</div>
				</div>
			</div>
		</c:forEach>
		
		<c:import url="/WEB-INF/jsp/include/footer.jsp" />
	</div>
	
	<script>
		$(document).ready(function() {
			$("#saveBtn").on("click", function() {
//				var userName = $("#userNameInput").val().trim();
				var content = $("#contentInput").val().trim();
				
//				if(userName == null || userName == "") {
//					alert("사용자를 입력하세요.");
//					return;
//				}
				
				if(content == null || content == "") {
					alert("내용을 입력하세요.");
					return;
				}
				
				if($("#fileInput")[0].files.length == 0) {
					alert("파일을 추가하세요.")
					return;
				}
				
				var formData = new FormData();
//				formData.append("userName", userName);
				formData.append("content", content);
				formData.append("file", $("#fileInput")[0].files[0]);
				
				$.ajax({
					enctype:"multipart/form-data",	// 파일 업로드 필수
					type:"post",
					url:"/post/create",
					processData:false,	// 파일 업로드 필수
					contentType:false,	// 파일 업로드 필수
					data:formData,
					success:function(data) {
						if(data.result == "success") {
							location.reload("/post/timeline");
							alert("글 쓰기 성공");
						} else {
							alert("글 쓰기에 실패했습니다!");
						}
					},
					error(e) {
						alert("error");
					}
						
				});
			});
			
			$("#imageUploadBtn").on("click", function() {
				$("#fileInput").click();
			});
			
			$(".commentBtn").on("click", function() {
				var postId = $(this).data("post-id");
				// $("#commentInput-1")
				var comment = $("#commentInput-" + postId).val().trim();
				
				if(comment == null || comment == "") {
					alert("내용을 입력하세요.");
					return;
				}
				
//	 			var formData = new FormData();
//				formData.append("postId", postId);
//				formData.append("content", content);
				
				$.ajax({
					type:"get",
					url:"/post/comment/create",
					data:{"postId":postId, "content":comment},
					success:function(data) {
						if(data.result == "success") {
							location.reload("/post/timeline");
							alert("댓글 쓰기 성공");
						} else {
							alert("댓글 쓰기에 실패했습니다!");
						}
					},
					error(e) {
						alert("error");
					}
					
				});
			});
		});
	</script>
</body>
</html>