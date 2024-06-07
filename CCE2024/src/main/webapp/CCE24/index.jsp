<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리 동네 카페 탐험기 - 메인 페이지</title>

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
				<div class="position-sticky pt-3 border text-center page page2 ">
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
			<!-- 콘텐츠 본문 파트 -->
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-5 pb-2 mb-3 border-bottom page">
					<h2>우리 동네 카페 탐험기 WELCOME!</h2>
				</div>
				<div class="container">
					<!-- 최신글 -->
					<div id="newlyBd" class="border rounded-2 p-3 mb-4">
						<h4><span class="text-decoration-underline link-primary">지금 올라온 최신글</span>🙉</h4>
						<table class="table table-hover text-center">
							<tr>
								<th>글 번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
							</tr>
						<%
					    try {
							String sql = "SELECT * FROM ( " +
						             "SELECT b.boardID, b.title, b.regDate, b.userID, a.mebType " +
						             "FROM CCE24BOARD b " +
						             "LEFT JOIN CCE24MEMBER a ON b.userID = a.userID " +
						             "ORDER BY b.regDate DESC " +
						             ") " +
						             "WHERE ROWNUM <= 5 " +
						             "ORDER BY boardID DESC";
					        pstmt = conn.prepareStatement(sql);
					        rs = pstmt.executeQuery();
					        
					        while (rs.next()) {
					        	int boardID=rs.getInt("boardID");
					        	String title=rs.getString("title");
					        	String regDate=rs.getString("regDate");
					        	String userID=rs.getString("userID");
					        	String mebType=rs.getString("mebType");
					        	
					        	// 댓글 수를 가져오는 부분
			                    String sqlComment = "select count(*) from CCE24COMMENT where boardID=?";
			                    PreparedStatement pstmtComment = conn.prepareStatement(sqlComment);
			                    pstmtComment.setInt(1, boardID);
			                    ResultSet rsComment = pstmtComment.executeQuery();
			                    int cntCom = 0;
			                    if(rsComment.next()){
			                        cntCom = rsComment.getInt(1);
			                    }
			                    rsComment.close();
			                    pstmtComment.close();
								%>
				        	<tr>
								<td><%=boardID %></td>
								<td align="left">
									<a href="boardView.jsp?boardID=<%=boardID %>" style="color:black;"><%=title %></a>
									<span class="fw-semibold"><%="("+cntCom+")" %></span>
								</td>
								<td><%=mebType.equals("exp") ? "🤠"+userID:"🐰"+userID %></td>
								<td><%=regDate %></td>
							</tr>
					        <%
					        }
						%>
						</table>
					</div>
			
					<!-- 인기글(조회수순) -->
					<div id="hotViwBd" class="border rounded-2 p-3 mb-4">
						<h4><span class="text-decoration-underline link-primary">조회수 높은 추천글</span>🙈</h4>
						<table class="table table-hover text-center">
							<tr>
								<th>글 번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
							</tr>
						<%
					    	sql =  "SELECT * FROM ( " +
					                "    SELECT b.boardID, b.title, b.regDate, b.userID, b.bView, a.mebType " +
					                "    FROM CCE24BOARD b " +
					                "    LEFT JOIN CCE24MEMBER a ON b.userID = a.userID " +
					                "    ORDER BY b.bView DESC " +
					                ") " +
					                "WHERE ROWNUM <= 5";;
					        pstmt = conn.prepareStatement(sql);
					        rs = pstmt.executeQuery();
					        
					        while (rs.next()) {
					        	int boardID=rs.getInt("boardID");
					        	String title=rs.getString("title");
					        	String regDate=rs.getString("regDate");
					        	String userID=rs.getString("userID");
					        	String mebType=rs.getString("mebType");
					        	
					        	// 댓글 수를 가져오는 부분
			                    String sqlComment = "select count(*) from CCE24COMMENT where boardID=?";
			                    PreparedStatement pstmtComment = conn.prepareStatement(sqlComment);
			                    pstmtComment.setInt(1, boardID);
			                    ResultSet rsComment = pstmtComment.executeQuery();
			                    int cntCom = 0;
			                    if(rsComment.next()){
			                        cntCom = rsComment.getInt(1);
			                    }
			                    rsComment.close();
			                    pstmtComment.close();
								%>
				        	<tr>
								<td><%=boardID %></td>
								<td align="left">
									<a href="boardView.jsp?boardID=<%=boardID %>" style="color:black;"><%=title %></a>
									<span class="fw-semibold"><%="("+cntCom+")" %></span>
								</td>
								<td><%=mebType.equals("exp") ? "🤠"+userID:"🐰"+userID %></td>
								<td><%=regDate %></td>
							</tr>
					        <%
					        }
							%>
						</table>
					</div>
					
					<!-- 인기글(댓글순) -->
					<div id="hotComBd" class="border rounded-2 p-3 mb-4">
						<h4><span class="text-decoration-underline link-primary">댓글 수 많은 추천글</span>🙊</h4>
						<table class="table table-hover text-center">
							<tr>
								<th>글 번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
							</tr>
					<%
							sql = "SELECT b.boardID, b.title, b.regDate, b.userID, a.mebType, COUNT(c.boardID) AS comment_count " +
						             "FROM CCE24BOARD b " +
						             "LEFT JOIN CCE24COMMENT c ON b.boardID = c.boardID " +
						             "LEFT JOIN CCE24MEMBER a ON b.userID = a.userID " +
						             "GROUP BY b.boardID, b.title, b.regDate, b.userID, a.mebType " +
						             "ORDER BY comment_count DESC " +
						             "FETCH FIRST 5 ROWS ONLY";
					        pstmt = conn.prepareStatement(sql);
					        rs = pstmt.executeQuery();
					        
					        while (rs.next()) {
					        	int boardID=rs.getInt("boardID");
					        	String title=rs.getString("title");
					        	String regDate=rs.getString("regDate");
					        	String userID=rs.getString("userID");
					        	String mebType=rs.getString("mebType");
					        	
					        	// 댓글 수를 가져오는 부분
			                    String sqlComment = "select count(*) from CCE24COMMENT where boardID=?";
			                    PreparedStatement pstmtComment = conn.prepareStatement(sqlComment);
			                    pstmtComment.setInt(1, boardID);
			                    ResultSet rsComment = pstmtComment.executeQuery();
			                    int cntCom = 0;
			                    if(rsComment.next()){
			                        cntCom = rsComment.getInt(1);
			                    }
			                    rsComment.close();
			                    pstmtComment.close();
								%>
				        	<tr>
								<td><%=boardID %></td>
								<td align="left">
									<a href="boardView.jsp?boardID=<%=boardID %>" style="color:black;"><%=title %></a>
									<span class="fw-semibold"><%="("+cntCom+")" %></span>
								</td>
								<td><%=mebType.equals("exp") ? "🤠"+userID:"🐰"+userID %></td>
								<td><%=regDate %></td>
							</tr>
					        <%
					        }
					    } catch (Exception e) {
					        e.printStackTrace();
					    } finally {
					        if (rs != null) try { rs.close(); } catch (SQLException e) {}
					        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
					        if (conn != null) try { conn.close(); } catch (SQLException e) {}
					    }
						%>
						</table>
					</div>
				</div>
			</main>
		</div>
	</div>

<!-- 푸터 파트 -->
<%@ include file="footer.jsp" %>

</body>
</html>