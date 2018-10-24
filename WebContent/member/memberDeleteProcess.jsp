<%@page import="com.hanul.member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	MemberDAO mDao = new MemberDAO();
	int result = mDao.delete(id, pw);
	String s = "Delete Fail";
	String path = "./memberList.jsp";
	if(result>0){
		s = "Delete Success";
		session.invalidate();	
		
	}
	request.setAttribute("message", s);
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