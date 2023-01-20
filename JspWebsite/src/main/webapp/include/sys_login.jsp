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
	<div id="s_info">
		<div id="c_mode">&nbsp;&nbsp;🎈 로그인</div>
	</div>
	<div id="s_menu_right_t">메뉴</div>
	<div id="s_content">
		<form action="proc/loginProc.jsp">
			<p id="form_l">
			<input type="hidden" name="location" value="../index_rpg.jsp">
				<br> &nbsp;<b> 아이디</b> &nbsp;&nbsp; <input name="id"
					maxlength="12" required> <br>&nbsp; <b>비밀번호</b> <input
					name="pw" type="password" maxlength="14" required> <br>
				<br>
				<button type="submit" class="btn">로그인</button>
			</p>
		</form>
	</div>
	<div id="s_menu_right">
		<div class="icon" id="icon1">
			<a href="index_rpg.jsp"><img src="img/home.png"></a>
		</div>
		<b class="icon_t" id="icon1_t">홈</b>
	
		<div class="icon" id="icon2">
			<a href="join.jsp?location=../index_rpg.jsp"><img src="img/join.png"></a>
		</div>
		<b class="icon_t" id="icon2_t">가입</b>
	</div>
	<div id="s_banner_bot">
		🙂 먼저 로그인해주세요.
	</div>

</body>
</html>
