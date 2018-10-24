<%@page import="com.hanul.member.MemberDAO"%>
<%@page import="com.hanul.member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDTO sdto = new MemberDTO();
	sdto.setId(request.getParameter("id"));
	sdto.setPw(request.getParameter("pw"));
	sdto.setName(request.getParameter("name"));
	sdto.setEmail(request.getParameter("email"));
	MemberDAO sdao = new MemberDAO();
	int result = sdao.update(sdto);
	if(result>0){
		MemberDTO k = (MemberDTO)session.getAttribute("");
		k.setName(sdto.getName());
		k.setEmail(sdto.getEmail());
		response.sendRedirect("./memberList.jsp");
	} else {
		String s = "Update Fail";
		String path = "./memberList.jsp";
		request.setAttribute("message", s);
		request.setAttribute("path", path);
		RequestDispatcher view = request.getRequestDispatcher("../common/result.jsp");
		view.forward(request, response);
	}
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