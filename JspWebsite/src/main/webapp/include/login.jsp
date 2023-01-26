<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<form class="login" action="ServletLogin">
			<p>
				<input type="hidden" name="location" value="../index.jsp">
				아이디<br> <input name="id"><br>비밀번호<br> <input
					name="pw" type="password"> <br>
				<button id="login_button" type="submit">로그인</button>
				<a href="join.jsp?location=../index.jsp"> 회원가입 </a>
			</p>
		</form>
	</div>
</body>
</html>