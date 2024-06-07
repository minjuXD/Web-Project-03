<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<%@ include file="DBconn.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String PASS=request.getParameter("password"); //폼에서 가져온 패스워드
	String UID=request.getParameter("userID");  //폼에서 가져온 아이디
	System.out.print(UID);
	System.out.print(PASS);
	
	try{
		String sql="select password from CCE24MEMBER where userID=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, UID); //폼에서 가져온 아이디(UID)를 데이터베이스에 매칭
		rs=pstmt.executeQuery();
		
		if(rs.next()){
			String password=rs.getString(1); //데이터베이스에서 가져온 패스워드
			
			if(PASS.equals(password)){ //폼의 패스워드(PASS)가 데이터베이스의 패스워드(password)와 일치하는가
				sql="delete from CCE24MEMBER where userID=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, UID);
				pstmt.executeQuery();
				
				//댓글 수정 완료
				response.sendRedirect("memberResult.jsp"); 
			}else{
				//비밀번호 오류
				response.sendRedirect("memberResult.jsp?msg=3");
			}
		}else{
			response.sendRedirect("memberResult.jsp?msg=4");
		}
	}catch(Exception e){
		System.out.println("데이터베이스 읽기 실패");
		e.getStackTrace();
		System.out.println("SQL : "+e.getMessage());
	}
%>