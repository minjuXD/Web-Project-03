<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String sessionID = (String) session.getAttribute("sessionID");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

<!-- 부트스트랩 스타일 적용 -->
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/css.css">
<script src="../js/bootstrap.min.js"></script>

</head>
<body>

<%@ include file="DBconn.jsp" %>
<%
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String uID=sessionID;
	String mebtype="";
	
	try{
		String sql="select mebType from CCE24MEMBER where userID=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, uID);
		rs=pstmt.executeQuery();
		
		if(rs.next()){
			mebtype=rs.getString(1);	
		}
%>

<div class="mb-2">
<% 
	if(sessionID==null){
%>
	<button type="button" class="fs-6 p-1 ms-1 btn btn-outline-dark" style="width:70px;" onclick="location.href='login.jsp'">로그인</button>
	<button type="button" class="fs-6 p-1 ms-1 btn btn-outline-dark" style="width:70px;" onclick="location.href='memberInsert.jsp'">회원가입</button>
<%
	}else{
%>
	<p class="fs-5 p-1"> <%=mebtype.equals("exp") ? "🤠"+uID:"🐰"+uID %> 님<br>환영합니다!</p>
	<button type="button" class="fs-6 p-1 ms-1 btn btn-outline-dark" style="width:70px;" onclick="location.href='index.jsp'">홈</button>
	<button type="button" class="fs-6 p-1 ms-1 btn btn-outline-dark" style="width:70px;" onclick="location.href='boardInsert.jsp'">글쓰기</button>
	<button type="button" class="fs-6 p-1 ms-1 btn btn-outline-dark" style="width:70px;" onclick="location.href='logout.jsp'">로그아웃</button>
<% }
		}catch(Exception e){
			System.out.println("데이터베이스 읽기 실패");
			e.getStackTrace();
			System.out.println("SQL : "+e.getMessage());
		}
%>

</div>

</body>
</html>