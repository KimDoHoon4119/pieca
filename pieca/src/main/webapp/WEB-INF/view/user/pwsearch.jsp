<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- /shop1/src/main/webapp/WEB-INF/view/user/pwsearch.jsp--%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<link href="../css/pieca.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<div id="pwsearch_container" style="width:80%; margin:0% 0% 0% 19.5%;">
	<div id="pwsearch_logo" style="width:296px; text-align:center; margin:20px 0px 20px 0px;">
		<img src="../img/PIECA_logo.png" style="width:140px; height:70px;">
	</div>
	<form:form modelAttribute="user" action="pwsearch" method="post">
	
	<div id="pwsearch_global_error"style="font-size: 13px; margin:0px 0px 10px 0px;">
		<spring:hasBindErrors name="user">
			<font color="red">
				<c:forEach items="${errors.globalErrors}" var="error">
					<spring:message code="${error.code}" />
				</c:forEach>
			</font>
		</spring:hasBindErrors>
	</div>
	
	<div id="pwsearch_userid_title" style="display: inline;">
		아이디
	</div>
	<div id="pwsearch_userid_error" style="display: inline; font-size: 13px;">
		<input type="hidden" id="pwsearch_mode_userid">
		<font color="red"><form:errors path="userid" /></font>
		<div id="pwsearch_useridChk" style="display: inline; font-size: 13px;"></div>
	</div>
	<div id="pwsearch_userid_input" style="margin:5px 0px 20px 0px; ">
		<input type="text" name="userid" id="pwsearch_input_userid" oninput="useridChk(); idChk();" style="border:2px solid #747474; border-radius: 6px; font-size:15px; width:71%; height:40px; padding-left: 15px;" placeholder="아이디를 입력 해주세요.">
	</div>
			
	<div id="pwsearch_email_title" style="display: inline;">		
		이메일
	</div>
	<div id="pwsearch_email_error" style="display: inline; font-size: 13px;">
		<input type="hidden" id="pwsearch_mode_email">
		<font color="red"><form:errors path="email" /></font>
		<div id="pwsearch_emailChk" style="display: inline; font-size: 13px;"></div>
	</div>
	<div id="pwsearch_email_input" style="margin:5px 0px 20px 0px; ">	
		<input type="text" name="email" id="pwsearch_input_email" oninput="emailChk(); idChk();" style="border:2px solid #747474; border-radius: 6px; font-size:15px; width:71%; height:40px; padding-left:15px;" placeholder="이메일을 입력 해주세요.">
	</div>
			
	<div id="pwsearch_phoneno_title" style="display: inline;">			
		전화번호
	</div>
	<div id="pwsearch_phoneno_error" style="display: inline; font-size: 13px;">
		<input type="hidden" id="pwsearch_mode_phone">
		<font color="red"><form:errors path="phoneno"/></font>
		<div id="pwsearch_phoneChk" style="display: inline; font-size: 13px;"></div>
	</div>
	<div id="pwsearch_phoneno_input" style="margin:5px 0px 20px 0px; ">
		<input type="text" name="phoneno" id="pwsearch_input_phone" oninput="phonenoChk(); idChk();" style="border:2px solid #747474; border-radius: 6px; font-size:15px; width:71%; height:40px; padding-left:15px;" placeholder="핸드폰번호를 ' - ' 없이 입력 해주세요.">
	</div>
			
	
	<div id="pwsearch_result_container" style="font-size: 15px; margin:0px 0px 20px 0px;">
		<c:if test="${not empty result}">
			<input type="text" id="pwsearch_result" value="${result}" style="border:none; outline:none; width:18%; height:20px;" readonly="readonly">로 초기화 되었습니다.
			<P>로그인 후 비밀번호를 변경 해주세요.</P>
		</c:if>
	</div>
		
	<input type="submit" id="pwsearch_submit" value="비밀번호 검색"style="width:37.5%; height:44px; border:2px solid #D5D5D5; border-radius: 6px; background-color: #D5D5D5; font-size: 18px; color:white; cursor:pointer;">
	<input type="button" id="pwsearch_send_button" value="복사 및 전송" onclick="pwSend();" style="width:37.5%; height:44px; border:2px solid #D5D5D5; border-radius: 6px; background-color: #D5D5D5; font-size: 18px; color:white; cursor:pointer;">			
	</form:form>
	</div>
