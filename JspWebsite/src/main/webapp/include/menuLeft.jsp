<%@page import="com.cre.w.dto.MemberDTO"%>
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
	MemberDTO member = (MemberDTO) session.getAttribute("loginMember");
	%>
	<div class="member">
		<div class="member_info" style="min-height:100px;">
		<p style="margin: 10px;">내 정보</p>
			<%
			if (member == null) {
			%>
			<div>
				<span style="color:grey;">로그인이 필요합니다.</span> <br><br> <a style="font-size: 0.9em;"
					href="/login.jsp?location=/web/board">로그인</a> <a
					style="font-size: 0.9em;" href="/join.jsp?location=/web/board">
					회원가입 </a>
			</div>
			<%
			} else {
			%>
			<div class="login_info">
				<span><%=member.getInfo()%> </span> <span
					style="text-align: center;">❤ <%=member.getHeart()%></span>
				<div id="f">
					<button id="memberinfo" onclick="location.href='/mypage.jsp'">회원정보</button>
					<form id="logout" action="/web/logout">
						<input type="hidden" name="location" value="/web/board">
						<button type="submit">로그아웃</button>
					</form>
				</div>
			</div>
			<%
			}
			%>
		</div>
		<hr>
	</div>
	<form action="/web/search">
		<p id="search">
			<input type="hidden" name="category" value="all"> <input
				type="hidden" name="key" value="title"> <input
				name="keyword" placeholder="검색어 입력">
			<button type="submit">검색</button>
		</p>
	</form>
	<div id="board_name">
		<div>
			<p class="board_name">
				<a href="/web/board?category=notice">공지사항</a>
			</p>
		</div>
		<div>
			<p class="board_name">
				<a href="/web/board?category=general">자유게시판</a>
			</p>
		</div>
		<div>
			<p class="board_name">
				<a href="/web/board?category=anonym">익명게시판</a>
			</p>
		</div>
		<div>
			<p class="board_name">
				<a href="/web/board?category=report">신고게시판</a>
			</p>
		</div>
	</div>
</body>
</html>