<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 부트스트랩 스타일 적용 -->
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/css.css">
<script src="../js/bootstrap.min.js"></script>
<script src="../js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
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
		
		//ref(부모의 commentID), indent(답글 리스트업,들여쓰기), step(답글끼리 출력순서) 가져오기
		int comID=Integer.parseInt(request.getParameter("commentID")); // 폼에서 부모 댓글의 commentID 가져오기
		sql="select ref,indent,step,boardID from CCE24COMMENT where commentID=?"; //부모의 ref,indent,step 일단 가져오기
		pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, comID);
		rs=pstmt.executeQuery();
		
		//일단 대댓글의 ref,indent,step,boardID 초기화
		int ref=0;
		int indent=0;
		int step=0;
		int boardID=0;
		
		//부모 댓글의 ref,indent,step,boardID 가져와서 처리하기
		if(rs.next()){
			ref=rs.getInt(1); //부모의 ref를 그대로 가지면 됨
			indent=rs.getInt(2)+1; //답글이니까 부모의 indent보다 +1
			step=rs.getInt(3); //부모 바로 아래 와야하므로 일단 부모의 step을 가지고 아래 업데이트 해줌
			boardID=rs.getInt(4);	// 부모의 boardID와 동일 
		}
		
		if(cPass!="" && cText!=""){
			
			//step 업데이트 하기
			sql="update CCE24COMMENT set step=step+1 where ref=? and step>?"; //같은 ref 내에서 부모의 step보다 큰 번호들은 1을 더함  
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, step);
			pstmt.executeUpdate();
			
			//데이터베이스에 현 답글 내용을 추가하기
			sql="insert into CCE24COMMENT values(?,?,?,?,?,sysdate,?,?,?)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, commentID);
			pstmt.setInt(2, boardID);
			pstmt.setString(3, userID);
			pstmt.setString(4, cPass);
			pstmt.setString(5, cText);
			pstmt.setInt(6, ref);
			pstmt.setInt(7, indent);
			pstmt.setInt(8, step+1);//부모보다 step이 큰 애들을 +1씩 해줬으니 나도 더해줘야지
			
			pstmt.executeUpdate();
			
			%>
			<script>
				location.href="boardView.jsp?boardID=<%=boardID %>#commentView";
			</script>
			<%
		}else{
			response.sendRedirect("commentResult.jsp?msg=3");
		}
	}catch(Exception e){
		System.out.println("replyInsAction데이터베이스 읽기 오류");
		e.getStackTrace();
		System.out.println("SQL : "+e.getMessage());
	}
%>