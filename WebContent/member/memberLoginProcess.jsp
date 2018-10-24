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
	
	//client가 입력한 id와 pw에 해당하는 member가 존재하는지, 있다면 그 member 데이터를 운반할 통을 준비.
	MemberDAO sdao = new MemberDAO();
	mDto = sdao.selectOne(mDto);
	
	//로그인 활동 후, 띄워줄 메시지와 이동할 경로 미리 설정. 
	String result = "Login Fail";
	String path = "./memberLogin.jsp";
	
	//member 데이터를 저장할 세션을 마련.
	if(mDto != null){
		result = "Login Success";
		path = "./memberList.jsp";
		session.setAttribute("member", mDto);
		session.setMaxInactiveInterval(60*10);
	}
	
	//로그인 여부를 alert으로 띄워주는 것 
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