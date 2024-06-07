<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리 동네 카페 탐험기 - 토박이 회원 가입 페이지</title>


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
					<h2>회원 가입</h2>
				</div>
				<div>
					<form name="form" method="post" action="memberAction.jsp">
					<!-- 멤버 타입 선택 -->
						<div class="btn-group mb-3" role="group">
							<input type="radio" class="btn-check" id="exp" name="mebType" value="exp" disabled>
							<label class="btn btn-outline-dark" for="exp"> 🤠탐험가</label>
							<input type="radio" class="btn-check" id="nat" name="mebType" value="nat" checked>
							<label class="btn btn-outline-dark" for="nat"> 🐰토박이</label>
						</div>
					
					<!-- 공통 항목 입력 부분 -->
						<div id="common">
							<div id="comID" class="input-group mb-3" style="width:200px;">
								<%@ page import="java.util.Date" %>
								<%@ page import="java.text.SimpleDateFormat" %>
								<%@ page import="java.util.Random" %>
								<%
									//userID: 일월년초분시+랜덤숫자(000~100)
									//오늘 날짜,시간 입력
									Date today=new Date();
									SimpleDateFormat dateFormat = new SimpleDateFormat("ssmmdd");
									
									//랜덤숫자
									Random ran=new Random();
									int num=ran.nextInt(100)+100;
								%>
								<input type="text" class="form-control" value="<%=dateFormat.format(today)+num %>" id="userID" name="userID" readonly>
							</div>
							
							<div id="comPass" class="input-group mb-3" style="width:200px;">
								<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호">
							</div>
							
							<div id="comName" class="input-group mb-3" style="width:200px;">
								<input type="text" class="form-control" id="userName" name="userName" placeholder="이름">
							</div>
							
							<div id="comGend" class="btn-group mb-3" role="group"">
								<input type="radio" class="btn-check" id="gender-T" name="gender" value="M">
								<label class="btn btn-outline-dark" for="gender-T">남</label>
								<input type="radio" class="btn-check" id="gender-F" name="gender" value="F">
								<label class="btn btn-outline-dark" for="gender-F">여</label>
							</div>
							
							<div id="comBt" class="input-group mb-3" style="width:200px;">
								<input type="text" class="form-control" id="birth" name="birth" placeholder="생년월일 8자리">
							</div>
							
							<div id="comMail" class="input-group mb-3" style="width:600px;">
								<input type="text" class="form-control me-2" name="mailFront" placeholder="이메일"> @
								<input type="text" class="form-control mx-2" name="mailEnd" id="mailEnd">
								<select name="mailList" id="mailList" class="form-select me-2">
									<option value="" disabled selected>선택하세요</option>
									<option value="type">직접입력</option>
									<option value="naver.com">naver.com</option>
									<option value="daum.net">daum.net</option>
									<option value="gmail.com">gmail.com</option>
									<option value="korea.com">korea.com</option>
									<option value="nate.com">nate.com</option>
								</select>
							</div>
							
							<div id="comPh" class="input-group mb-3" style="width:200px;">
								<input type="text" class="form-control" id="phone" name="phone" placeholder="휴대전화 번호 11자리">
							</div>
							
							<div id="comAddr" class="input-group mb-3">
								<input type="text" class="form-control me-2" id="sample6_postcode" name="sample6_postcode" placeholder="우편번호" readonly>
								<input type="button" class="fs-6 p-1 me-2 btn btn-outline-dark" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
								<input type="text" class="form-control me-2" id="sample6_address" name="sample6_address" placeholder="주소" readonly>
								<input type="text" class="form-control me-2" id="sample6_detailAddress" name="sample6_detailAddress" placeholder="상세주소">
								<input type="text" class="form-control me-2" id="sample6_extraAddress" name="sample6_extraAddress" placeholder="참고항목" readonly>
							</div>
						</div>
						
						<div id="comBox" class="box">
							<div id="comPrefer">
								<div id="drinkPrefer" class="input-group mb-3 p-2 border rounded-3">
									<p>선호 음료 : </p><br>
									<!-- 데이터베이스 연결 -->
									<%
										String sql="";
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
									<input type="checkbox" class="form-check-input ms-2" id="preferDrk-<%=pID %>" name="preferDrk" value="<%=pID %>">
									<label for="preferDrk-<%=pID %>" class="ms-1"><%=pName %></label>
									<%
										}}}catch(Exception e){
											System.out.println("테이블 읽기 오류");
											System.out.println("SQL : "+e.getMessage());
										}
									%>
								</div>
								<div id="dessertPrefer" class="input-group mb-3 p-2 border rounded-3">
									<p>선호 디저트 : </p><br>
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
									<input type="checkbox" class="form-check-input ms-2" id="preferDst-<%=pID %>" name="preferDst" value="<%=pID %>">
									<label for="preferDst-<%=pID %>" class="ms-1"><%=pName %></label>
									<%
										}}}catch(Exception e){
											System.out.println("테이블 읽기 오류");
											System.out.println("SQL : "+e.getMessage());
										}
									%>
								</div>
							</div>
						</div>
			
						<!-- 토박이 특정 입력 부분 -->
						<div id="natBox" class="box">
							<div id="natCafeName" class="input-group mb-3" style="width:200px;">
								<input type="text" class="form-control" id="cafeName" name="cafeName" placeholder="카페명 입력">
							</div>
							<div id="natBsID" class="input-group mb-3" style="width:200px;">
								<input type="text" class="form-control" id="businessID" name="businessID" placeholder="사업자번호 입력">
							</div>
							<div id="natTheme" class="input-group mb-3 ps-2 pt-2 border rounded-3">
								<p>카페 테마 : </p><br>
								<%
									try{
										sql="select * from CCE24THEME";
										pstmt=conn.prepareStatement(sql);
										rs=pstmt.executeQuery();
										while(rs.next()){
											String themeID=rs.getString("themeID");
											String themeName=rs.getString("themeName");
								%>
								<input type="radio" class="form-check-input ms-2" id="theme-<%=themeID %>" name="theme" value="<%=themeID %>">
								<label class="ms-1" for="theme-<%=themeID %>"><%=themeName %></label>
								<%
											}}catch(Exception e){
												System.out.println("테이블 읽기 오류");
												System.out.println("SQL : "+e.getMessage());
											}
								%>
							</div>
						</div>
						
					<!-- 제출 버튼 -->
						<div class="mb-3">
							<input type="button" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:70px;" value="등록" onclick="check()">
							<input type="reset" class="fs-6 p-1 ms-2 btn btn-outline-dark" style="width:70px;" value="취소">
						</div>
						
					</form>
				</div>
			</main>
		</div>
	</div>

