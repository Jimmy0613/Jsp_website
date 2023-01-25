<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="com.cre.w.sys.Board"%>
<%@page import="com.cre.w.dto.PostDTO"%>
<%@page import="com.cre.w.dao.BoardDAO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
/* CSS/JS 파일 캐시 방지 */
String styleCss = application.getRealPath("/css/board.css");
File style = new File(styleCss);
Date lastModifiedStyle = new Date(style.lastModified());
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<link rel="stylesheet"
	href="css/common.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="css/board.css?ver=<%=fmt.format(lastModifiedStyle)%>">
</head>
<body>
	<%
	String currentPage = request.getParameter("page");
	String postNum = request.getParameter("postNum");
	String category = request.getParameter("category");
	if (category == null) {
		category = "popular";
	}
	%>
	<div class="container">
		<div class="header">
			<div class="title"></div>
			<div class="menu">
				<%@include file="include/menuTop.jsp"%>
			</div>
		</div>
		<div class="content">
			<div class="menu_left">
				<%@ include file="include/menuLeft.jsp"%>
			</div>
			<div class="post">
				<jsp:include page="include/post.jsp">
					<jsp:param value="<%=postNum%>" name="postNum" />
					<jsp:param value="<%=category%>" name="category" />
					<jsp:param value="<%=currentPage%>" name="page" />
				</jsp:include>
			</div>
		</div>
	</div>

</body>
</html>