<%@page import="com.hanul.member.MemberDTO"%>
<%@page import="com.hanul.notice.NoticeDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hanul.notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	NoticeDAO noticeDAO = new NoticeDAO();
	
	
	int curPage=1;
	String kind=request.getParameter("kind");
	String search=request.getParameter("search");
	System.out.println("kind:"+kind);
	System.out.println("search:"+search);
	
	if(kind==null){
		kind="Subject";
	}
	
	if(search==null){
		search="";
	}
	
	try{
		curPage= Integer.parseInt(request.getParameter("curPage"));
		
	}catch(Exception e){
		
	}
	int perPage=10;
	int startRow=(curPage-1)*perPage+1;
	int lastRow=curPage*perPage;
	ArrayList<NoticeDTO> ar = noticeDAO.selectList(startRow, lastRow, kind, search);
			
	
	//페이징 
	//1. 전체 글의 갯수
	int totalCount = noticeDAO.getCount(kind, search);
	//2. 전체 페이지의 갯수
	int totalPage=totalCount/perPage;
	if(totalCount%10 != 0){
		totalPage=totalCount/perPage+1;
	}
	//3. 전체 블럭의 갯수
	int perBlock=5;//블럭당 숫자의 갯수
	int totalBlock = totalPage/perBlock;
	if(totalPage%perBlock !=0){
		//totalBlock = totalPage/perBlock+1;
		totalBlock = totalBlock+1;
	}
	//4. curPage의 번호로 curBlock 구하기
	int curBlock = curPage/perBlock;
	if(curPage%perBlock != 0){
		curBlock = curPage/perBlock+1;
	}
	
	//5. curBlock 번호로 startNum, lastNum 구하기
	int startNum=(curBlock-1)*perBlock+1;
	int lastNum=curBlock*perBlock;
	
	if(curBlock == totalBlock){
		lastNum = totalPage;
	}
	
	
%>    
<!DOCTYPE html>
<html>
<head>
  <!-- Theme Made By www.w3schools.com - No Copyright -->
  <title>Bootstrap Theme Company Page</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <jsp:include page="../temp/style.jsp"></jsp:include>
   
  <style>
  
  .row table, tr, td{
  	width: 60%;
  	margin: auto;
  	
  }
  
  #searchBar{
  	margin-left: 20%;
  }
  
  #wrtieB{
  	float: right;
  	margin-right: 20%;
  }
  
  </style>
</head>
<body id="myPage" data-spy="scroll" data-target=".navbar" data-offset="60">

<jsp:include page="../temp/header.jsp"></jsp:include>

<div class="container-fluid">
	<div class="row">
	
		<table class="table table-hover">
			<tr>
				<th colspan=5 style="text-align: center">공지사항</th>
			</tr>
			<tr>
				<th>No.</th>
				<th>Subject</th>
				<th>Writer</th>
				<th>Date</th>
				<th>Hit</th>
			</tr>
			  
			<%for(NoticeDTO noticeDTO : ar){ %>
			<tr>
				<td><%= noticeDTO.getNo()%></td>
				<td><a href="./noticeSelectOne.jsp?no=<%= noticeDTO.getNo()%>&hit=<%= noticeDTO.getHit()%>"><%= noticeDTO.getSubject()%></a></td>
				<td><%= noticeDTO.getWriter()%></td>
				<td><%= noticeDTO.getReg_date()%></td>
				<td><%= noticeDTO.getHit()%></td>
				
			</tr>
			<%} %>
			
		</table>
	</div>
		<div id="searchBar">
			<form class="form-inline" action="./noticeList.jsp">
			    <div class="form-group">
			    	<select class="form-control" id="sel1" name="kind">
				        <option>Subject</option>
				        <option>Contents</option>
				        <option>Writer</option>
			     	</select>	
						    
			      <input type="text" class="form-control" id="search" placeholder="Enter search" name="search">
			    </div>
			    
			    <button type="submit" class="btn btn-default">Search</button>
			  </form>
			
		</div>
		<%MemberDTO mDto = (MemberDTO)session.getAttribute("member"); %>
		
		<%	
			if(mDto!=null && mDto.getKind().equals("T")){%>
			<a href="./noticeWriteForm.jsp" class="btn btn-warning" role="button" id="wrtieB">Write</a>
		<%} else{ %>
		<%} %>
</div>


<div class="container-fluid">
	<div class="row">
		    
	  <ul class="pagination">
	  	<li><a href="./noticeList.jsp?curPage=<%= 1%>&kind=<%=kind%>&search=<%=search%>"><span class="glyphicon glyphicon-backward"></span></a></li>
	  	
	  	<%if (curBlock>1){ %>
	  	<li><a href="./noticeList.jsp?curPage=<%= startNum-1%>&kind=<%=kind%>&search=<%=search%>"><span class="glyphicon glyphicon-chevron-left"></span></a></li>
	  	<%} %>
	   	<% for(int i=startNum;i<=lastNum;i++){ %>
	   		<li><a href="./noticeList.jsp?curPage=<%=i%>&kind=<%=kind%>&search=<%=search%>"><%=i%></a></li>
	   	<%} %>
	   	
	   	<% if(curBlock < totalBlock){ %>
	   	<li><a href="./noticeList.jsp?curPage=<%=lastNum+1%>&kind=<%=kind%>&search=<%=search%>"><span class="glyphicon glyphicon-chevron-right"></span></a></li>
	   	<%} %>	
	   	<li><a href="./noticeList.jsp?curPage=<%=totalPage%>&kind=<%=kind%>&search=<%=search%>"><span class="glyphicon glyphicon-forward"></span></a></li>
	  </ul>
	  
  	</div>
</div>

<jsp:include page="../temp/footer.jsp"></jsp:include>

</body>
</html>
