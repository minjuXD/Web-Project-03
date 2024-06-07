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
	String pass=request.getParameter("cPass"); //폼에서 가져온 패스워드
	String comID=request.getParameter("commentID");  //폼에서 가져온 코멘트아이디
	
	try{
		String sql="select commentID,cPass,boardID from CCE24comment where commentID=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, comID); //폼에서 가져온 아이디(comID)를 데이터베이스에 매칭
		rs=pstmt.executeQuery();
		
		if(rs.next()){
			String commentID=rs.getString(1); //데이터베이스에서 가져온 코멘트아이디
			String cPass=rs.getString(2); //데이터베이스에서 가져온 패스워드
			String boardID=rs.getString(3);
			if(pass.equals(cPass)){ //폼의 패스워드(pass)가 데이터베이스의 패스워드(cPass)와 일치하는가
				sql="update CCE24COMMENT set cText=? where commentID=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, request.getParameter("cText"));
				pstmt.setString(2, commentID);
				pstmt.executeUpdate();
				//댓글 수정 완료
				response.sendRedirect("commentResult.jsp?msg=0&boardID="+boardID); 
			}else{
				//비밀번호 오류
				response.sendRedirect("commentResult.jsp?msg=2");
			}
		}else{
			response.sendRedirect("commentResult.jsp");
		}
	}catch(Exception e){
		System.out.println("데이터베이스 읽기 실패");
		e.getStackTrace();
		System.out.println("SQL : "+e.getMessage());
	}
%>