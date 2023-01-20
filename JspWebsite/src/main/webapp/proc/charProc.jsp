<%@page import="com.cre.w.dto.MemberDTO"%>
<%@page import="com.cre.w.sys.Member"%>
<%@page import="com.cre.w.sys.Charac"%>
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
	Member member = new Member();
	Charac character = new Charac();
	MemberDTO loginMember = (MemberDTO)session.getAttribute("loginMember");
	String loginC1 = loginMember.getCharacter1();
	String loginC2 = loginMember.getCharacter2();
	String input_name = request.getParameter("c_name");
	String alert = character.newAlert(input_name);

	if (alert.equals("")) {
		character.newCharacter(input_name, loginMember.getId());
		if (loginC1.equals("x")) {
			member.updateCharacter("CHARACTER1", input_name, loginMember.getId());
			loginMember.setCharacter1(input_name);
			member.memberUpdate(loginMember);
		} else {
			member.updateCharacter("CHARACTER2", input_name, loginMember.getId());
			loginMember.setCharacter2(input_name);
			member.memberUpdate(loginMember);
		}
		out.println("<script>location.href='../character.jsp'</script>");
	} else {
		out.println("<script>alert('사용할 수 없는 이름입니다. " + alert + "')</script>");
		out.println("<script>location.href='../newChar.jsp'</script>");
	}
	%>
</body>
</html>