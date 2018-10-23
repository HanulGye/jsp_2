<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String message = request.getAttribute("message").toString();
	String path = (String)request.getAttribute("path");
%>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	alert('<%=message%>');
	location.href="<%=path%>";
</script>
</head>
<body>

</body>
</html>