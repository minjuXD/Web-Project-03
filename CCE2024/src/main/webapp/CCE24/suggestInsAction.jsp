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
	int suggestID=0;
	
	sql="select max(suggestID) from CCE24SUGGEST";
	pstmt=conn.prepareStatement(sql);
	rs=pstmt.executeQuery();
	
	if(rs.next()){
		suggestID=rs.getInt(1)+1;
	}else{
		suggestID=1;
	}
	
	String fileName=""; 
	String realFolder="C:\\workspace2024\\CCE2024\\src\\main\\webapp\\CCE24\\upload";
	String encType="utf-8";   //인코딩 타입
	int maxSize=5*1024*1024;   //최대 업로드 파일 크기: 5Mb
	MultipartRequest multi = new MultipartRequest(request,realFolder,maxSize,encType, new DefaultFileRenamePolicy());
	
	// boardInsert.jsp에서 enctype="multipart/form-data"를 넣어준거때문에
	// request.getParameter로 값이 넘어오지 않음 -> multi.getParameter로 변경하면 넘어옴
	String userID=multi.getParameter("userID");
	String sPass=multi.getParameter("sPass");
	String sTitle=multi.getParameter("sTitle");
	String sContent=multi.getParameter("sContent");
			
	@SuppressWarnings("rawtypes")
	Enumeration files=multi.getFileNames();
	String fname=(String) files.nextElement();
	fileName=multi.getFilesystemName(fname);
	
	try{
		sql="insert into CCE24SUGGEST(suggestID,userID,sPass,sTitle,sContent,fileName,sregDate) values(?,?,?,?,?,?,sysdate)";
		pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, suggestID);
		pstmt.setString(2, userID);
		pstmt.setString(3, sPass);
		pstmt.setString(4, sTitle);
		pstmt.setString(5, sContent);
		pstmt.setString(6, fileName);
	
		pstmt.executeUpdate();
		response.sendRedirect("suggestResult.jsp?msg=1");
			
	}catch(Exception e){
		System.out.println("데이터베이스 읽기 오류");
		e.getStackTrace();
		System.out.println("SQL : "+e.getMessage());
	}

%>