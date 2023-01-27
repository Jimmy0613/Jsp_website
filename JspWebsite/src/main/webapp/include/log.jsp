<%@page import="com.cre.w.dto.LogDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="com.cre.w.sys.Log"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지난 기록</title>
<%
String styleCss = application.getRealPath("/css/common.css");
File style = new File(styleCss);
Date lastModifiedStyle = new Date(style.lastModified());
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<link rel="stylesheet"
	href="/css/popup.css?ver=<%=fmt.format(lastModifiedStyle)%>">
</head>
<body>
	<%
	Log log = new Log();
	ArrayList<LogDTO> dtos = log.select();
	String str = "";
	for (LogDTO l : dtos) {
		str = l.getLog();
	%>
	<%=str%>
	<br>
	<%
	}
	%>
</body>
</html>