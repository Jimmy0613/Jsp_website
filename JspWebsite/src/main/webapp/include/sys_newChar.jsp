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
	String loginInfo = "🙂 " + loginMember.getId() + "(" + loginMember.getName() + ") 님";
	%>
	<div id="s_info">
		<div id="c_mode">&nbsp;&nbsp;👩 캐릭터 만들기 🧑</div>
	</div>
	<div id="s_menu_right_t">메뉴</div>
	<div id="character">
		<div id="c_info">
			<form id="form_c" action="proc/charProc.jsp">
				<input type="hidden" name="id" value="<%=loginMember.getId()%>">
				이름:&nbsp;&nbsp; <input name="c_name" placeholder="2~6자">
				&nbsp;&nbsp;<br>
				<button type="submit">만들기</button>
			</form>
		</div>
	</div>
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
			<a href="proc/logoutProc.jsp?location=../index_rpg.jsp"><img
				src="img/logout.png"></a>
		</div>
		<b class="icon_t" id="icon3_t">로그아웃</b>
	</div>
	<div id="s_banner_bot">
		<%=loginInfo%>
	</div>

</body>
</html>
