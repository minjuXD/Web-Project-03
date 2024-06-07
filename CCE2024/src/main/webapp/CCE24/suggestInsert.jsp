<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리 동네 카페 탐험기 - 건의사항 작성</title>

<!-- 부트스트랩 스타일 적용 -->
<script src="../js/bootstrap.min.js"></script>
<script src="../js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/bootstrap.custom.css?after">

<style type="text/css">
.page{
	margin-top:50px;
}
.page2{
	position: sticky;
    top: 100px;
}
</style>

</head>

<body>

<!-- 네비 파트 -->
	<div class="container">
		<%@ include file="nav.jsp" %>
	</div>
	
<!-- 콘텐츠 파트 -->
	<div class="container-fluid">
		<div class="row">
			<!-- 콘텐츠 좌측 고정 파트 -->
			<nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse sidebar">
				<div class="position-sticky pt-3 border text-center page page2">
					<div class="nav flex-column mb-3">
						<!-- 로그인 인포 파트 -->
						<%@ include file="logInfo.jsp" %>
					</div>
					<div class="nav flex-column mb-2">
						<!-- 대표 이미지 파트 -->
						<%@ include file="repImg.jsp" %>
					</div>
				</div>
			</nav>
			<!-- 콘텐츠 본문 파트 -->
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-5 pb-2 mb-3 border-bottom page">
					<h2>건의 사항 작성</h2>
				</div>
				<!-- 세션 정보 받아오기 -->
				<%
					sessionID=(String) session.getAttribute("sessionID");
					String sessionName=(String) session.getAttribute("sessionName");
					if(sessionID==null){
				%>
				<script>
					Swal.fire(
						'로그인 오류!',
						"먼저 로그인을 해주세요.",
						'error').then(function() { location.href='login.jsp'; });
				</script>
					<%
						}
					%>
				<div>
					<form name="newboard" action="suggestInsAction.jsp" method="post" enctype="multipart/form-data">
						<input type="hidden" class="form-control" name="userName" id="userName" value="<%=sessionName %>">
						<div id="sUser" class="input-group mb-3" style="width:200px;">
							<input type="text" class="form-control" name="userID" id="userID" value="${sessionID}" readonly>
						</div>
						<div id="sPass" class="input-group mb-3" style="width:200px;">
							<input type="password" class="form-control" name="sPass" id="sPass" placeholder="password">
						</div>
						<div id="sTitle" class="input-group mb-3">
							<input type="text" class="form-control" name="sTitle" id="sTitle" placeholder="Title">
						</div>
						<div id="sContent" class="input-group mb-3">
							<textarea class="form-control" rows="10" cols="100" name="sContent" id="sContent" class="textarea"></textarea>
						</div>
						<div id="bdFile" class="input-group mb-3" style="width:500px;">
							<input type="file" class="form-control" name="fileName" id="fileName">
						</div>
						<div class="mb-3">
							<input type="button" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:70px;" value="등록" onclick="checkBoard()" class="btn-send">
							<input type="reset" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:70px;" value="취소">
						</div>
					</form>
				</div>
	
			</main>
		</div>
	</div>

<!-- 푸터 파트 -->
<%@ include file="footer.jsp" %>

<!-- java script: 입력 확인 -->
<script>
	function checkBoard(){
		if(document.newboard.sPass.value==""){
			Swal.fire(
					'비밀번호 입력 오류!',
					"비밀번호를 입력해주세요.",
					'warning');
			document.newboard.sPass.focus();
			return false;
		}
		if(document.newboard.sTitle.value==""){
			Swal.fire(
					'제목 입력 오류!',
					"제목을 입력해주세요.",
					'warning');
			document.newboard.sTitle.focus();
			return false;
		}
		if(document.newboard.sContent.value==""){
			Swal.fire(
					'본문 입력 오류!',
					"본문을 입력해주세요.",
					'warning');
			document.newboard.sContent.focus();
			return false;
		}
		
        document.newboard.submit();
	}
	
</script>

</body>
</html>