<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.File" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="DBconn.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String sql="";
	
	String sortArea=request.getParameter("sortArea");
	String sortTheme=request.getParameter("sortTheme");
	
	if (sortArea.equals("total")||sortArea==null) {
        response.sendRedirect("boardListArea.jsp");
    }else{
    	response.sendRedirect("boardListArea.jsp?sortArea=" + sortArea);
    }


%>