<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리 동네 카페 탐험기 - 메인 페이지</title>

<!-- 부트스트랩 스타일 적용 -->
<style>
@font-face {
    font-family: 'Dovemayo_gothic';
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2302@1.1/Dovemayo_gothic.woff2') format('woff2');
    font-weight: normal;
    font-style: normal;
}
</style>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/css.css">
<script src="../js/bootstrap.min.js"></script>
<script src="../js/jquery-3.7.1.min.js"></script>

</head>
<body>

<!-- 네비 파트 -->
<%@ include file="nav.jsp" %>

<!-- 콘텐츠 파트 -->
<div class="container-fluid">
<!-- 로그인 인포 파트 -->
<%@ include file="logInfo.jsp" %>
<!-- 대표 이미지 파트 -->
<%@ include file="repImg.jsp" %>

<!-- 콘텐츠 헤드 파트 -->
	<div>
		<h1>우리 동네 카페 탐험기 WELCOME!</h1>
	</div>
<!-- 콘텐츠 바디 파트 -->
	<div id="index" class="container">
	
<!-- 최신글 -->
		<div id="newlyBd">
			<h3>최신글</h3>
			<table class="table table-hover text-center">
				<tr>
					<th>글 번호</th>
					<th>제목</th>
					<th>작성일</th>
				</tr>
			<%
		    try {
				String sql = "SELECT * FROM (SELECT * FROM CCE24BOARD ORDER BY regDate DESC ) WHERE ROWNUM <= 10 ORDER BY boardID DESC";
		        pstmt = conn.prepareStatement(sql);
		        rs = pstmt.executeQuery();
		        
		        while (rs.next()) {
		        	int boardID=rs.getInt("boardID");
		        	String title=rs.getString("title");
		        	String regDate=rs.getString("regDate");
		        	
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
					<td>
						<a href="boardView.jsp?boardID=<%=boardID %>"><%=title %></a>
						<span class="badge text-bg-warning"><%="("+cntCom+")" %></span>
					</td>
					<td><%=regDate %></td>
				</tr>
		        <%
		        }
			%>
			</table>
		</div>

<!-- 인기글(조회수순) -->
		<div id="hotViwBd">
			<h3>인기글(조회수)</h3>
			<table class="table table-hover text-center">
				<tr>
					<th>글 번호</th>
					<th>제목</th>
					<th>작성일</th>
				</tr>
			<%
		    	sql = "SELECT * FROM (SELECT * FROM CCE24BOARD ORDER BY bView DESC) WHERE ROWNUM <= 10";
		        pstmt = conn.prepareStatement(sql);
		        rs = pstmt.executeQuery();
		        
		        while (rs.next()) {
		        	int boardID=rs.getInt("boardID");
		        	String title=rs.getString("title");
		        	String regDate=rs.getString("regDate");
		        	
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
					<td>
						<a href="boardView.jsp?boardID=<%=boardID %>"><%=title %></a>
						<span class="badge text-bg-warning"><%="("+cntCom+")" %></span>
					</td>
					<td><%=regDate %></td>
				</tr>
		        <%
		        }
				%>
			</table>
		</div>
		
<!-- 인기글(댓글순) -->
		<div id="hotComBd">
			<h3>인기글(댓글수)</h3>
			<table class="table table-hover text-center">
				<tr>
					<th>글 번호</th>
					<th>제목</th>
					<th>작성일</th>
				</tr>
		<%
				sql = "SELECT b.boardID, b.title, b.regDate, COUNT(c.boardID) AS comment_count FROM CCE24BOARD b LEFT JOIN CCE24COMMENT c ON b.boardID = c.boardID " +
			            "GROUP BY b.boardID, b.title, b.regDate ORDER BY COUNT(c.boardID) DESC FETCH FIRST 10 ROWS ONLY";
		        pstmt = conn.prepareStatement(sql);
		        rs = pstmt.executeQuery();
		        
		        while (rs.next()) {
		        	int boardID=rs.getInt("boardID");
		        	String title=rs.getString("title");
		        	String regDate=rs.getString("regDate");
		        	
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
					<td>
						<a href="boardView.jsp?boardID=<%=boardID %>"><%=title %></a>
						<span class="badge text-bg-warning"><%="("+cntCom+")" %></span>
					</td>
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
</div>

<!-- 푸터 파트 -->
<%@ include file="footer.jsp" %>

</body>
</html>