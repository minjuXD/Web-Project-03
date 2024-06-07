<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<%@ include file="DBconn.jsp" %>
<%
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String pass=request.getParameter("boardPass"); //폼에서 가져온 패스워드
	String bodID=request.getParameter("boardID");  //폼에서 가져온 보드아이디
	
	try{
		String sql="select boardID,boardPass from CCE24BOARD where boardID=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, bodID); //폼에서 가져온 아이디(bodID)를 데이터베이스에 매칭
		rs=pstmt.executeQuery();
		
		if(rs.next()){
			String boardID=rs.getString(1); //데이터베이스에서 가져온 보드아이디
			String boardPass=rs.getString(2); //데이터베이스에서 가져온 패스워드
			if(pass.equals(boardPass)){ //폼의 패스워드(pass)가 데이터베이스의 패스워드(boardPass)와 일치하는가
				sql="delete from CCE24BOARD where boardID=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, boardID);
				pstmt.executeQuery();
				
				//글 삭제시 댓글도 삭제
				sql="delete from CCE24COMMENT where boardID=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, boardID);
				pstmt.executeQuery();
				
				//댓글 삭제 완료
				response.sendRedirect("boardResult.jsp");
			}else{
				//비밀번호 오류
				response.sendRedirect("boardResult.jsp?msg=3");
			}
		}else{
			response.sendRedirect("boardResult.jsp?msg=2");
		}
	}catch(Exception e){
		System.out.println("데이터베이스 읽기 실패");
		e.getStackTrace();
		System.out.println("SQL : "+e.getMessage());
	}
%>