<%@page import="java.sql.*"%>
<%@page import="oracle.jdbc.proxy.annotation.Pre"%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리 동네 카페 탐험기 - 카페 탐방기</title>

<!-- 부트스트랩 스타일 적용 -->
<script src="../js/bootstrap.min.js"></script>
<script src="../js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/bootstrap.custom.css?after">

<style type="text/css">
.page{
	margin-top:50px;
}
.page2{
	position: sticky;
    top: 100px;
}
table th{
	text-align:center;
}
.rpl{
	display:none;
}
.textpre{
    font-family: 'Dovemayo_gothic';
}
</style>

</head>

<body>

<!-- 네비 파트 -->
	<div class="container">
		<%@ include file="nav.jsp" %>
	</div>
	
<!-- 콘텐츠 파트 -->
	<div class="container-fluid">
		<div class="row">
			<!-- 콘텐츠 좌측 고정 파트 -->
			<nav class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse sidebar">
				<div class="position-sticky pt-3 border text-center page page2">
					<div class="nav flex-column mb-3">
						<!-- 로그인 인포 파트 -->
						<%@ include file="logInfo.jsp" %>
					</div>
					<div class="nav flex-column mb-2">
						<!-- 대표 이미지 파트 -->
						<%@ include file="repImg.jsp" %>
					</div>
				</div>
			</nav>
			
			<!-- 세션 정보 받아오기 -->
			<%
				sessionID=(String) session.getAttribute("sessionID");
				if(sessionID==null){
			%>
			<script>
				Swal.fire(
					'로그인 오류!',
					"먼저 로그인을 해주세요.",
					'error').then(function() { location.href='login.jsp'; });
			</script>
				<%
					}
			%>
			
			<!-- 글 정보 불러오기 -->
			<%
				String sql="";
				int boardID=Integer.parseInt(request.getParameter("boardID"));
				
				try{
					sql="select a.title,a.userID,a.regDate,a.content,a.bView,a.fileName,b.mebType,a.theme,a.preferDrk,a.preferDst,c.areaName,d.themeName from CCE24BOARD a,CCE24MEMBER b,CCE24AREA c,CCE24THEME d where a.userID=b.userID and a.area=c.areaID and a.theme=d.themeID and a.boardID=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setInt(1, boardID);
					rs=pstmt.executeQuery();
					
					if(rs.next()){
			 			String title=rs.getString(1);	
						String userID=rs.getString(2);	
						String regDate=rs.getString(3);	
						String content=rs.getString(4);
						int bView=rs.getInt(5);
						String fileName=rs.getString(6);
						String mebType=rs.getString(7);
						String theme=rs.getString(8);
						String prfDrk=rs.getString(9);
						String prfDst=rs.getString(10);
						String areaName=rs.getString(11);
						String themeName=rs.getString(12);
						String drk[]=prfDrk.split(",");
						String dst[]=prfDst.split(",");
			
						bView++;
			%>
			
			<!-- 콘텐츠 본문 파트 -->
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-5 pb-2 mb-3 border-bottom page">
					<h2><a href="boardList.jsp" style="color:black;">카페 탐방기</a> > <%=boardID %>번 추천글</h2>
				</div>
				<div id="originalBoard" class="container mb-5">
					<table class="table">
						<tr>
							<th>글 번호</th>
							<td><%=boardID %></td>
						</tr>
						<tr>
							<th>작성자</th>
							<td><%=mebType.equals("exp") ? "🤠"+userID:"🐰"+userID %></td>
						</tr>
						<tr>
							<th>작성일</th>
							<td><%=regDate %></td>
						</tr>
						<tr>
							<th>제목</th>
							<td class="fw-bolder ps-2"><%=title %></td>
						</tr>
						<tr>
							<td colspan="2">
								<img src="<%=request.getContextPath() %>/CCE24/upload/<%=fileName %>" class="ps-5" style="width:500px;"><br><br>
								<pre class="ps-5 textpre"><%=content %></pre>
							</td>
						</tr>
						<tr>
							<th>지역</th>
							<td><%=areaName %>
						</tr>
						<tr>
							<th>카페 테마</th>
							<td><%=themeName %></td>
						</tr>
						<tr>
							<th>선호 음료</th>
							<td>
			 			<%
			 			try{
			 				sql="select * from CCE24PREFER order by pID";
			 				pstmt=conn.prepareStatement(sql);
			 				rs=pstmt.executeQuery();
			 				
			 				while(rs.next()){
			 					String pID=rs.getString("pID");
			 					String pType=rs.getString("pType");
								String pName=rs.getString("pName");
								if(pType.equals("000")){ 
			 			%>
							<input type="checkbox" class="ms-1" id="preferDrk" name="preferDrk" value="<%=pID %>" <% for(int i=0;i<drk.length;i++)if(pID.equals(drk[i])) out.print("checked"); %> disabled>
							<label for="preferDrk-<%=pID %>" class="ms-1"><%=pName %></label>
						<%
							}}}catch(Exception e){
								System.out.println("테이블 읽기 오류");
								System.out.println("SQL : "+e.getMessage());
							}
			 			%>
			 				</td>
						</tr>
						<tr>
							<th style="width:150px;">선호 디저트</th>
							<td>
						<%
			 				try{
								sql="select * from CCE24PREFER order by pID";
								pstmt=conn.prepareStatement(sql);
								rs=pstmt.executeQuery();
								while(rs.next()){
									String pID=rs.getString("pID");
									String pType=rs.getString("pType");
									String pName=rs.getString("pName");
									if(pType.equals("100")){ 
						%>
							<input type="checkbox" class="ms-1" id="preferDst" name="preferDst" value="<%=pID %>" <% for(int i=0;i<dst.length;i++)if(pID.equals(dst[i])) out.print("checked"); %> disabled>
							<label for="preferDst-<%=pID %>" class="ms-1"><%=pName %></label>
						<%
							}}}catch(Exception e){
								System.out.println("테이블 읽기 오류");
								System.out.println("SQL : "+e.getMessage());
							}
						%>
							</td>
						</tr>
						
						<tr>
							<td colspan="2">
								<input type="button" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:70px;" value="글쓰기" onclick="location='boardInsert.jsp'">
								<input type="button" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:70px;" value="목록" onclick="location='boardList.jsp'">
								<input type="button" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:70px;" value="수정" onclick="location='boardUpdate.jsp?boardID=<%=boardID %>'">
								<input type="button" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:70px;" value="삭제" onclick="location='boardDelete.jsp?boardID=<%=boardID %>'">	
							</td>
						</tr>
					<%
						sql="update CCE24BOARD set bView=? where boardID=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setInt(1, bView);
						pstmt.setInt(2, boardID);
						pstmt.executeUpdate();
					}}catch(Exception e){
						System.out.println("데이터베이스 읽기 오류");
						e.getStackTrace();
						System.out.println("SQL:"+e.getMessage());
					}
					%>
					</table>	
				</div>
				
			<!-- 댓글 입력 폼 -->
				<div id="commentInsert" class="container border rounded-3 p-3 mb-5">
					<h3>댓글 입력</h3>
					<form name="newComment" method="post" action="commentInsAction.jsp?boardID=<%=boardID %>">
						<div class="d-inline-flex">
							<div id="sessionID" class="input-group mb-3 me-3" style="width:250px;height:30px;">
								<input type="text" class="form-control" name="userID" id="userID" value="<%=sessionID %>" readonly>
							</div>
							<div id="cPass" class="input-group mb-3 me-3" style="width:250px;height:30px;">
								<input type="password" class="form-control" name="cPass" id="cPass" placeholder="비밀번호 필수 입력">
							</div>
							<div id="cText" class="input-group mb-3 me-3">
								<textarea class="form-control" style="width:550px;height:30px;" name="cText" id="cText"></textarea>
							</div>
							<div class="mb-3">
								<input type="button" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:70px;" value="등록" onclick="checkComment()">
							</div>
						</div>
					</form>
				</div>
				
			<!-- 댓글 view -->
				<div id="commentView" class="container mb-5 border rounded-3 p-3 my-3">
					<%
						int cnt=0;
						sql="select count(*) from CCE24COMMENT where boardID=?";
						pstmt=conn.prepareStatement(sql);
						pstmt.setInt(1, boardID);
						rs=pstmt.executeQuery();
						
						if(rs.next()){
							cnt=rs.getInt(1);
						}
					%>
					<h4 class="badge bg-primary fs-5 fw-normal">댓글 <%=cnt %>건</h4>
					<table class="table table-hover text-center" border="1">
						<tr>
							<%
								sql="select a.commentID,a.userID,a.cText,a.cRegDate,a.indent,a.ref,a.step,b.mebType from CCE24COMMENT a, CCE24MEMBER b where a.userID=b.userID and a.boardID=? order by a.ref desc,a.step asc";
								pstmt=conn.prepareStatement(sql);
								pstmt.setInt(1, boardID);
								rs=pstmt.executeQuery();
								/* int no=0; */
								while(rs.next()){
									String commentID=rs.getString(1);
									String userID=rs.getString(2);
									String cText=rs.getString(3);
									String cRegDate=rs.getString(4);
									int indent=rs.getInt(5);
									int ref=rs.getInt(6);
									int step=rs.getInt(7);
									String mebType=rs.getString(8);
							%>
							<td>
								<%
									for(int j=0;j<indent;j++){ //답글 들여쓰기
										%>&nbsp;&nbsp;&nbsp;&nbsp;<%
									}
									if(indent!=0){ //답글 앞에 이모지 넣기
										%> ┗ <%
									}
								%>
								<%=mebType.equals("exp") ? "🤠"+userID:"🐰"+userID %>
							</td>
							<td style="width:300px;"><%=cText%></td>
							<td><%=cRegDate %></td>
							<td>
								<input type="hidden" class="no <%=commentID %>">
								<input type="button" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:70px;" value="수정" onclick="location='commentUpdate.jsp?commentID=<%=commentID %>'">	
								<input type="button" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:70px;" value="삭제" onclick="location='commentDelete.jsp?commentID=<%=commentID %>'">	
								<input type="button" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:70px;" value="댓글" id="<%=commentID %>" onclick="showRpl(this);">	
								<div id="<%=commentID %>Rpl" class="rpl container mt-3 pt-2 border rounded-3">
									<h5>대댓글 입력</h5>
									<form name="replyComment" method="post" action="replyInsAction.jsp?commentID=<%=commentID %>">
										<div class="d-inline-flex">
											<div id="sessionID" hidden>
												<input type="text" name="userID" id="userID" value="<%=sessionID %>" readonly>
											</div>
											<div id="cPass" class="input-group mb-3 me-3" style="width:150px;height:30px;">
												<input type="password" class="form-control" name="cPass" id="cPass" placeholder="비밀번호 필수 입력">
											</div>
											<div id="cText" class="input-group mb-3 me-3" style="width:300px;height:30px;">
												<textarea name="cText" class="form-control" id="cText" rows="1"></textarea>
											</div>
											<div class="mb-3">
												<input type="submit" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:70px;" value="등록">
											</div>
										</div>
									</form>
								</div>
							</td>
						<tr>
						
			<!-- 대댓글 입력폼 -->
						<%-- <tr id="<%=commentID %>Rpl" class="rpl">
							<td colspan="5">
								<div class="container">
									<h5>대댓글 입력</h5>
									<form name="replyComment" method="post" action="replyInsAction.jsp?commentID=<%=commentID %>">
										<div class="d-inline-flex">
											<div id="sessionID" class="input-group mb-3 me-3" style="width:250px;height:30px;">
												<input type="text" class="form-control" name="userID" id="userID" value="<%=sessionID %>" readonly>
											</div>
											<div id="cPass" class="input-group mb-3 me-3" style="width:250px;height:30px;">
												<input type="password" class="form-control" name="cPass" id="cPass" placeholder="비밀번호 필수 입력">
											</div>
											<div id="cText" class="input-group mb-3 me-3" style="width:550px;height:30px;">
												<textarea name="cText" class="form-control" id="cText" cols="50" rows="1"></textarea>
											</div>
											<div class="mb-3">
												<input type="submit" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:70px;" value="등록">
											</div>
										</div>
									</form>
								</div>
							</td>
						</tr> --%>	
								<%-- <div id="<%=commentID %>Rpl" class="rpl">
									<h3>대댓글 입력</h3>
									<form name="replyComment" method="post" action="replyInsAction.jsp?commentID=<%=commentID %>">
										<div id="sessionID" hidden>
											<input type="text" name="userID" id="userID" value="<%=sessionID %>" readonly>
										</div>
										<div id="cPass">
											<input type="password" name="cPass" id="cPass" placeholder="비밀번호 필수 입력">
										</div>
										<div id="cText">
											<textarea name="cText" id="cText" cols="50" rows="1"></textarea>
										</div>
										<div>
											<input type="submit" value="등록">
										</div>
									</form>
								</div> --%>
						<% } %>
					</table>
				</div>

			</main>
		</div>
	</div>

