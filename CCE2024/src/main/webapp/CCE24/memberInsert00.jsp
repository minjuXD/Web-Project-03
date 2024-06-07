<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>우리 동네 카페 탐험기 - 회원 가입 페이지</title>

<!-- 부트스트랩 스타일 적용 -->
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/css.css">
<script src="../js/bootstrap.min.js"></script>
<script src="../js/jquery-3.7.1.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.4.10/dist/sweetalert2.min.js"></script>

<style>
	div.box{
		display:none;
		border:1px;
		background-color:orange;
	}
</style>

</head>
<body>

<!-- 네비 파트 -->
<jsp:include page="nav.jsp"/>
<!-- 로그인 인포 파트 -->
<%@ include file="logInfo.jsp" %>
<!-- 대표 이미지 파트 -->
<%@ include file="repImg.jsp" %>

<!-- 콘텐츠 파트 -->
<section>
<!-- 콘텐츠 헤드 파트 -->
	<div>
		<h1>회원 가입</h1>
	</div>
<!-- 콘텐츠 바디 파트 -->
	<div>
		<form name="form" method="post" action="memberAction.jsp">
		<!-- 멤버 타입 선택 -->
			<div>
				<input type="radio" id="exp" name="mebType" onclick="showDiv(this);" value="exp">🤠탐험가
				<input type="radio" id="nat" name="mebType" onclick="showDiv(this);" value="nat">🐰토박이
			</div>
		
		<!-- 탐험가 입력 부분 -->
			<div id="common">
				<h1>과연</h1>
				<div id="comID">
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
					<input type="text" value="<%=dateFormat.format(today)+num %>" id="userID" name="userID" readonly>
				</div>
				<div id="comPass">
					<input type="password" id="password" name="password" placeholder="비밀번호">
				</div>
				<div id="comName">
					<input type="text" id="userName" name="userName" placeholder="이름">
				</div>
				<div id="comGend">
					<input type="radio" id="gender" name="gender" value="M"> 남
					<input type="radio" id="gender" name="gender" value="F"> 여
				</div>
				<div id="comBt">
					<input type="text" id="birth" name="birth" placeholder="생년월일 8자리">
				</div>
				<div id="comMail">
					<input type="text" name="mailFront" id="mailFront" placeholder="이메일">@
					<input type="text" name="mailEnd" id="mailEnd" placeholder="직접 입력">
					<select name="mailList" id="mailList">
						<option value="" disabled selected>선택하세요</option>
						<option value="type">직접 입력</option>
						<option value="naver.com">naver.com</option>
						<option value="daum.com">daum.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="korea.com">korea.com</option>
						<option value="nate.com">nate.com</option>
					</select>
				</div>
				<div id="comPh">
					<input type="text" id="phone" name="phone" placeholder="휴대전화 번호 11자리">
				</div>
				<div id="comAddr">
					<input type="text" id="postcode" placeholder="우편번호" readonly>
					<input type="button" id="daumPostcode" onclick="daumPostcode()" value="우편번호 찾기">
					<input type="text" id="address" name="address" placeholder="주소" readonly>
					<input type="text" id="detailAddr" placeholder="상세주소">
					<input type="text" id="extraAddr" placeholder="참고항목" hidden>
				</div>
			</div>
			<div id="expBox" class="box">
				<div id="expPrefer">
					<div id="drinkPrefer">
						<p>음료 취향 : </p>
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
						<input type="checkbox" id="preferDrk" name="preferDrk" value="<%=pID %>"><%=pName %>
						<%
							}}}catch(Exception e){
								System.out.println("테이블 읽기 오류");
								System.out.println("SQL : "+e.getMessage());
							}
						%>
					</div>
					<div id="dessertPrefer">
						<p>디저트 취향 : </p>
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
						<input type="checkbox" id="preferDst" name="preferDst" value="<%=pID %>"><%=pName %>
						<%
							}}}catch(Exception e){
								System.out.println("테이블 읽기 오류");
								System.out.println("SQL : "+e.getMessage());
							}
						%>
					</div>
				</div>
			</div>
			
		<!-- 토박이 입력 부분 -->
			<div id="natBox" class="box">
				<div id="natCafeName">
					<input type="text" id="cafeName" name="cafeName" placeholder="카페명 입력">
				</div>
				<div id="natBsID">
					<input type="text" id="businessID" name="businessID" placeholder="사업자번호 입력">
				</div>
				<div id="natTheme">
					<input type="checkbox" name="thm" value="노멀">노멀
					<input type="checkbox" name="thm" value="북카페">북카페
					<input type="checkbox" name="thm" value="식물카페">식물카페
					<input type="checkbox" name="thm" value="타로카페">타로카페
					<input type="checkbox" name="thm" value="음악카페">음악카페
					<input type="checkbox" name="thm" value="드로잉카페">드로잉카페
					<input type="checkbox" name="thm" value="보드게임카페">보드게임카페
					<label><input type="checkbox" name="name[]" value="기타" 
						onclick="document.getElementById('etc').style.display=this.checked?'inline-block':'none';">기타</label>
					<input type="text" id="etc" name="thm" value="" style="display:none;">
				</div>
			</div>
			
		<!-- 제출 버튼 -->
			<div>
				<input type="button" class="button" value="등록" onclick="check()">
				<input type="reset" class="button" value="취소">
			</div>
			
		</form>
	</div>
