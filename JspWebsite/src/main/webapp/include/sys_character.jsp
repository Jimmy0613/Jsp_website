<%@page import="javax.xml.crypto.dsig.spec.C14NMethodParameterSpec"%>
<%@page import="com.cre.w.dto.CharacterDTO"%>
<%@page import="com.cre.w.dto.MemberDTO"%>
<%@page import="com.cre.w.sys.Charac"%>
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
	Charac ch = new Charac();

	MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
	String loginC1 = loginMember.getCharacter1();
	String loginC2 = loginMember.getCharacter2();
	
	%>
	<div id="s_info">
		<div id="c_mode">&nbsp;&nbsp;👩 캐릭터 선택 🧑</div>
	</div>
	<div id="s_menu_right_t">메뉴</div>
	<div id="character">
		<div id="c_info">
			<%
			if (loginC1.equals("x")) {
			%>
			<div id="form_c">
				[ 캐릭터 1 ] <br> <br>아직 캐릭터가 없습니다.<br> <br>
				<button class="btn" onclick="location.href='newChar.jsp'">만들기</button>
			</div>
			<%
			} else {
				CharacterDTO c1 = ch.getCharacter(loginC1);
			%>
			<div id="form_c">
				[ 캐릭터 1 ] <br> <br><%=c1.getProfile()%>
				<br> <br>
				<button class="btn"
					onclick="location.href='start.jsp?c_name=<%=c1.getName()%>'">선택하기</button>
			</div>
			<%
			}
			%>
		</div>
		<div id="c_info">
			<%
			if (loginC2.equals("x")) {
			%>
			<div id="form_c">
				[ 캐릭터 2 ] <br> <br>아직 캐릭터가 없습니다.<br> <br>
				<button class="btn" onclick="location.href='newChar.jsp'">만들기</button>
			</div>
			<%
			} else {
				CharacterDTO c2 = ch.getCharacter(loginC2);
			%>
			<div id="form_c">
				[ 캐릭터 2 ] <br> <br><%=c2.getProfile()%><br>
				<br>
				<button class="btn"
					onclick="location.href='start.jsp?c_name=<%=c2.getName()%>'">선택하기</button>
			</div>
			<%
			}
			%>
		</div>
	</div>
	<div id="s_menu_right">
		<div class="icon" id="icon1">
			<a href="index_rpg.jsp"><img src="img/home.png"></a>
		</div>
		<b class="icon_t" id="icon1_t">홈</b>

		<div class="icon" id="icon2">
			<a href="proc/logoutProc.jsp?location=../index_rpg.jsp"><img src="img/logout.png"></a>
		</div>
		<b class="icon_t" id="icon2_t">로그아웃</b>
	</div>
	<div id="s_banner_bot">
		<%=loginMember.getInfo()%>
	</div>
</body>
</html>
