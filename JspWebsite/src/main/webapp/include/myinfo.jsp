<%@page import="com.cre.w.dto.UserDTO"%>
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
UserDTO user = (UserDTO)session.getAttribute("loginUser");
%>
	<div class="myInfo">
		<span id="t">회원 정보</span><span style="font-size: 0.8em;">
			&nbsp;<a href="/user/logout?location=/index.jsp">로그아웃</a>
		</span>
		<hr>
		<div id="p">
			<div id="y">
				<div>
					<b>이름</b> <br> <b>아이디</b> <br> <b>이메일</b>
				</div>
				<div><%=user.getName()%><br><%=user.getId()%><br>
					<%
					if (user.getEmail().equals("")) {
					%>
					<a href="/mypage.jsp?mode=myemail">등록</a>
					<%
					} else {
					%>
					<%=user.getEmail()%><a href="/mypage.jsp?mode=myemail"><br>변경</a>
					<%
					}
					%>
				</div>
			</div>
			<div id="y">
				<div>
					<b>하트(<b style="color:red;">❤</b>)</b><br> <b>작성 글</b><br> <b>작성 댓글</b><br>
				</div>
				<div>
					<%=user.getHeart()%>
					개<a href="/board/read?category=notice&postNum=135"><img
							src="/img/questionmark.jpg"
							style="width: 20px; vertical-align: center;" title="하트 관련 공지입니다."></a><br> <a href="/board/mypost"><%=user.getPCount()%> 개</a><br>
					<a href="/board/myreply"><%=user.getRCount()%> 개</a><br>
				</div>
			</div>
		</div>
	</div>
</body>
</html>