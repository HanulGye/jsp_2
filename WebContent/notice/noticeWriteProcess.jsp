<%@page import="com.hanul.notice.NoticeDAO"%>
<%@page import="com.hanul.notice.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	NoticeDTO nDto = new NoticeDTO();
	nDto.setSubject(request.getParameter("subject"));
	nDto.setContent(request.getParameter("content"));
	nDto.setWriter(request.getParameter("writer"));
	
	NoticeDAO nDao = new NoticeDAO();
	int result = nDao.insert(nDto);
	
	String s = "글 작성 실패...";
	
	if(result>0){
		s = "글 작성 성공!";
		
	}
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	var r = '<%=s%>';
	alert(r);
	location.href='./noticeList.jsp';
</script>
</head>
<body>

</body>
</html>