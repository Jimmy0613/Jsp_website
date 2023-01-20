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
	CharacterDTO pr = (CharacterDTO)session.getAttribute("player");
	MapDTO mr = mapr.getMap(request.getParameter("m_id"));
	Log log = new Log();
	if (pr.getPower() <= 0) {
		pr.setPower(0);
		cr.characterUpdate(pr);
		session.setAttribute("player", pr);
		log.send("힘이 모두 빠져 ''나의 방''으로 소환되었습니다..", "bad");
	%>
	<jsp:forward page="game.jsp">
		<jsp:param value="normal" name="mode" />
		<jsp:param value="<%=mr.getMapId()%>" name="m_id" />
	</jsp:forward>

	<%
	} else if (pr.getStory() < 6) {
			log.send("❌ ''이야기 <6> 지도''를 먼저 완료해야 합니다.", "bad");
	%>
	<jsp:forward page="game.jsp">
		<jsp:param value="normal" name="mode" />
		<jsp:param value="<%=mr.getMapId()%>" name="m_id" />
	</jsp:forward>
	<%
	} else {
	%>
	<jsp:forward page="game.jsp">
		<jsp:param value="move" name="mode" />
		<jsp:param value="m_1" name="m_id" />
	</jsp:forward>
	<%
	}
	%>
</body>
</html>