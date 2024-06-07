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
		
	String fileName=""; 
	String realFolder="C:\\workspace2024\\CCE2024\\src\\main\\webapp\\CCE24\\upload";
	String encType="utf-8";   //인코딩 타입
	int maxSize=5*1024*1024;   //최대 업로드 파일 크기: 5Mb
	System.out.println("read folder: "+realFolder);
	MultipartRequest multi = new MultipartRequest(request,realFolder,maxSize,encType, new DefaultFileRenamePolicy());
	
	// boardInsert.jsp에서 enctype="multipart/form-data"를 넣어준거때문에
	// request.getParameter로 값이 넘어오지 않음 -> multi.getParameter로 변경하면 넘어옴
	String boardID=multi.getParameter("boardID");
	String uID=multi.getParameter("userID");
	String pass=multi.getParameter("boardPass");
	String title=multi.getParameter("title");
	String content=multi.getParameter("content");
	System.out.println(content);
	String area=multi.getParameter("area");
	String theme = multi.getParameter("theme");
	
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
		sql="select boardPass,fileName from CCE24BOARD where boardID=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, boardID);
		rs=pstmt.executeQuery();
		
		String existingFileName = null;
	    String boardPass = null;
		
		if(rs.next()){
			boardPass=rs.getString("boardPass");
			existingFileName=rs.getString("fileName");
			
			if(pass.equals(boardPass)){
				// 새 파일 이름이 없으면 기존 파일 이름 사용
                if (fileName == null || fileName.trim().isEmpty()) {
                    fileName = existingFileName;
                }
				
				sql="update CCE24BOARD set boardPass=?,title=?,content=?,theme=?,fileName=?,preferDrk=?,preferDst=?,area=? where boardID=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, boardPass);
				pstmt.setString(2, title);
				pstmt.setString(3, content);
				pstmt.setString(4, theme);
				pstmt.setString(5, fileName);
				pstmt.setString(6, preferDrk);
				pstmt.setString(7, preferDst);
				pstmt.setString(8, area);
				pstmt.setString(9, boardID);
				
				pstmt.executeUpdate();
				
				//게시글 수정 완료
				response.sendRedirect("boardResult.jsp?msg=0");
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