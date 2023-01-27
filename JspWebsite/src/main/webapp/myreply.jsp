<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="com.cre.w.dto.ReplyDTO"%>
<%@page import="com.cre.w.dto.MemberDTO"%>
<%@page import="com.cre.w.dto.PostDTO"%>
<%@page import="com.cre.w.Board"%>
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
String styleCss = application.getRealPath("/css/mypage.css");
File style = new File(styleCss);
Date lastModifiedStyle = new Date(style.lastModified());
SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMddhhmmssSSS");
%>
<link rel="stylesheet"
	href="/css/common.css?ver=<%=fmt.format(lastModifiedStyle)%>">
<link rel="stylesheet"
	href="/css/mypage.css?ver=<%=fmt.format(lastModifiedStyle)%>">
</head>
<body>
	<%
	MemberDTO loginMember = (MemberDTO) session.getAttribute("loginMember");
	if (loginMember == null) {
		out.println("<script>alert('로그인 후 이용 가능한 페이지입니다.')</script>");
	%>
	<jsp:forward page="index.jsp"></jsp:forward>
	<%
	}
	int cup;
	if (request.getParameter("page") == null) {
	cup = 1;
	} else {
	cup = Integer.parseInt(request.getParameter("page"));
	}
	ArrayList<ReplyDTO> myreply = (ArrayList<ReplyDTO>) request.getAttribute("reply");
	%>
	<div class="container">
		<div class="header">
			<div class="title"></div>
			<div class="menu">
				<%@include file="/include/menuTop.jsp"%>
			</div>
		</div>
		<div class="content">
			<div class="mypage">
				<%@include file="/include/myinfo.jsp" %>
				<div id="x">
					<span id="t">내가 쓴 댓글</span> <br>
					<div class="list">
						<div class="list_m">
							<div class="list_n" style="background-color: white;">
								<div>게시판</div>
								<div>내용</div>
								<div>♡</div>
								<div>글번호</div>
								<hr>
							</div>
							<div class="list_z">
								<%
								if (myreply.size() != 0) {
									Board bo2 = new Board();
									for (ReplyDTO r : myreply) {
										String pNum = r.getpNum() + "";
										PostDTO po = bo2.selectPost(pNum);
										String category = "";
										if (po == null) {
									category = " ?? ";
										} else {
									category = bo2.switchCategory(po.getCategory());
										}
										String content = "";
										if (r.getContent().length() > 16) {
									content = r.getContent().substring(0, 16) + "...";
										} else {
									content = r.getContent();
										}
								%>
								<div class="list_n">
									<div><%=category%></div>
									<div style="text-align: left;">
										<%
										if (po == null) {
										%>
										<a title="삭제된 글입니다."><%=r.getContent()%></a>
										<%
										} else {
										%>
										<a
											href="/board/read?postNum=<%=r.getpNum()%>&category=<%=po.getCategory()%>&page=1"><%=r.getContent()%></a>
										<%
										}
										%>
									</div>
									<div></div>
									<div><%=pNum%></div>
								</div>
								<%
								}
								%>
								<br>
								<%
								} else {
								%>
								<div>작성한 댓글이 없습니다.</div>
								<%
								}
								%>
							</div>
							<div class="page">
								<%@ include file="/include/pageMyreply.jsp"%>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>