<!-- 푸터 파트 -->
<%@ include file="footer.jsp" %>

<!-- java script: comment 입력 확인 -->
<script>

function showRpl(element){
	var tag=document.getElementsByClassName("rpl");
	console.log(tag);
	
	for(var i=0;i<tag.length;i++){
		if(element.id+"Rpl"==tag[i].id)
			tag[i].style.display="block";
		else
			tag[i].style.display="none";
	}
}
/* function showDiv(element){
	var tag=document.getElementsByClassName("box");
	console.log(tag);
	alert("error"+document.getElementsByClassName("no").value);
	for(var i=0;i<tag.length;i++){
		if(element.id+"Box"==tag[i].id)
			tag[i].style.display="block";
		else
			tag[i].style.display="none";
	}
} */

	function checkComment(){
		if(document.newComment.cPass.value==""){
			Swal.fire(
					'비밀번호 입력 오류!',
					"비밀번호를 입력해주세요.",
					'warning');
			document.newboard.cPass.focus();
			return false;
		}
		if(document.newComment.cText.value==""){
			Swal.fire(
					'본문 입력 오류!',
					"본문을 입력해주세요.",
					'warning');
			document.newboard.cText.focus();
			return false;
		}
		document.newComment.submit();
	}
	
/* 	function checkReply(){
		if(document.replyComment.cPass.value==""){
			Swal.fire(
					'비밀번호 입력 오류!',
					"비밀번호를 입력해주세요.",
					'warning');
			document.replyComment.cPass.focus();
			return false;
		}
		if(document.replyComment.cText.value==""){
			Swal.fire(
					'본문 입력 오류!',
					"본문을 입력해주세요.",
					'warning');
			document.replyComment.cText.focus();
			return false;
		}
		var rpl=document.getElementsByClassName("rpl");
		document.rpl.focus();
			if(rpl.style.display="block"){ 
				if(document.replyComment.cPass.value==""){
					Swal.fire(
							'비밀번호 입력 오류!',
							"비밀번호를 입력해주세요.",
							'warning');
					document.newboard.cPass.focus();
					return false;
				}
				if(document.replyComment.cText.value==""){
					Swal.fire(
							'본문 입력 오류!',
							"본문을 입력해주세요.",
							'warning');
					document.newboard.cText.focus();
					return false;
				}
			} 
		document.replyComment.submit();
	} */

</script>
</body>
</html>