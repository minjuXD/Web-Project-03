<%@page import="java.sql.*"%>
<%@page import="oracle.jdbc.proxy.annotation.Pre"%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리 동네 카페 탐험기 - 건의사항</title>

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
table th{
	text-align:center;
}
.rpl{
	display:none;
}
.textpre{
    font-family: 'Dovemayo_gothic';
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
			
			<!-- 글 정보 불러오기 -->
			<%
				String sql="";
				int suggestID=Integer.parseInt(request.getParameter("suggestID"));
				
				try{
					sql="select a.stitle,a.userID,a.sregDate,a.scontent,a.sView,a.fileName,b.mebType "+
							"from CCE24SUGGEST a,CCE24MEMBER b where a.userID=b.userID and a.suggestID=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setInt(1, suggestID);
					rs=pstmt.executeQuery();
					
					if(rs.next()){
			 			String title=rs.getString(1);	
						String userID=rs.getString(2);	
						String regDate=rs.getString(3);	
						String content=rs.getString(4);
						int sView=rs.getInt(5);
						String fileName=rs.getString(6);
						String mebType=rs.getString(7);
						sView++;
			%>
			
			<!-- 콘텐츠 본문 파트 -->
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-5 pb-2 mb-3 border-bottom page">
					<h2><a href="boardList.jsp" style="color:black;">건의사항 게시판</a> > <%=suggestID %>번 건의사항</h2>
				</div>
				<div id="originalBoard" class="container mb-5">
					<table class="table">
						<tr>
							<th>글 번호</th>
							<td><%=suggestID %></td>
						</tr>
						<tr>
							<th>작성자</th>
							<td><%=mebType.equals("exp") ? "🤠"+userID:"🐰"+userID %></td>
						</tr>
						<tr>
							<th>작성일</th>
							<td><%=regDate %></td>
						</tr>
						<tr>
							<th>제목</th>
							<td class="fw-bolder ps-2"><%=title %></td>
						</tr>
						<tr>
							<td colspan="2">
								<img src="<%=request.getContextPath() %>/CCE24/upload/<%=fileName %>" class="ps-5" style="width:500px;"><br><br>
								<pre class="ps-5 textpre"><%=content %></pre>
							</td>
						</tr>
						
						<tr>
							<td colspan="2">
								<input type="button" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:70px;" value="글쓰기" onclick="location='suggestInsert.jsp'">
								<input type="button" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:70px;" value="목록" onclick="location='suggestList.jsp'">
								<input type="button" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:70px;" value="삭제" onclick="location='suggestDelete.jsp?suggestID=<%=suggestID %>'">	
							</td>
						</tr>
					<%
						sql="update CCE24SUGGEST set sView=? where suggestID=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setInt(1, sView);
						pstmt.setInt(2, suggestID);
						pstmt.executeUpdate();
					}}catch(Exception e){
						System.out.println("데이터베이스 읽기 오류");
						e.getStackTrace();
						System.out.println("SQL:"+e.getMessage());
					}
					%>
					</table>	
				</div>

			</main>
		</div>
	</div>

<!-- 푸터 파트 -->
<%@ include file="footer.jsp" %>

</body>
</html>