<script>
function pwSend() {
	var result = $("#pwsearch_result").val()
	opener.document.loginform.password.value='${result}';
	self.close();
	
	var result = document.getElementById("result")
	result.select();
	document.execCommand("copy");
}

$(document).ready(function () {
	$("#pwsearch_submit").attr("disabled",true);
	$("#pwsearch_send_button").attr("disabled",true);
	var result = $("#pwsearch_result").val();
	if (result != null) {
		$("#pwsearch_send_button").attr("disabled",false);
		$("#pwsearch_send_button").css("background-color","#FFBB00");		
		$("#pwsearch_send_button").css("border","2px solid #FFBB00");	
	} else {
		$("#pwsearch_send_button").attr("disabled",true);
		$("#pwsearch_send_button").css("background-color","#D5D5D5");
		$("#pwsearch_send_button").css("border","2px solid #D5D5D5");
	}
});

function useridChk() {
	var userid = $("#pwsearch_input_userid").val();
	if (userid != '') {
		$("#pwsearch_mode_userid").val("enable");
	} else {
		$("#pwsearch_mode_userid").val("disable");
	}
}

function emailChk() {
	var email = $("#pwsearch_input_email").val();
	var reg = /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+$/;
	if (reg.test(email)) {
		$("#pwsearch_emailChk").text("옳바른 형식입니다.");
		$("#pwsearch_emailChk").css("color","green");
		$("#pwsearch_mode_email").val("enable");
	} else {
		$("#pwsearch_emailChk").text("옳바른 형식이 아닙니다.");
		$("#pwsearch_emailChk").css("color","red");
		$("#pwsearch_mode_email").val("disable");
	}
}

function phonenoChk() {
	var phoneno = $("#pwsearch_input_phone").val();
	var phonenoLen = $("#pwsearch_input_phone").val().length;
	var reg = /^[0-9]{10,11}$/

	if ((reg.test(phoneno)) && (!phoneno.match(/\-/g) )) {
		$("#pwsearch_phoneChk").text("옳바른 형식입니다.");
		$("#pwsearch_phoneChk").css("color","green");
		$("#pwsearch_mode_phone").val("enable");
	}  else if (phoneno.match(/\-/g)) {
		$("#pwsearch_phoneChk").text("' - '없이 입력하세요.");
		$("#pwsearch_phoneChk").css("color","red");
		$("#pwsearch_mode_phone").val("disable");
	} else if (!reg.test(phoneno)) {
		$("#pwsearch_phoneChk").text("10, 11자리로 숫자만 입력하세요.");
		$("#pwsearch_phoneChk").css("color","red");
		$("#pwsearch_mode_phone").val("disable");
	}
}

function idChk() {
	var userid = $("#pwsearch_mode_userid").val();
	var email = $("#pwsearch_mode_email").val();
	var phone = $("#pwsearch_mode_phone").val();
	console.log(email)
	if ((userid == "enable") && (email == "enable") && (phone == "enable")) {
		$("#pwsearch_submit").attr("disabled",false);
		$("#pwsearch_submit").css("background-color","#2196F3");		
		$("#pwsearch_submit").css("border","2px solid #2196F3");		
	} else {
		$("#pwsearch_submit").attr("disabled",true);
		$("#pwsearch_submit").css("background-color","#D5D5D5");
		$("#pwsearch_submit").css("border","2px solid #D5D5D5");
	}
}
</script>	
</body>
</html>