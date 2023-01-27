<%@page import="com.cre.w.dto.ReplyDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="com.cre.w.Board"%>
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
<script type="text/javascript">
	function del_confirm() {
		var ok = confirm("정말 삭제하시겠습니까?");
		var formDelete = document.formDelete;
		var postNum = formDelete.postNum.value;
		var page = formDelete.page.value;
		var category = formDelete.category.value;
		if (ok) {
			formDelete.method = "get";
			formDelete.action = "/board/delete";
			formDelete.submit();
		} else {
			location.href = "/board/read?postNum=" + postNum + "&page="
					+ category + "&category=" + category;
		}
	}
</script>

<%
/* CSS/JS 파일 캐시 방지 */
String styleCss = application.getRealPath("/css/board.css");
File style = new File(styleCss);
Date lastModifiedStyle = new Date(style.lastModified());
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<link rel="stylesheet"
	href="/css/common.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="/css/board.css?ver=<%=fmt.format(lastModifiedStyle)%>">
</head>
<body>
	<%
	MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
	int currentPage = (Integer) request.getAttribute("page");
	String postNum = (String) request.getAttribute("postNum");
	PostDTO post = (PostDTO) request.getAttribute("post");
	String category = (String) request.getAttribute("category");
	String category2 = (String) request.getAttribute("cgKorean");
	ArrayList<ReplyDTO> reply = (ArrayList<ReplyDTO>) request.getAttribute("reply");
	%>
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
			<div class="post">
				<div style="font-size: 1.2em; font-weight: bolder; color: black;"><%=category2%>게시판
				</div>
				<br>
				<div class="p">
					<div id="p" style="font-weight: bolder"><%=post.getTitle()%>
					</div>
					<div id="p">
						<%
						if (category.equals("anonym")) {
						%>
						익명
						<%
						} else {
						%>
						<%=post.getWriter()%>
						<%
						}
						%>
						|
						<%=post.getpDate()%>
						| 조회수
						<%=post.getViews()%></div>
					<div id="c"><%=post.getContent()%></div>
					<div id="p" style="display: flex;">
						댓글
						<%=post.getReply()%>개 | 하트
						<%=post.getHeart()%>개
						<%
					if (loginMember != null) {
					%>
						<form action="/board/heart">
							<input type="hidden" name="postNum" value="<%=post.getpNum()%>">
							<input type="hidden" name="category" value="<%=category%>">
							<input type="hidden" name="page" value="<%=currentPage%>">
							<button id="heartBtn" type="submit">❤</button>
						</form>
						<%
						}
						%>
					</div>
					<hr style="height: 0.1px; width: 95%;">
					<div id="p" style="color: black; font-size: 0.9em;">
						<%
						if (reply.size() != 0) {

							for (ReplyDTO r : reply) {
						%>
						<div id="reply">
							<%
							if (category.equals("anonym")) {
							%>
							익명:
							<%
							} else {
							%>
							<%=r.getWriter()%>:
							<%
							}
							%>
							<%=r.getContent()%>
							(<%=r.getrDate()%>)
							<%
							if (loginMember != null) {
								if (r.getWriter().equals(loginMember.getName())) {
									String formId = "form" + r.getrNum();
							%>
							<form id="<%=formId%>" method="get" action="/board/delReply"
								encType="UTF-8">
								<input type="hidden" name="postNum" value="<%=postNum%>">
								<input type="hidden" name="reNum" value="<%=r.getrNum()%>">
								<input type="hidden" name="category" value="<%=category%>">
								<input type="hidden" name="page" value="<%=currentPage%>">
								<a type="submit" onclick="document.getElementById('<%=formId%>').submit();">(x)</a>
							</form>
							<%
							}
							}
							%>
						</div>
						<%
						}
						} else {
						%>
						<div id="reply">아직 댓글이 없습니다.</div>
						<%
						}
						%>
						<%
						if (loginMember != null) {
						%>
						<form class="reply" action="/board/reply">
							<input type="hidden" value="<%=postNum%>" name="postNum">
							<input type="hidden" value="<%=category%>" name="category">
							<input type="hidden" value="<%=currentPage%>" name="page">
							<input name="conReply" placeholder=" (댓글 작성)">
							<button type="submit">등록</button>
						</form>
						<%
						}
						%>
					</div>
				</div>
				<div id="edl">
					<%
					if (loginMember != null) {
						if (loginMember.getName().equals(post.getWriter()) || loginMember.getId().equals("manager")) {
					%>
					<button
						onclick="location.href='/edit.jsp?postNum=<%=postNum%>&category=<%=category%>&page=<%=currentPage%>'">수정</button>

					<form name="formDelete"	encType="UTF-8">
						<input type="hidden" name="postNum" value="<%=postNum%>">
						<input type="hidden" name="category" value="<%=category%>">
						<input type="hidden" name="page" value="<%=currentPage%>">
						<button onclick="del_confirm()">삭제</button>
					</form>
					<%
					}
					}
					%>
					<button
						onclick="location.href='/board/board?category=<%=category%>&page=<%=currentPage%>'">목록</button>
				</div>
			</div>
		</div>
	</div>

</body>
</html>