<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리 동네 카페 탐험기 - 나의 탐험 정보</title>

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
					<h2><a href="myRecords.jsp" style="color:black;">나의 탐험 정보</a> > 내가 작성한 댓글 모아보기</h2>
				</div>
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
				<div style="height:500px;">
					<%
						int cnt=0;
						
						String sql="select count(*) from CCE24COMMENT where userID=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setString(1, sessionID);
						rs=pstmt.executeQuery();
						
						if(rs.next()){
							cnt=rs.getInt(1);
						}
						
					%>
					<div id="countBoard" class="mb-3">
						<span class="badge bg-primary fs-5">전체 <%=cnt %> 건</span>
					</div>
					<div id="boardTable">
						<table class="table table-hover text-center">
							<tr>
								<th>댓글 번호</th>
								<th>추천글 제목</th>
								<th>댓글</th>
								<th>작성일</th>
								<th>관리</th>
							</tr>
							<%
								try{
									sql="select a.commentID,b.title,a.cRegDate,a.cText,a.boardID from CCE24COMMENT a,CCE24BOARD b where a.userID=? and a.boardID=b.boardID order by commentID desc";
									pstmt=conn.prepareStatement(sql);
									pstmt.setString(1, sessionID);
									rs=pstmt.executeQuery();
									
									while(rs.next()){
										int commentID=rs.getInt(1);
										String title=rs.getString(2);
										String cRegDate=rs.getString(3);
										String cText=rs.getString(4);
										int boardID=rs.getInt(5);
										
										// 댓글 수를 가져오는 부분
			                            String sqlComment = "select count(*) from CCE24COMMENT where boardID=?";
			                            PreparedStatement pstmtComment = conn.prepareStatement(sqlComment);
			                            pstmtComment.setInt(1, boardID);
			                            ResultSet rsComment = pstmtComment.executeQuery();
			                            int cntCom = 0;
			                            if(rsComment.next()){
			                                cntCom = rsComment.getInt(1);
			                            }
			                            rsComment.close();
			                            pstmtComment.close();
										%>
			 						
							<tr>
								<td><%=commentID %></td>
								<td>
									<%=title %>
									<span><%="("+cntCom+")" %></span>
								</td>
								<td><%=cText %></td>
								<td><%=cRegDate %></td>
								<td>
									<input type="button" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:100px;" value="댓글 보러가기" onclick="location='boardView.jsp?boardID=<%=boardID %>#commentView'">
								</td>
							</tr>
							<% 
								}}catch(Exception e){
									System.out.println("22테이블 읽기 오류");
									System.out.println("SQL : "+e.getMessage());
								} 
							%>
						</table>
					</div>
				</div>
			</main>
		</div>
	</div>

<!-- 푸터 파트 -->
<%@ include file="footer.jsp" %>
</body>
</html>