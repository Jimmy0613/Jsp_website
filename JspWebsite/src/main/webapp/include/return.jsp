<%@page import="com.cre.w.dto.MapDTO"%>
<%@page import="com.cre.w.dto.CharacterDTO"%>
<%@page import="com.cre.w.sys.Log"%>
<%@page import="com.cre.w.sys.Map"%>
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
	Map mapr = new Map();
	Charac cr = new Charac();
	CharacterDTO pr = (CharacterDTO) session.getAttribute("player");
	String midr = (String)session.getAttribute("m_id");
	String midr_jsp = midr + ".jsp";
	Log logr = new Log();
	if (pr.getPower() <= 0) {
		pr.setPower(0);
		cr.characterUpdate(pr);
		session.setAttribute("player", pr);
		logr.send("힘이 모두 빠져 ''나의 방''으로 소환되었습니다..", "bad");
	%>
	<jsp:forward page="<%=midr_jsp%>">
		<jsp:param value="normal" name="mode" />
	</jsp:forward>

	<%
	} else if (pr.getStory() < 6) {
	logr.send("❌ ''이야기 <6> 지도''를 먼저 완료해야 합니다.", "bad");
	%>
	<jsp:forward page="<%=midr_jsp %>">
		<jsp:param value="normal" name="mode" />
	</jsp:forward>
	<%
	} else {
	%>
	<jsp:forward page="m_1.jsp">
		<jsp:param value="move" name="mode" />
	</jsp:forward>
	<%
	}
	%>
</body>
</html>