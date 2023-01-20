<%@page import="com.cre.w.dto.CharacterDTO"%>
<%@page import="com.cre.w.dto.MapDTO"%>
<%@page import="com.cre.w.sys.Log"%>
<%@page import="com.cre.w.sys.Charac"%>
<%@page import="com.cre.w.sys.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>집 앞</title>
<link rel="stylesheet" href="css/m_6.css">

</head>
<body>
	<%
	Map map7 = new Map();
	Log log = new Log();
	String id7 = request.getParameter("m_id");
	MapDTO m7 = map7.getMap(id7);
	CharacterDTO p7 = (CharacterDTO)session.getAttribute("player");
	String mode = request.getParameter("mode");
	%>
	<div id="t">
		<%@include file="title.jsp"%>
	</div>
	<div id="n"></div>
	<div id="w"><!-- m_6 마당 -->
		<button id="we_btn"
			onclick="location.href='game.jsp?m_id=m_6&mode=move'">마당</button>
	</div>
	<!------------------스크린 ------------------>
	<div id="screen_c">
		<%
		switch (mode) {
		case "move":
			map7.move(m7, p7);
		case "normal":
			out.println("준비중 ㅎㅎ");
		break;
		case "action1":
	
		break;
		case "action2":
		
		}
		%>
	</div>
	<!------------------스크린 ------------------>
	<div id="e"></div>
	<div id="s"></div>
</body>
</html>