<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<%@ include file="DBconn.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	/* COM */
	String userID=request.getParameter("userID");
	String mebType=request.getParameter("mebType");
	String password=request.getParameter("password");
	String userName=request.getParameter("userName");
	String gender=request.getParameter("gender");
	String birth=request.getParameter("birth");
	String email=request.getParameter("mailFront")+"@"+request.getParameter("mailEnd");
    System.out.println("mailFront: " + request.getParameter("mailFront"));
    System.out.println("mailEnd: " + request.getParameter("mailEnd"));
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
	String [] val2=request.getParameterValues("theme");
	String theme="";
	if(val2 !=null){
		for(int i=0;i<val2.length;i++){
			if(i==(val2.length-1)){
				theme+=val2[i];
			}else{
				theme+=val2[i]+",";
			}
		}
	}
	
	try{
		String sql="insert into CCE24MEMBER(userID, mebType, password, userName, gender, birth, email, phone, address, joinDate, cafeName, businessID, theme, postcode, extraAddr, detailAddr, preferDrk, preferDst) values(?,?,?,?,?,?,?,?,?,sysdate,?,?,?,?,?,?,?,?)";
		
		PreparedStatement pstmt=null;
		pstmt=conn.prepareStatement(sql);
		
		pstmt.setString(1, userID);
		pstmt.setString(2, mebType);
		pstmt.setString(3, password);
		pstmt.setString(4, userName);
		pstmt.setString(5, gender);
		pstmt.setString(6, birth);
		pstmt.setString(7, email);
		pstmt.setString(8, phone);
		pstmt.setString(9, address);
		pstmt.setString(10, cafeName);
		pstmt.setString(11, businessID);
		pstmt.setString(12, theme);
		pstmt.setString(13, postcode);
		pstmt.setString(14, extraAddr);
		pstmt.setString(15, detailAddr);
		pstmt.setString(16, preferDrk);
		pstmt.setString(17, preferDst);
	
		pstmt.executeUpdate();
		response.sendRedirect("memberResult.jsp?msg=1");
			
	}catch(Exception e){
		System.out.println("데이터베이스 읽기 오류");
		e.getStackTrace();
		System.out.println("SQL : "+e.getMessage());
	}
%>
