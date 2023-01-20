<%@page import="com.cre.w.dto.PostDTO"%>
<%@page import="com.cre.w.sys.Board"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JspWebsite</title>
<%
/* CSS/JS 파일 캐시 방지 */
String styleCss = application.getRealPath("/css/index.css");
File style = new File(styleCss);
Date lastModifiedStyle = new Date(style.lastModified());
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<link rel="stylesheet"
	href="css/common.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="css/index.css?ver=<%=fmt.format(lastModifiedStyle)%>">
</head>
<body>
	<div class="container">
		<div class="header">
			<div class="title">Jsp Website</div>
			<div class="menu">
				<%@include file="include/menuTop.jsp"%>
			</div>
		</div>

		<div class="content">
			<%@include file="include/memberInfo.jsp"%>
			<div class="rps">하트얻기 가위바위보</div>
			<div class="notice">
				<p style="margin: 10px;">
					공지사항 <a href="board.jsp?category=notice" style="font-size: 0.8em;">더보기</a>
				</p>
				<div id="notice">
					<%
					Board board = new Board();
					ArrayList<PostDTO> notice = board.homeNotice();
					for (PostDTO p : notice) {
					%>
					<div id="n">
						[ 운영자 ] <a
							href="read.jsp?category=notice&page=1&postNum=<%=p.getpNum()%>"><%=p.getTitle()%></a>
						<hr>
					</div>
					<%
					}
					%>
				</div>
			</div>
			<div class="hot">
				<p style="margin: 10px;">
					인기글 <a href="board.jsp" style="font-size: 0.8em;">더보기</a>
				</p>
				<div id="hot">
					<%
					ArrayList<PostDTO> popular = board.homePopular();
					for (PostDTO p : popular) {
						String cgp = board.switchCategory(p.getCategory());
						String title = "";
						if (p.getTitle().length() > 16) {
							title = p.getTitle().substring(0, 16) + "...";
						} else {
							title = p.getTitle();
						}
					%>
					<div id="n">
						[
						<%=cgp%>
						] <a title="<%=p.getTitle()%>"
							href="read.jsp?page=1&postNum=<%=p.getpNum()%>"><%=title%> <%
 if (p.getReply() > 0) {
 %> (<%=p.getReply()%>) <%
 }
 %> &nbsp;&nbsp; (❤ <%=p.getHeart()%>) </a>
						<hr>
					</div>
					<%
					}
					%>
				</div>
			</div>
			<div class="game">rpg</div>
			<div class="lotto">로또</div>
		</div>
	</div>
</body>
</html>