<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.*" %>
<%@ include file="DBconn.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	/* COM */
	String userID=request.getParameter("userID");
	String mebType=request.getParameter("mebType");
	String PASS=request.getParameter("password");	//폼에서 가져온 비밀번호
	String userName=request.getParameter("userName");
	String gender=request.getParameter("gender");
	String birth=request.getParameter("birth");
	String email=request.getParameter("mailFront")+"@"+request.getParameter("mailEnd");
	String phone=request.getParameter("phone");
	String postcode=request.getParameter("sample6_postcode");
	String address=request.getParameter("sample6_address");
	String detailAddr=request.getParameter("sample6_detailAddress");
	String extraAddr=request.getParameter("sample6_extraAddress");
	
	String [] val1=request.getParameterValues("preferDrk");
	String preferDrk="";
	if(val1 !=null){
		for(int i=0;i<val1.length;i++){
			if(i==(val1.length-1)){
				preferDrk+=val1[i];
			}else{
				preferDrk+=val1[i]+",";
			}
		}
	}else{
		preferDrk="0";
	}
	
	String [] val3=request.getParameterValues("preferDst");
	String preferDst="";
	if(val3 !=null){
		for(int i=0;i<val3.length;i++){
			if(i==(val3.length-1)){
				preferDst+=val3[i];
			}else{
				preferDst+=val3[i]+",";
			}
		}
	}else{
		preferDst="0";
	}
	
	/* NAT */
	String cafeName=request.getParameter("cafeName");
	String businessID=request.getParameter("businessID");
	String theme=request.getParameter("theme");

	try{
		//비밀번호 확인
		String sql="select password from CCE24MEMBER where userID=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, userID);
		rs=pstmt.executeQuery();
		
		if(rs.next()){
			String password=rs.getString(1);
			
			if(PASS.equals(password)){
				sql="update CCE24MEMBER set password=?,userName=?,gender=?,birth=?,email=?,phone=?,address=?,cafeName=?,businessID=?,theme=?,postcode=?,extraAddr=?,detailAddr=?,preferDrk=?,preferDst=? where userID=?";
				pstmt=conn.prepareStatement(sql);
				
				pstmt.setString(1, password);
				pstmt.setString(2, userName);
				pstmt.setString(3, gender);
				pstmt.setString(4, birth);
				pstmt.setString(5, email);
				pstmt.setString(6, phone);
				pstmt.setString(7, address);
				pstmt.setString(8, cafeName);
				pstmt.setString(9, businessID);
				pstmt.setString(10, theme);
				pstmt.setString(11, postcode);
				pstmt.setString(12, extraAddr);
				pstmt.setString(13, detailAddr);
				pstmt.setString(14, preferDrk);
				pstmt.setString(15, preferDst);
				pstmt.setString(16, userID);
				
				pstmt.executeUpdate();
				
				//회원 정보 수정 완료
				response.sendRedirect("memberResult.jsp?msg=0");
			}else{
				//비밀번호 오류
				response.sendRedirect("memberResult.jsp?msg=3");
			}
		}else{
			response.sendRedirect("memberResult.jsp?msg=4");
		}
	}catch(Exception e){
		System.out.println("데이터베이스 읽기 오류");
		e.getStackTrace();
		System.out.println("SQL : "+e.getMessage());
	}
%>