</section>

<!-- 푸터 파트 -->
<%@ include file="footer.jsp" %>

<!-- java script: 주소 입력 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function daumPostcode() {
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
                    document.getElementById("extraAddr").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddr").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddr").focus();
            }
        }).open();
    }
</script>

<!-- java script: 입력 확인 -->
<script>
	function check(){
		//멤버 타입 확인 radio
		let num1=0;
		let type=document.getElementsByName("mebType");
		for (let i=0;i<type.length;i++){
			if (type[i].checked == true){
				num1++;
				break;
			}
		}
		if(num1 == 0){
			alert("회원 타입을 체크하세요.");
			return false;
		}
		if(document.form.password.value==""){
			alert("비밀번호를 입력하세요");
			document.form.password.focus();
			return false;
		}
		if(document.form.userName.value==""){
			alert("이름을 입력하세요");
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
			alert("성별을 체크하세요.");
			return false;
		}
		if(document.form.birth.value.length !=8 || isNaN(document.form.birth.value)){
			alert("생년월일 8자리을 입력하세요");
			document.form.birth.focus();
			return false;
		}
		if(document.form.mailFront.value==""){
			alert("이메일 주소를 입력하세요");
			document.form.mailFront.focus();
			return false;
		}
		if(document.form.mailEnd.value==""){
			alert("이메일 도메인을 선택하세요");
			document.form.mailEnd.focus();
			return false;
		}
		if(document.form.phone.value.length !=11 || isNaN(document.form.phone.value)){
			alert("연락처에는 11자리의 숫자만 입력해주세요.");
			document.form.phone.focus();
			return false;
		}
		/* if(document.form.postcode.value==""){
			alert("주소를 입력하세요");
			document.form.postcode.focus();
			return false;
		} */
		if(document.form.cafeName.value==""){
			alert("카페 이름을 입력하세요");
			document.form.cafeName.focus();
			return false;
/* 		var mebType=document.querySelector('input[name="mebType"]:checked').value;
		System.out.println(mebType);
		if(mebType.equls("nat")){
			System.out.println("nat")
		}else{
			System.out.println("exp")
			return false;
		} */
		
		document.form.submit();
	}

	
</script>

<!-- java script: 탐험가/토박이 구분에 따라 다르게 보이는 입력창 -->
<script>
	function showDiv(element){
		var tag=document.getElementsByClassName("box");
		console.log(tag);
		
		for(var i=0;i<tag.length;i++){
			if(element.id+"Box"==tag[i].id)
				tag[i].style.display="block";
			else
				tag[i].style.display="none";
		}
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
	    mailEnd.disabled = true
	  } else { // 직접 입력 시
	    // input 내용 초기화 & 입력 가능하도록 변경
	    mailEnd.value = ""
	    mailEnd.disabled = false
	  }
	})
</script>



</body>
</html>