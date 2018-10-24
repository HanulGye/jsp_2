<%@page import="com.hanul.member.MemberDAO"%>
<%@page import="com.hanul.member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDTO mDto = new MemberDTO();
	mDto.setId(request.getParameter("id"));
	mDto.setPw(request.getParameter("pw"));
	String remember = request.getParameter("remember");
	
	//cookie에 id 기억할건지 아닌지에 따른 처리
	if(remember != null){
		Cookie c = new Cookie("remember", mDto.getId());	//이름(String)과 값(String)
		c.setMaxAge(60*60*24*365);
		response.addCookie(c);
	}else {
		Cookie c = new Cookie("remember","");
		c.setMaxAge(0);
		response.addCookie(c);
	}
	
	MemberDAO sdao = new MemberDAO();
	mDto = sdao.selectOne(mDto);
	
	String result = "Login Fail";
	String path = "./memberLogin.jsp";
	if(mDto != null){
		result = "Login Success";
		path = "./memberList.jsp";
		session.setAttribute("member", mDto);
		session.setMaxInactiveInterval(60*10);
	}
	request.setAttribute("message", result);
	request.setAttribute("path", path);
	RequestDispatcher view = request.getRequestDispatcher("../common/result.jsp");
	view.forward(request, response);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>