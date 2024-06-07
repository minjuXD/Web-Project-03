<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<%@ include file="DBconn.jsp" %>
<%
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String PASS=request.getParameter("sPass"); //폼에서 가져온 패스워드
	String sgtID=request.getParameter("suggestID");  //폼에서 가져온 보드아이디
	
	try{
		String sql="select suggestID,sPass from CCE24SUGGEST where suggestID=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, sgtID); //폼에서 가져온 아이디(bodID)를 데이터베이스에 매칭
		rs=pstmt.executeQuery();
		
		if(rs.next()){
			String suggestID=rs.getString(1); //데이터베이스에서 가져온 보드아이디
			String sPass=rs.getString(2); //데이터베이스에서 가져온 패스워드
			if(PASS.equals(sPass)){ //폼의 패스워드(pass)가 데이터베이스의 패스워드(boardPass)와 일치하는가
				sql="delete from CCE24SUGGEST where suggestID=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, suggestID);
				pstmt.executeQuery();
				//댓글 삭제 완료
				response.sendRedirect("suggestResult.jsp");
			}else{
				//비밀번호 오류
				response.sendRedirect("suggestResult.jsp?msg=3");
			}
		}else{
			response.sendRedirect("suggestResult.jsp?msg=2");
		}
	}catch(Exception e){
		System.out.println("데이터베이스 읽기 실패");
		e.getStackTrace();
		System.out.println("SQL : "+e.getMessage());
	}
%>