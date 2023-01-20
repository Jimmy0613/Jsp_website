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
	<div class="member">
		<%
		MemberDTO member = (MemberDTO) session.getAttribute("loginMember");
		%>
		<div class="member_info">
			<%
			if (member == null) {
			%>
			<div>
				<form class="login" action="ServletLogin">
					<input type="hidden" name="location" value="../board.jsp">
					<p>
						아이디<br> <input name="id"><br>비밀번호<br> <input
							name="pw" type="password"> <br>
						<button id="login_button" type="submit">로그인</button>
						<a href="join.jsp?location=../index.jsp"> 회원가입 </a>
					</p>
				</form>
			</div>
			<%
			} else {
			%>
			<div class="login_info">
				<span><%=member.getInfo()%> </span>
				<div id="f">
					<button id="memberinfo" onclick="location.href='mypage.jsp'">회원정보</button>
					<form id="logout" action="ServletLogout">
						<input type="hidden" name="location" value="../index.jsp">
						<button type="submit">로그아웃</button>
					</form>
				</div>
			</div>
		</div>
		<%
		}
		%>
		<hr>
	</div>
	<div>
		<form action="search.jsp">
			<p id="search">
				<input type="hidden" name="category" value="all"> <input
					type="hidden" name="key" value="title"> <input
					name="keyword" placeholder="검색어 입력">
				<button type="submit">검색</button>
			</p>
		</form>
	</div>
	<div class="board">
		<div>
			<p class="board_name">
				<a href="board.jsp?category=notice&page=1">공지사항</a>
			</p>
		</div>
		<div>
			<p class="board_name">
				<a href="board.jsp?category=general&page=1">자유게시판</a>
			</p>
		</div>
		<div>
			<p class="board_name">
				<a href="board.jsp?category=anonym&page=1">익명게시판</a>
			</p>
		</div>
		<div>
			<p class="board_name">
				<a href="board.jsp?category=report&page=1">신고게시판</a>
			</p>
		</div>
	</div>
</body>
</html>