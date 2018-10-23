<%@page import="com.hanul.member.MemberDTO"%>
<%@page import="com.hanul.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDTO memberDTO = new MemberDTO();
	memberDTO.setId(request.getParameter("id"));
	memberDTO.setPw(request.getParameter("pw"));
	memberDTO.setName(request.getParameter("name"));
	memberDTO.setEmail(request.getParameter("email"));
	memberDTO.setKind(request.getParameter("kind"));
	memberDTO.setClassMate(request.getParameter("classMate"));

	MemberDAO memberDAO = new MemberDAO();
	int result = memberDAO.insert(memberDTO);
	
	String m = "등록 실패";
	
	if(result>0){
		m = "등록 성공";
	}
	
	request.setAttribute("message", m);
	request.setAttribute("path", "../index.jsp");
	
	//이동해야할 페이지 주소
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