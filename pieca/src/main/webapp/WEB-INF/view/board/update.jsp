<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- /shop1/src/main/webapp/WEB-INF/view/user/update.jsp --%>
<%@ include file="/WEB-INF/view/jspHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자정보 수정</title>
</head>
<body>
<h2>사용자 수정</h2>
<form:form modelAttribute="user" method="post" action="update">
 <spring:hasBindErrors name="user">
    <font color="red">
      <c:forEach items="${errors.globalErrors}" var="error">
        <spring:message code="${error.code}" /><br>
      </c:forEach>
    </font>
 </spring:hasBindErrors>
 <table class="w3-table">
   <tr><td width="10%">아이디</td><td><form:input path="userid" readonly="true" class="w3-input"/>
        <font color="red"><form:errors path="userid" /></font></td></tr>
   <tr><td>비밀번호</td><td><form:password path="password" class="w3-input"/>
        <font color="red"><form:errors path="password" /></font></td></tr>
   <tr><td>이름</td><td><form:input path="username" class="w3-input"/>
        <font color="red"><form:errors path="username" /></font></td></tr>
   <tr><td>전화번호</td><td><form:input path="phoneno" class="w3-input"/></td></tr>
   <tr><td>이메일</td><td><form:input path="email" class="w3-input"/>
        <font color="red"><form:errors path="email" /></font></td></tr>
   <tr><td>생년월일</td><td><form:input path="birthday" class="w3-input"/>
        <font color="red"><form:errors path="birthday" /></font></td></tr>
   <tr><td class="w3-center" colspan="2">
           <input type="submit" value="회원수정" class="w3-btn w3-blue">
           <input type="reset" value="초기화" class="w3-btn w3-blue">
   </td></tr></table></form:form>
</body>
</html>