<!-- 푸터 파트 -->
<%@ include file="footer.jsp" %>

<!-- java script: 주소 입력 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>

<!-- java script: 입력 확인 -->
<script>
	function check(){
		if(document.form.password.value==""){
			Swal.fire(
					'비밀번호 입력 오류!',
					"비밀번호를 입력해주세요.",
					'warning');
			document.form.password.focus();
			return false;
		}
		if(document.form.userName.value==""){
			Swal.fire(
					'이름 입력 오류!',
					"이름을 입력해주세요.",
					'warning');
			document.form.userName.focus();
			return false;
		}
		let num2=0;
		let rdo=document.getElementsByName("gender");
		for (let i=0;i<rdo.length;i++){
			if (rdo[i].checked == true){
				num2++;
				break;
			}
		}
		if(num2 == 0){
			Swal.fire(
					'성별 입력 오류!',
					"성별을 선택해주세요.",
					'warning');
			return false;
		}
		if(document.form.birth.value.length !=8 || isNaN(document.form.birth.value)){
			Swal.fire(
					'생년월일 입력 오류!',
					"생년월일에는 8자리의 숫자만 입력해주세요.",
					'warning');
			document.form.birth.focus();
			return false;
		}
		if(document.form.mailFront.value==""){
			Swal.fire(
					'이메일 주소 입력 오류!',
					"이메일 주소를 입력해주세요.",
					'warning');
			document.form.mailFront.focus();
			return false;
		}
		if(document.form.mailEnd.value==""){
			Swal.fire(
					'이메일 도메인 입력 오류!',
					"이메일 도메인을 선택해주세요.",
					'warning');
			document.form.mailEnd.focus();
			return false;
		}
		if(document.form.phone.value.length !=11 || isNaN(document.form.phone.value)){
			Swal.fire(
					'연락처 입력 오류!',
					"연락처에는 11자리의 숫자만 입력해주세요.",
					'warning');
			document.form.phone.focus();
			return false;
		}
		if(document.form.sample6_postcode.value==""){
			Swal.fire(
					'주소 입력 오류!',
					"주소를 입력해주세요",
					'warning');
			document.form.sample6_postcode.focus();
			return false;
		} 
		if(document.form.cafeName.value==""){
			Swal.fire(
					'카페명 입력 오류!',
					"카페명을 입력해주세요",
					'warning');
			document.form.cafeName.focus();
			return false;
		}
		if(document.form.businessID.value.length !=10 || isNaN(document.form.businessID.value)){
			Swal.fire(
					'연락처 입력 오류!',
					"사업자등록번호에는 10자리의 숫자만 입력해주세요.",
					'warning');
			document.form.businessID.focus();
			return false;
		}
		document.form.submit();
	}
</script>

<!-- java script: 이메일 도메인 옵션 선택 및 직접 입력 -->
<script>
	const mailList=document.querySelector('#mailList')
	const mailEnd=document.querySelector('#mailEnd')
	//select 옵션 변경시
	mailList.addEventListener('change', (event) => {
	  // option에 있는 도메인 선택 시
	  if(event.target.value !== "type") {
	    // 선택한 도메인을 input에 입력하고 disabled
	    mailEnd.value = event.target.value
	    mailEnd.readOnly = true
	  } else { // 직접 입력 시
	    // input 내용 초기화 & 입력 가능하도록 변경
	    mailEnd.value = ""
	    mailEnd.readOnly = false
	  }
	})
</script>

</body>
</html>