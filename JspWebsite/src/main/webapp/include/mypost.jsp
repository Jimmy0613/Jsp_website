<%@page import="com.cre.w.dto.MemberDTO"%>
<%@page import="com.cre.w.dto.PostDTO"%>
<%@page import="com.cre.w.sys.Board"%>
<%@page import="java.util.ArrayList"%>
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
	MemberDTO me = (MemberDTO) session.getAttribute("loginMember");
	ArrayList<PostDTO> mypost = (ArrayList<PostDTO>)request.getAttribute("list");
	%>
	<span id="t">내가 쓴 글</span>
	<br>
	<div class="list">
		<div class="list_m">
			<div class="list_n" style="background-color: white;">
				<div></div>
				<div>게시판</div>
				<div>제목</div>
				<div>♡</div>
				<div>조회수</div>
				<hr>
			</div>
			<div class="list_z">
				<%
				if (mypost.size() != 0) {
					Board bo = new Board();
					for (PostDTO p : mypost) {
						String category = bo.switchCategory(p.getCategory());
						String title = "";
						if (p.getTitle().length() > 16) {
					title = p.getTitle().substring(0, 16) + "...";
						} else {
					title = p.getTitle();
						}
				%>
				<div class="list_n">
					<div></div>
					<div><%=category%></div>
					<div style="text-align: left;">
						<a
							href="/web/read?postNum=<%=p.getpNum()%>&category=<%=p.getCategory()%>"><%=title%></a>
						<%
						if (p.getReply() > 0) {
						%>
						(<%=p.getReply()%>)
						<%
						}
						%>
					</div>
					<div><%=p.getHeart()%></div>
					<div><%=p.getViews()%></div>
				</div>
				<%
				}
				%>
				<%
				} else {
				%>
				<div>작성한 글이 없습니다.</div>
				<%
				}
				%>
			</div>
			<div class="page">
				<%@ include file="/include/pageMypage.jsp"%>
			</div>
		</div>
	</div>
</body>
</html>