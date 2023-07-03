<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/jspHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link href="../css/pieca.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<div id="idsearch_container">
	<div id="idsearch_logo">
		<img src="../img/PIECA_logo.png" style="width:140px; height:70px;">
	</div>
	
	<form:form modelAttribute="user" action="idsearch" method="post">
	
	<div id="idsearch_global_error">
		<spring:hasBindErrors name="user">
			<font color="red"><c:forEach items="${errors.globalErrors}"
					var="error">
					<spring:message code="${error.code}" />
				</c:forEach></font>
		</spring:hasBindErrors>
	</div>
		
	<div id="idsearch_email_title">
		이메일
	</div>
	<div id="idsearch_email_error">
		<input type="hidden" id="idsearch_mode_email">
		<font color="red"><form:errors path="email" id="idsearch_error_email"/></font>
		<div id="idsearch_emailChk"></div>
	</div>
	<div id="idsearch_email_input">
		<input type="text" name="email" id="idsearch_input_email" oninput="emailChk(); idChk();" placeholder="이메일을 입력 해주세요.">
	</div>
				
	<div id="idsearch_phoneno_title">
		전화번호
	</div>
	<div id="idsearch_phoneno_error">
		<input type="hidden" id="idsearch_mode_phone">
		<font color="red"><form:errors path="phoneno"/></font>
		<div id="idsearch_phoneChk"></div>
	</div>
	<div id="idsearch_phoneno_input">
		<input type="text" name="phoneno" id="idsearch_input_phone" oninput="phonenoChk(); idChk();" placeholder="핸드폰번호를 ' - ' 없이 입력 해주세요.">
	</div>
	
	<div id="idsearch_display_container">
		<c:if test="${not empty result}">
			<c:set var="userid" value="${result}"/>
			<c:set var="length" value="${fn:length(result)}"/>
			<c:set var="display" value = "${fn:substring(userid, 0, length-3)}" />
			<input type="text" id="idsearch_display" value="회원님의 아이디는 ${display}*** 입니다." readonly="readonly">
		</c:if>
	</div>			
				
	<input type="submit" id="idsearch_submit" value="아이디 검색">
	<input type="button" id="idsearch_send_button" value="아이디 전송" onclick="idSend();">
	</form:form>
	</div>
<script>
function idSend() {
	opener.document.loginform.userid.value='${display}***';
	self.close();
}

$(document).ready(function () {
	$("#idsearch_submit").attr("disabled",true);
	$("#idsearch_send_button").attr("disabled",true);
	var display = $("#idsearch_display").val();
	console.log(display)
	if (display != null) {
		$("#idsearch_send_button").attr("disabled",false);
		$("#idsearch_send_button").css("background-color","#FFBB00");		
		$("#idsearch_send_button").css("border","2px solid #FFBB00");	
	} else {
		$("#idsearch_send_button").attr("disabled",true);
		$("#idsearch_send_button").css("background-color","#D5D5D5");
		$("#idsearch_send_button").css("border","2px solid #D5D5D5");
	}
});

function emailChk() {
	var email = $("#idsearch_input_email").val();
	var reg = /^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+$/;
	if (reg.test(email)) {
		$("#idsearch_emailChk").text("옳바른 형식입니다.");
		$("#idsearch_emailChk").css("color","green");
		$("#idsearch_mode_email").val("enable");
	} else {
		$("#idsearch_emailChk").text("옳바른 형식이 아닙니다.");
		$("#idsearch_emailChk").css("color","red");
		$("#idsearch_mode_email").val("disable");
	}
}

function phonenoChk() {
	var phoneno = $("#idsearch_input_phone").val();
	var phonenoLen = $("#idsearch_input_phone").val().length;
	var reg = /^[0-9]{10,11}$/

	if ((reg.test(phoneno)) && (!phoneno.match(/\-/g) )) {
		$("#idsearch_phoneChk").text("옳바른 형식입니다.");
		$("#idsearch_phoneChk").css("color","green");
		$("#idsearch_mode_phone").val("enable");
	}  else if (phoneno.match(/\-/g)) {
		$("#idsearch_phoneChk").text("' - '없이 입력하세요.");
		$("#idsearch_phoneChk").css("color","red");
		$("#idsearch_mode_phone").val("disable");
	} else if (!reg.test(phoneno)) {
		$("#idsearch_phoneChk").text("10, 11자리로 숫자만 입력하세요.");
		$("#idsearch_phoneChk").css("color","red");
		$("#idsearch_mode_phone").val("disable");
	}
}

function idChk() {
	var email = $("#idsearch_mode_email").val();
	var phone = $("#idsearch_mode_phone").val();
	console.log(email)
	if ((email == "enable") && (phone == "enable")) {
		$("#idsearch_submit").attr("disabled",false);
		$("#idsearch_submit").css("background-color","#008000");		
		$("#idsearch_submit").css("border","2px solid #008000");		
	} else {
		$("#idsearch_submit").attr("disabled",true);
		$("#idsearch_submit").css("background-color","#D5D5D5");
		$("#idsearch_submit").css("border","2px solid #D5D5D5");
	}
}
</script>	
</body>
</html>