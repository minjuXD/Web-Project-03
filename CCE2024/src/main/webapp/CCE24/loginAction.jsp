<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<%@ include file="DBconn.jsp" %>
<%
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	
	//폼에서 가져오는 id,pw
	String userID = request.getParameter("userID");
	String password = request.getParameter("password");
	
	//데이터베이스에서 가져올 pw,name
	String PASS="";
	String NAME="";
	
	try {
		String sql = "select password,userName from CCE24MEMBER where userID=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userID);
		rs=pstmt.executeQuery();
		
		if (rs.next()) {
			PASS = rs.getString(1);
			NAME= rs.getString(2);
			
			if (password.equals(PASS)) {
				session.setAttribute("sessionID", userID);
				session.setAttribute("sessionName", NAME);
				response.sendRedirect("memberResult.jsp?msg=2");
			}else {
				response.sendRedirect("login.jsp?error=1");
			}
		}else {
			response.sendRedirect("login.jsp?error=1");
		}
	}catch (Exception e) {
		e.printStackTrace();
	}
%>