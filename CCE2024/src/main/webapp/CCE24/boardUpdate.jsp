<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리 동네 카페 탐험기 - 추천글 수정 화면</title>

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
				String sessionName=(String) session.getAttribute("sessionName");
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
				
			<%
				String boardID=request.getParameter("boardID");
				String fileName="";
				try{
					String sql="select userID,boardPass,title,content,theme,preferDrk,preferDst,fileName,area from CCE24BOARD where boardID=?";
					pstmt=conn.prepareStatement(sql);
					pstmt.setString(1, boardID);
					rs=pstmt.executeQuery();
					
					if(rs.next()){
						String userID=rs.getString(1);
						String boardPass=rs.getString(2);
						String title=rs.getString(3);
						String content=rs.getString(4);
						String theme=rs.getString(5);
						String prfDrk=rs.getString(6);
						String prfDst=rs.getString(7);
						fileName=rs.getString(8);
						String area=rs.getString(9);
						String drk[]=prfDrk.split(",");
						String dst[]=prfDst.split(",");
						
						
						if(userID.equals(sessionID)){
			%>
			
			<!-- 콘텐츠 본문 파트 -->
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-5 pb-2 mb-3 border-bottom page">
					<h2><span class="text-decoration-underline"><%=boardID %>번 추천글</span> 수정 화면</h2>
				</div>
				<div>
					<form name="updBoard" method="post" action="boardUpdAction.jsp?boardID=<%=boardID %>" enctype="multipart/form-data">
						<div id="bdUser" class="input-group mb-3" style="width:200px;">
							<input type="text" class="form-control" name="userID" id="userID" value="<%=userID %>" readonly>
						</div>
						<div id="bdPass" class="input-group mb-3" style="width:200px;">
							<input type="password" class="form-control" name="boardPass" id="boardPass" placeholder="password">
						</div>
						<div id="bdTitle" class="input-group mb-3">
							<input type="text" class="form-control" name="title" id="title" value="<%=title %>">
						</div>
						<div id="bdContent" class="input-group mb-3">
							<textarea class="form-control" rows="10" cols="100" name="content" id="content"><%=content %></textarea>
						</div>
						<div id="bdArea" class="input-group mb-3" style="width:200px;">
							<select name="area" class="form-select me-2">
								<option value="" disabled selected>지역 선택</option>
								
								<%
									try{
										sql="select * from CCE24AREA";
										pstmt=conn.prepareStatement(sql);
										rs=pstmt.executeQuery();
										while(rs.next()){
											String areaID=rs.getString("areaID");
											String areaName=rs.getString("areaName");
										%>
											<option value="<%=areaID %>" <% if(area.equals(areaID)) { %> selected <% } %>><%=areaName %></option>
										<%
									}}catch(Exception e){
										System.out.println("member 테이블 읽기 오류");
										System.out.println("SQL:"+e.getMessage());		
									}
								%>
							</select>
						</div>
						<div id="bdCheck">
							<div id="cafeTheme" class="input-group mb-3 p-2 border rounded-3">
								<p>카페 테마 : </p>
								<%
								try{
									sql="select * from CCE24THEME";
									pstmt=conn.prepareStatement(sql);
									rs=pstmt.executeQuery();
									while(rs.next()){
										String themeID=rs.getString("themeID");
										String themeName=rs.getString("themeName");
							%>
							<input type="radio" class="form-check-input ms-2" id="theme-<%=themeID %>" name="theme" value="<%=themeID %>" <%=theme.equals(themeID) ? "checked":"" %>>
							<label class="ms-1" for="theme-<%=themeID %>"><%=themeName %></label>
							<%
										}}catch(Exception e){
											System.out.println("테이블 읽기 오류");
											System.out.println("SQL : "+e.getMessage());
										}
							%>
							</div>
							<div id="drinkPrefer" class="input-group mb-3 p-2 border rounded-3">
								<p>선호 음료 : </p>
								<!-- 데이터베이스 연결 -->
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
								<input type="checkbox" class="form-check-input ms-2" id="preferDrk-<%=pID %>" name="preferDrk" value="<%=pID %>" <% for(int i=0;i<drk.length;i++)if(pID.equals(drk[i])) out.print("checked"); %>>
								<label for="preferDrk-<%=pID %>" class="ms-1"><%=pName %></label>
								<%
									}}}catch(Exception e){
										System.out.println("테이블 읽기 오류");
										System.out.println("1 SQL : "+e.getMessage());
									}
								%>
							</div>
							<div id="dessertPrefer" class="input-group mb-3 p-2 border rounded-3">
								<p>선호 디저트 : </p>
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
								<input type="checkbox" class="form-check-input ms-2" id="preferDst-<%=pID %>"name="preferDst" value="<%=pID %>" <% for(int i=0;i<dst.length;i++)if(pID.equals(dst[i])) out.print("checked"); %>>
								<label for="preferDst-<%=pID %>" class="ms-1"><%=pName %></label>
								<%
									}}}catch(Exception e){
										System.out.println("테이블 읽기 오류");
										System.out.println("2 SQL : "+e.getMessage());
									}
								%>
							</div>
						</div>
						<div id="bdFile" class="input-group mb-3" style="width:500px;">
							<input type="file" class="form-control" name="fileName" id="fileName"><%=fileName %>
						</div>
						<div class="mb-3">
							<input type="button" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:70px;" value="등록" onclick="checkBoard()">
							<input type="button" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:70px;" value="취소" onclick="history.back(-1)">
						</div>
					<% 
						}else{
							%>
							<script>
								Swal.fire('작성자 확인 오류!',
										'추천글 작성자가 아닌 사람은 수정할 수 없습니다.',
										'warning').then(function() { history.back(-1); });
							</script>
							<%
						}}}catch(Exception e){
							System.out.println("테이블 읽기 오류");
							System.out.println("3 SQL:"+e.getMessage());		
						} 
					%>
					</form>
				</div>
			</main>
		</div>
	</div>

<!-- java script: 입력 확인 -->
<script>
function checkBoard(){
	if(document.updBoard.boardPass.value==""){
		Swal.fire(
				'비밀번호 입력 오류!',
				"비밀번호를 입력해주세요.",
				'warning');
		document.updBoard.boardPass.focus();
		return false;
	}
	if(document.updBoard.title.value==""){
		Swal.fire(
				'제목 입력 오류!',
				"제목을 입력해주세요.",
				'warning');
		document.updBoard.title.focus();
		return false;
	}
	if(document.updBoard.content.value==""){
		Swal.fire(
				'본문 입력 오류!',
				"본문을 입력해주세요.",
				'warning');
		document.updBoard.content.focus();
		return false;
	}
	if(document.updBoard.area.value==""){
		Swal.fire(
				'지역 입력 오류!',
				"지역을 입력해주세요.",
				'warning');
		document.updBoard.area.focus();
		return false;
	}
	let cnt=0;
	let thm=document.getElementsByName("theme");
	for (let i=0;i<thm.length;i++){
		if (thm[i].checked == true){
			cnt++;
			break;
		}
	}
	if(cnt == 0){
		Swal.fire(
				'테마 입력 오류!',
				"테마를 선택해주세요.",
				'warning');
		return false;
	}
	document.updBoard.submit();
}
</script>
<!-- 푸터 파트 -->
<%@ include file="footer.jsp" %>

</body>
</html>