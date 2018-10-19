<%@page import="com.hanul.notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	NoticeDAO nDao = new NoticeDAO();
	int result = nDao.delete(no);
	String m = "삭제 실패";
	if(result>0){
		m="삭제 성공";
	}
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	var m = '<%=m%>';
	alert(m);
	location.href = "./noticeList.jsp"
</script>
</head>
<body>

</body>
</html>