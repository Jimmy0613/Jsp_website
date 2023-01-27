<%@page import="com.cre.w.dto.PostDTO"%>
<%@page import="com.cre.w.Board"%>
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
String styleCss = application.getRealPath("/css/search.css");
File style = new File(styleCss);
Date lastModifiedStyle = new Date(style.lastModified());
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<link rel="stylesheet"
	href="/css/common.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="/css/board.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="/css/list.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="/css/search.css?ver=<%=fmt.format(lastModifiedStyle)%>">
</head>
<body>
	<div class="container">
		<div class="header">
			<div class="title"></div>
			<div class="menu">
				<%@include file="/include/menuTop.jsp"%>
			</div>
		</div>
		<div class="content">
			<div class="menu_left">
				<%@ include file="/include/menuLeft.jsp"%>
			</div>
			<div class="list">
				<%
				String keyword = (String) request.getAttribute("keyword");
				ArrayList<PostDTO> searchList = (ArrayList<PostDTO>) request.getAttribute("list");
				%>
				<div style="font-size: 1.2em; font-weight: bolder; color: black;">검색
				</div>
				<br>
				<div id="search">
					<form action="/board/search">
						<span> <select name="key">
								<option value="title">제목</option>
								<option value="content">내용</option>
								<option value="writer">작성자</option>
						</select> <select name="category">
								<option value="all">전체</option>
								<option value="general">자유</option>
								<option value="anonym">익명</option>
						</select> <input name="keyword" value="<%=keyword%>">
							<button type="submit">검색</button>
						</span>
					</form>
				</div>
				<div class="list_s">
					<div class="list_n" style="color: black;">
						<div>게시판</div>
						<div>작성자</div>
						<div>제목</div>
						<div>♡</div>
						<div>조회수</div>
						<hr>
					</div>
					<div class="list_z">
						<%
						if (searchList.size() != 0) {
							for (PostDTO p : searchList) {
						%>
						<div class="list_n" style="background-color: white;">
							<%
							if (p.getCategory().equals("anonym")) {
							%>
							<div>익명</div>
							<div>익명</div>
							<%
							} else {
							%>
							<div>자유</div>
							<div><%=p.getWriter()%></div>
							<%
							}
							%>
							<div id="t">
								<%
								String title = "";
								if (p.getTitle().length() > 10) {
									title = p.getTitle().substring(0, 10) + "...";
								} else {
									title = p.getTitle();
								}
								%>
								<script>
									function openPost(url) {
										window
												.open(url, "_blank",
														"left=100px, width=1000, height=1000");
									}
								</script>
								<a style="cursor: pointer;" title="<%=p.getTitle()%>"
									onclick="openPost('/board/read?postNum=<%=p.getpNum()%>&page=1&category=<%=p.getCategory()%>')"><%=title%>
									<%
									if (p.getReply() > 0) {
									%> (<%=p.getReply()%>) <%
									}
									%></a>
							</div>
							<div><%=p.getHeart()%></div>
							<div><%=p.getViews()%></div>
						</div>
						<%
						}
						} else {
						%>
						검색 결과가 없습니다.
						<%
						}
						%>
					</div>
				</div>
				<!-- 페이징 부분 -->
				<div class="page">
					<%@ include file="/include/pageSearch.jsp"%>
				</div>
				<!-- 페이징 부분 -->
			</div>
		</div>
	</div>
</body>
</html>