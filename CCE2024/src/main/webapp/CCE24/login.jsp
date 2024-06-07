<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리 동네 카페 탐험기 - 로그인 페이지</title>

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
					<h2>로그인</h2>
				</div>
				
				<div style="height:500px;">
					<% 
						String error = request.getParameter("error");
						if (error != null) {
							out.println("<script>");
							out.println("Swal.fire('로그인 실패!','아이디와 비밀번호를 한번 더 확인해 주세요.','error');");
							out.println("</script>");
						}
					%>
					<form class="form-signin" action="loginAction.jsp" method="post">
						<div id="inputUserID" class="input-group mb-3" style="width:200px;">
							<input type="text" class="form-control" id="userID" name="userID" placeholder="아이디">
						</div>
						<div id="inputPassword" class="input-group mb-3" style="width:200px;">
							<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호">
						</div>
						<div class="mb-3">
							<button type="submit" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:70px;">로그인</button>
						</div>
					</form>
				</div>
	
			</main>
		</div>
	</div>

<!-- 푸터 파트 -->
<%@ include file="footer.jsp" %>


</body>
</html>