<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<%-- /shop1/src/main/webapp/layout/gdulayout.jsp --%>    

<!DOCTYPE html>
<html>
<head>
<title><sitemesh:write property="title" /></title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://kit.fontawesome.com/f060468afd.js" crossorigin="anonymous"></script>

<link href="../css/pieca.css" rel="stylesheet" type="text/css">

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src= 
"https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>
<script type="text/javascript"
	src="http://cdn.ckeditor.com/4.5.7/standard/ckeditor.js">
</script>
<sitemesh:write property="head" />
<style>
@font-face {
    font-family: 'KIMM_Bold';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2212@1.0/KIMM_Bold.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}

input::placeholder {
	font-family: 'KIMM_Bold';
}

input[type=password]{
	font-family: "arial";
}

body {
	margin: 0;
	font-family: 'KIMM_Bold';
}
::-webkit-scrollbar {
  display: none;
}

nav ul {
	top: 0px;
	transition-duration: 1.5s;
	box-shadow: 0px 3px 5px 0px #1B1B1B;
	width: 100%;
	position: fixed;
	background-color: #FFFFFF;
	list-style-type: none;
	/* 마진 패딩 지정하지 않으면 브라우저 기본 스타일을 따라 설정되므로 오버라이딩 필요 */
	margin: 0;
	padding: 0;
	z-index: 999;
}

/* li 는 블록요소인데 inline-block 으로 인라인속성 부여해서 나란히 배치*/
nav ul li {
	display: inline-block;
}

.map, .user {
	position: relative;
}

.board-menu {
	font-color: #1B1B1B;
	padding: 16px;
	font-size: 16px;
	cursor: pointer;
}

.board-content {
	display: none;
	position: absolute;
	margin-left: 25px;
	background-color: #f9f9f9;
	border : 1px solid #747474;
	border-radius: 6px;
	width: 100px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
}

a {
	text-decoration: none; 
}
.board-content a {
	color: black;
	padding: 12px 16px;
	display: block;
	text-align:center;
}

.home, .map, .board-menu, .news, .car, .login, .mypage, .logout{
	text-align:center;
	font-size: 22px;
}

.map, .board, .news, .car{
	width:8%;
}

.home {
	width:33%;
	text-align:center;
}

.login, .mypage {
	width:33%;
	text-align:center;
}


/* map-menu 에는 hover 적용이 안됨 */
.board:hover .board-content {
	display: block;
}

.contents {
	margin-top: 70px;
}
/* Clear floats after the columns */
.contents:after {
	content: "";
	display: table;
	clear: both;
}

#layout_top_btn, #layout_bottom_btn {
  position: fixed;
  width:40px;
  height:40px;
  top: 400px;
  right: 30px;
  background-color: #FFFFFF;
  color: #000000;
  padding: 2px;
  border-radius: 100px;
  font-size:30px;
  cursor: pointer;
}

#layout_bottom_btn {
  top: 460px;
}




</style>

</head>
<body>

 <div class="navbar">
	<nav>
		<ul>
			<li class="home">
				<a href="${path}/main/home">
					<img src="${path}/img/PIECA_logo.png" style="width:140px; height:70px;">
				</a>
			</li>
			
			<li class="map"><a href="${path}/place/location">충전소</a></li>
			
			<li class="board">
            	<div class="board-menu">
               		<span>Board</span>
            	</div>
            	<div class="board-content">
               		<a href="${path}/board/list?boardid=1">공지 사항</a>
               		<a href="${path}/board/list?boardid=2">정보 공유</a>
            	</div>
         	</li>
			
			<li class="news"><a href="${path}/news/main">News</a></li>
			<li class="car"><a href="${path}/car/list">Car</a></li>
			<c:if test="${empty sessionScope.loginUser}">
				<li class="login"><a class="fa-regular fa-user" href="${path}/user/login"></a></li>
			</c:if>
			<c:if test="${!empty sessionScope.loginUser}">
				<li class="mypage"style="margin-top:10px;">
					<a class="fa-regular fa-user" href="${path}/user/mypage?userid=${sessionScope.loginUser.userid}" style="margin-top:-15px;"></a>
					&nbsp;&nbsp;
					<a class="fa-solid fa-arrow-right-from-bracket" href="${path}/user/logout"></a>
				</li>
				<li class="logout"></li>
			</c:if>
			
		</ul>
	</nav>
</div>
<div class="contents">
	<button id="layout_top_btn" class="fa-solid fa-caret-up"></button>
	<button id="layout_bottom_btn" class="fa-solid fa-caret-down"></button>
	<sitemesh:write property="body"/>
</div>
  
  <!-- Footer -->
  <footer class="w3-container w3-padding-16 w3-light-grey">
    <h4>FOOTER</h4>
    <p>Powered by <a href="https://www.w3schools.com/w3css/default.asp" target="_blank">w3.css</a></p>
   	<hr>
   	<div>
   	</div> 
  </footer>
  <!-- End page content -->

<script>
document.getElementById("layout_top_btn").addEventListener("click", function() {
	window.scrollTo(0, 0);
	this.style.transform = "scale(1.3)";
	setTimeout(() => this.style.transform = "scale(1)", 200);
});

document.getElementById("layout_bottom_btn").addEventListener("click", function() {
	window.scrollTo(0, document.body.scrollHeight);
	this.style.transform = "scale(1.3)";
	setTimeout(() => this.style.transform = "scale(1)", 200);
});



loc = document.location.href.split("pieca/");

if (loc[1] == "main/home") {
$(window).on('load',function() {
	$("ul").css('background-color', '#1B1B1B');
	 $(".home").css('color', '#FFFFFF');
	    $(".map").css('color', '#FFFFFF');
	    $(".board span").css('color', '#FFFFFF');
	    $(".news").css('color', '#FFFFFF');
	    $(".car").css('color', '#FFFFFF');
	    $(".login").css('color', '#FFFFFF');
	    $(".mypage").css('color', '#FFFFFF');
	    $(".logout").css('color', '#FFFFFF');
	
  });
}

$(window).scroll(function() {
	if ($(window).scrollTop() > 1) {
	    $("ul").css('background-color', '#FFFFFF');
	    $(".home").css('color', '#1B1B1B');
	    $(".map").css('color', '#1B1B1B');
	    $(".board span").css('color', '#1B1B1B');
	    $(".news").css('color', '#1B1B1B');
	    $(".car").css('color', '#1B1B1B');
	    $(".login").css('color', '#1B1B1B');
	    $(".mypage").css('color', '#1B1B1B');
	    $(".logout").css('color', '#1B1B1B');
	}
	if ($(window).scrollTop() == 0) {
		if (loc[1] == "main/home") {
			$("ul").css('background-color', '#1B1B1B');
			$(".home").css('color', '#FFFFFF');
		    $(".map").css('color', '#FFFFFF');
		    $(".board span").css('color', '#FFFFFF');
		    $(".news").css('color', '#FFFFFF');
		    $(".car").css('color', '#FFFFFF');
		    $(".login").css('color', '#FFFFFF');
		    $(".mypage").css('color', '#FFFFFF');
		    $(".logout").css('color', '#FFFFFF');
		}
	}
});
</script>  
  

</body>
</html>