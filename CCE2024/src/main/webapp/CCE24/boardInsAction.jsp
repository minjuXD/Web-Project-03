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
	int boardID=0;
	
	sql="select max(boardID) from CCE24BOARD";
	pstmt=conn.prepareStatement(sql);
	rs=pstmt.executeQuery();
	
	if(rs.next()){
		boardID=rs.getInt(1)+1;
	}else{
		boardID=1;
	}
	
	String fileName=""; 
	String realFolder="C:\\workspace2024\\CCE2024\\src\\main\\webapp\\CCE24\\upload";
	String encType="utf-8";   //인코딩 타입
	int maxSize=5*1024*1024;   //최대 업로드 파일 크기: 5Mb
	MultipartRequest multi = new MultipartRequest(request,realFolder,maxSize,encType, new DefaultFileRenamePolicy());
	
	// boardInsert.jsp에서 enctype="multipart/form-data"를 넣어준거때문에
	// request.getParameter로 값이 넘어오지 않음 -> multi.getParameter로 변경하면 넘어옴
	String userID=multi.getParameter("userID");
	String boardPass=multi.getParameter("boardPass");
	String title=multi.getParameter("title");
	String content=multi.getParameter("content");
	String area=multi.getParameter("area");
	String theme = multi.getParameter("theme");
	System.out.println("테마:"+theme);
	
	String [] val1=multi.getParameterValues("preferDrk");
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
	
	String [] val3=multi.getParameterValues("preferDst");
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
		
	@SuppressWarnings("rawtypes")
	Enumeration files=multi.getFileNames();
	String fname=(String) files.nextElement();
	fileName=multi.getFilesystemName(fname);
	
	try{
		sql="insert into CCE24BOARD(boardID,userID,boardPass,title,content,theme,regDate,fileName,preferDrk,preferDst,area) values(?,?,?,?,?,?,sysdate,?,?,?,?)";
		pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, boardID);
		pstmt.setString(2, userID);
		pstmt.setString(3, boardPass);
		pstmt.setString(4, title);
		pstmt.setString(5, content);
		pstmt.setString(6, theme);
		pstmt.setString(7, fileName);
		pstmt.setString(8, preferDrk);
		pstmt.setString(9, preferDst);
		pstmt.setString(10, area);
	
		pstmt.executeUpdate();
		response.sendRedirect("boardResult.jsp?msg=1");
			
	}catch(Exception e){
		System.out.println("데이터베이스 읽기 오류");
		e.getStackTrace();
		System.out.println("boardInsAction SQL : "+e.getMessage());
	}

%>