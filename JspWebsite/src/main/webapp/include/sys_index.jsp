<%@page import="com.cre.w.dto.MemberDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
	String loginInfo = "🙂 먼저 로그인해주세요.";
	if (loginMember != null) {
		loginInfo = "🙂 " + loginMember.getId() + "(" + loginMember.getName() + ") 님";
	}
	%>
	<div id="s_info">
		<div id="c_mode">&nbsp;&nbsp;🍀 홈</div>
	</div>
	<div id="s_menu_right_t">메뉴</div>
	<div id="s_content"></div>

	<%
	if (loginMember == null) {
	%>
	<div id="s_menu_right">
		<div class="icon" id="icon1">
			<a href="index_rpg.jsp"><img src="img/home.png"></a>
		</div>
		<b class="icon_t" id="icon1_t">홈</b>
		<div class="icon" id="icon2">
			<a href="join.jsp?location=../index_rpg.jsp"><img src="img/join.png"></a>
		</div>
		<b class="icon_t" id="icon2_t">가입</b>

		<div class="icon" id="icon3">
			<a href="login.jsp?location=../character.jsp"><img src="img/login.png"></a>
		</div>
		<b class="icon_t" id="icon3_t">로그인</b>
	</div>
	<div id="s_banner_bot"><%=loginInfo%></div>
	<%
	} else {
	%>
	<div id="s_menu_right">
		<div class="icon" id="icon1">
			<a href="index_rpg.jsp"><img src="img/home.png"></a>
		</div>
		<b class="icon_t" id="icon1_t">홈</b>
		<div class="icon" id="icon2">
			<a href="character.jsp"><img src="img/charac.png"></a>
		</div>
		<b class="icon_t" id="icon2_t">캐릭터</b>

		<div class="icon" id="icon3">
			<a href="ServletLogout?location=../index_rpg.jsp"><img
				src="img/logout.png"></a>
		</div>
		<b class="icon_t" id="icon3_t">로그아웃</b>
	</div>
	<div id="s_banner_bot">
		<%=loginInfo%>
	</div>
	<%
	}
	%>


</body>
</html>
