<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="DBconn.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String sql="";
	
	try{
		//commentID 부여하기(최대+1)
		sql="select max(commentID) from CCE24COMMENT";
		pstmt=conn.prepareStatement(sql);
		rs=pstmt.executeQuery();
		
		int commentID=0;
		if(rs.next()){
			commentID=rs.getInt(1)+1;
		}else{
			commentID=0;
		}
		
		//댓글 입력 폼에서 파라매터 가져오기
		String userID=request.getParameter("userID");
		String cPass=request.getParameter("cPass");
		String cText=request.getParameter("cText");
		String boardID=request.getParameter("boardID");
		int ref=0;
		int indent=0;
		int step=0;
		
		//데이터베이스에 현 답글 내용을 추가하기
		sql="insert into CCE24COMMENT values(?,?,?,?,?,sysdate,?,?,?)";
		pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, commentID);
		pstmt.setString(2, boardID);
		pstmt.setString(3, userID);
		pstmt.setString(4, cPass);
		pstmt.setString(5, cText);
		pstmt.setInt(6, commentID);	// ref(부모 댓글의 commentID)이니까 그냥 commentID 넣어버림
		pstmt.setInt(7, indent);	// indent(부모(0)-자식(1,2,,)간 촌수))
		pstmt.setInt(8, step);		// step (답글끼리 출력 순서) 부모 0
		
		pstmt.executeUpdate();
		
		%>
		<script>
			location.href="boardView.jsp?boardID=<%=boardID %>#commentView";
		</script>
		<%
		
	}catch(Exception e){
		System.out.println("데이터베이스 읽기 오류");
		e.getStackTrace();
		System.out.println("SQL : "+e.getMessage());
	}
%>