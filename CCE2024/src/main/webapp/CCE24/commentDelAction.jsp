<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<%@ include file="DBconn.jsp" %>
<%
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String pass=request.getParameter("cPass"); //폼에서 가져온 패스워드
	String comID=request.getParameter("commentID");  //폼에서 가져온 코멘트아이디
	System.out.print(comID);
	
	try{
		String sql="select commentID,cPass from CCE24comment where commentID=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, comID); //폼에서 가져온 아이디(comID)를 데이터베이스에 매칭
		rs=pstmt.executeQuery();
		
		if(rs.next()){
			String commentID=rs.getString(1); //데이터베이스에서 가져온 코멘트아이디
			String cPass=rs.getString(2); //데이터베이스에서 가져온 패스워드
			if(pass.equals(cPass)){ //폼의 패스워드(pass)가 데이터베이스의 패스워드(cPass)와 일치하는가
				
				//원래 그냥 삭제 할려고 했는데, 대댓글 있으면 복잡해질테니, 댓글 내용을 삭제하는 걸로
				/* sql="delete from CCE24COMMENT where commentID=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, commentID);
				pstmt.executeQuery(); */
				
				//내용, 아이디, 날짜 업데이트 
				String delComment="삭제된 댓글입니다.";
				
				sql="update CCE24COMMENT set cText=? where commentID=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, delComment);
				pstmt.setString(2, commentID);
				pstmt.executeUpdate();
				
				//댓글 삭제 완료
				response.sendRedirect("commentResult.jsp?msg=1");
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