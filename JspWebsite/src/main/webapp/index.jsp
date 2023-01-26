<%@page import="com.cre.w.dao.RpsDAO"%>
<%@page import="com.cre.w.dto.RpsDTO"%>
<%@page import="com.cre.w.dto.MemberDTO"%>
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
	<%
	MemberDTO member = (MemberDTO) session.getAttribute("loginMember");
	%>
	<div class="container">
		<div class="header">
			<div class="title"></div>
			<div class="menu">
				<%@include file="include/menuTop.jsp"%>
			</div>
		</div>
		<div class="content">
			<div class="member_info">
				<p style="margin: 10px;">내 정보</p>
				<%
				if (member == null) {
				%>
				<div style="padding: 20px;">
					<span style="color: grey;">로그인이 필요합니다.</span> <br> <br> <a
						style="font-size: 0.9em;" href="login.jsp?location=../index.jsp">로그인</a>
					<a style="font-size: 0.9em;" href="join.jsp?location=../index.jsp">
						회원가입 </a>
				</div>
				<%
				} else {
				%>
				<div class="login_info"
					style="align-items: center; justify-content: center;">
					<div id="f">
						<div style="grid-column-start: 1; grid-column-end: 3;">
							<%=member.getInfo()%> | ❤ <%=member.getHeart()%>
						</div>
						<button id="memberinfo" onclick="location.href='mypage.jsp'">회원정보</button>
						<form id="logout" action="ServletLogout">
							<input type="hidden" name="location" value="../index.jsp">
							<button type="submit">로그아웃</button>
						</form>
					</div>
				</div>
				<%
				}
				%>
			</div>
			<div class="rps">
				<p style="margin: 10px;">
				<span>하트 걸고 가위바위보?!</span><br>
				<span style="font-size:0.7em;">가위 바위 보 글자를 클릭하면 바로 도전!</span><br>
				<span style="font-size:0.7em;">이기면 +2, 지면 -1, 비기면 0!</span>
				</p>
				<%
				if (member == null) {
				%>
				<div style="padding: 10px; color: grey;">로그인이 필요합니다.</div>
				<%
				} else {
				RpsDAO rps = new RpsDAO();
				int count = rps.getCountToday(member.getId());
				int chance = 3 - count;
				%>
				<div id="rps" style="padding: 10px;">
					<span>오늘 남은 횟수: <%=chance%>회
					</span> <br>
					<%
					if (chance > 0) {
					%>
					<span> &#187; <a href="ServletRps?input=s">가위!!</a> <a href="ServletRps?input=r">바위!!!</a> <a href="ServletRps?input=p">보!!!!</a> &#171;
					</span>
					<%
					} else {
					%>
					<span>&#187; 오늘 기회를 모두 사용했습니다. &#171;</span>
					<%
					}
					%>
				</div>
				<%
				}
				%>
			</div>
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
							href="read.jsp?page=1&postNum=<%=p.getpNum()%>"><%=title%> </a>
						<%
						if (p.getReply() > 0) {
						%>
						(<%=p.getReply()%>)
						<%
						}
						%>
						&nbsp;&nbsp; (❤
						<%=p.getHeart()%>)
						<hr>
					</div>
					<%
					}
					%>
				</div>
			</div>
			<div class="game">
				<p style="margin: 10px;">
					RPG <a href="index_rpg.jsp" style="font-size: 0.8em;">바로가기</a>
				</p>
				<img src="img/rpg.png" style="width: 320px; margin-left: 10px;">
			</div>
			<div class="lotto">로또</div>
		</div>
	</div>
</body>
</html>