<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리 동네 카페 탐험기 - 댓글 관리 페이지</title>

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
					<h2></h2>
				</div>
				<div style="height:500px;">
				<%
					String msg=request.getParameter("msg");
					String boardID=request.getParameter("boardID");
					System.out.println(boardID);
					
					if (msg != null){ 
						
						//댓글 수정 완료
						if (msg.equals("0"))
							out.println("<script>Swal.fire('댓글 수정 완료!','댓글이 무사히 수정되었습니다.','success').then(function() { location.href='boardList.jsp'; });</script>");
							
						//댓글 삭제 완료
						else if (msg.equals("1")) 
							out.println("<script>Swal.fire('댓글 삭제 완료!','댓글이 무사히 삭제되었습니다.','success').then(function() { location.href='boardList.jsp'; });</script>");
						
						//비밀번호 오류
						else if (msg.equals("2")) { 
							out.println("<script>Swal.fire('비밀번호 입력 오류!','비밀번호가 틀렸습니다.','warning').then(function() { history.back(-1); });</script>");
						}
						
						//비밀번호, 내용 미기재
						else if (msg.equals("3")) { 
							out.println("<script>Swal.fire('내용 미기재 오류!','비밀번호 또는 내용을 적지 않으셨습니다.','warning').then(function() { history.back(-1); });</script>");
						}
						
					}else { 
						//잘못된 접근
						out.println("<script>Swal.fire('잘못된 접근!','뭔가 잘못된 모양입니다.. 다시 시도해보세요.','warning').then(function() { location.href='boardList.jsp'; });</script>");
					}
					
				%>
				</div>

			</main>
		</div>
	</div>

<!-- 푸터 파트 -->
<%@ include file="footer.jsp" %>
</body>
</html>