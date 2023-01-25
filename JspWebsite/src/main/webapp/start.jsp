<%@page import="com.cre.w.dto.MapDTO"%>
<%@page import="com.cre.w.dto.CharacterDTO"%>
<%@page import="com.cre.w.sys.Map"%>
<%@page import="com.cre.w.sys.Log"%>
<%@page import="com.cre.w.sys.Charac"%>
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
	Charac character = new Charac();
	Log log = new Log();
	String c_name = request.getParameter("c_name");
	CharacterDTO player = character.getCharacter(c_name);
	session.setAttribute("player", player);
	session.setAttribute("m_id", player.getLocation());
	log.load();
	log.send("[ " + Log.turnCount + " ] 환영합니다!", "good");
	log.send("💡 시스템 메시지는 캐릭터 변경, 로그아웃시 초기화됩니다.", "tip");
	response.sendRedirect(player.getLocation() + ".jsp?mode=normal");
	%>
</body>
</html>