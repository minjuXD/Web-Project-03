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
	
	String sortTheme=request.getParameter("sortTheme");
	
	if (sortTheme.equals("total")||sortTheme==null) {
        response.sendRedirect("boardListTheme.jsp");
    }else{
    	response.sendRedirect("boardListTheme.jsp?sortTheme=" + sortTheme);
    }


%>