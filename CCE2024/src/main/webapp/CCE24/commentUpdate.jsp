<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리 동네 카페 탐험기 - 댓글 수정 화면</title>

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
			
			<!-- 세션 정보 받아오기 -->
			<%
				sessionID=(String) session.getAttribute("sessionID");
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
			
			<%
				String commentID=request.getParameter("commentID");
				
				try{
					String sql="select userID,cPass,cText,boardID from CCE24COMMENT where commentID=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setString(1, commentID);
					rs=pstmt.executeQuery();
					
					if(rs.next()){
						String userID=rs.getString(1);
						String cPass=rs.getString(2);
						String cText=rs.getString(3);
						String boardID=rs.getString(4);
						
						if(userID.equals(sessionID)){
				
			%>
			
			<!-- 콘텐츠 본문 파트 -->
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-5 pb-2 mb-3 border-bottom page">
					<h2><span class="text-decoration-underline"><%=boardID %>번 추천글</span>의 <span class="text-decoration-underline"><%=commentID %>번 댓글</span> 수정</h2>
				</div>
				<div id="commentInsert" class="border rounded-3 p-3 mb-3">
					<form name="updComment" method="post" action="commentUpdAction.jsp?commentID=<%=commentID %>">
						<div class="d-inline-flex">
							<div id="sessionID" class="input-group mb-3 me-3" style="width:250px;height:30px;">
								<input type="text" class="form-control" name="userID" id="userID" value="<%=userID %>" readonly>
							</div>
							<div id="cPass" class="input-group mb-3 me-3" style="width:250px;height:30px;">
								<input type="password" class="form-control" name="cPass" id="cPass" placeholder="비밀번호 필수 입력">
							</div>
							<div id="cText" class="input-group mb-3 me-3">
								<textarea name="cText" class="form-control" style="width:400px;height:30px;" id="cText"><%=cText %></textarea>
							</div>
							<div class="mb-3">
								<input type="button" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:70px;" value="등록" onclick="checkCPass()">
							</div>
							<div class="mb-3">
								<input type="button" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:70px;" value="취소" onclick="history.back(-1)">
							</div>
						</div>
					<% 
						}else{
							%>
							<script>
								Swal.fire('작성자 확인 오류!',
										'추천글 작성자가 아닌 사람은 수정할 수 없습니다.',
										'warning').then(function() { history.back(-1); });
							</script>
					<%
						}}}catch(Exception e){
							System.out.println("테이블 읽기 오류");
							System.out.println("SQL:"+e.getMessage());		
						} 
					%>
					</form>
				</div>
			</main>
		</div>
	</div>


<!-- java script: 입력 확인 -->
<script>
	function checkCPass(){
		if(document.updComment.cPass.value==""){
			Swal.fire(
					'비밀번호 입력 오류!',
					"비밀번호를 입력해주세요.",
					'warning');
			document.updComment.cPass.focus();
			return false;
		}
		document.updComment.submit();
	}
</script>
		
<!-- 푸터 파트 -->
<%@ include file="footer.jsp" %>

</body>
</html>