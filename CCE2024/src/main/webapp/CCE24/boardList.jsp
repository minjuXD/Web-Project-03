<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리 동네 카페 탐험기 - 카페 탐방기</title>

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
					<h2>카페 탐방기</h2>
				</div>
				<div class="container">
					<%
						int cnt=0;
						
						String sql="select count(*) from CCE24BOARD";
						pstmt=conn.prepareStatement(sql);
						rs=pstmt.executeQuery();
						
						if(rs.next()){
							cnt=rs.getInt(1);
						}
						
					%>
					<div id="countBoard" class="mb-3">
						<span class="badge bg-primary fs-5 fw-normal">전체 <%=cnt %> 건</span>
					</div>
					<div id="boardTable">
						<table class="table table-hover text-center">
							<tr>
								<th>글 번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>조회수</th>
							</tr>
							<%
								try{
									sql="select a.boardID,a.title,a.userID,a.regDate,a.bView,b.mebType from CCE24BOARD a,CCE24MEMBER b where a.userID=b.userID order by boardID desc";
									pstmt=conn.prepareStatement(sql);
									rs=pstmt.executeQuery();
									
									while(rs.next()){
										int boardID=rs.getInt(1);
										String title=rs.getString(2);
										String userID=rs.getString(3);
										String regDate=rs.getString(4);
										String bView=rs.getString(5);
										String mebType=rs.getString(6);
										
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
								<td><%=boardID %></td>
								<td style="width:800px;">
									<a href="boardView.jsp?boardID=<%=boardID %>" style="color:black;"><%=title %></a>
									<span class="fw-semibold"><%="("+cntCom+")" %></span>
								</td>
								<td><%=mebType.equals("exp") ? "🤠"+userID:"🐰"+userID %></td>
								<td><%=regDate %></td>
								<td><%=bView %></td>
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
				<div class="container" style="width:500px;">
					<input type="button" class="fs-6 p-1 ms-2 btn btn-outline-dark fs-5 fw-semibold" style="width:200px;height:50px;" value="추천글 작성" onclick="location='boardInsert.jsp'">
				</div>
			</main>
		</div>
	</div>
<!-- 푸터 파트 -->
<%@ include file="footer.jsp" %>
</body>
</html>