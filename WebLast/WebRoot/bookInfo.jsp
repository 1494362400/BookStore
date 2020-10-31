<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="data.db"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>图书列表</title>
  </head>
  
  <body background="image/4.jpg">
    <div style="width:810px;margin:10px auto;line-height:40px;">
    	<h3>图书列表</h3>
    	<span class="msg">
  	<%
  		request.setCharacterEncoding("utf-8");
   		String msg="";
   		String back="&emsp;<a href='javascript:window.history.back();'>后退</a>";
   		
   		if(session.getAttribute("loginUsername")==null){
   			msg="<br>您的登录已失效！请重新登录。";
   			msg+="&emsp;<a href='Login.jsp'>登录</a>";
   			out.print(msg);
   			return;
   		}
   		String loginUserId=session.getAttribute("loginUserId").toString();
   		String loginUsername=session.getAttribute("loginUsername").toString();
   		String loginMark=session.getAttribute("loginMark").toString();
   		
  	 %>
  	 	<div style="margin:-25px 0px 40px;font-size:small;">
	    		欢迎：<%=loginUsername+"&emsp;("+loginMark %>)&emsp;
	    		<a href="Logout.jsp">注销登录</a>
	    		<a href="changeUser.jsp?userId=<%=loginUserId%>">个人设定</a>&emsp;&emsp;
	    		<a href="main.jsp?userId=<%=loginUserId%>">用户功能</a>
	   	</div>
	  </span>
	  <%
	  	String sql="";
	  	ResultSet rs=null;
	  	sql="select * from buyBook";
	  	rs=db.select(sql);
	  	if(rs==null){
  	 			msg="数据库操作发生错误！"+back;
    			out.print(msg);
    			return;
  	 	}
	   %>
	   <table border="solid">
	   	<tr>
	   		<td>图书名称</td><td>图书价格</td><td>作者</td><td>操作</td>
	   	</tr>
	   	<%
	   		while(rs.next()){
	   		String bookname=rs.getString("bookname");
	   		String bookprice=rs.getString("bookprice");
	   		String author=rs.getString("author");
	   		String bookId=rs.getString("bookId");
	   	 %>
	   	 <tr>
	   	 	<td><%=bookname %></td><td><%=bookprice %></td><td><%=author %></td>
	   	 	<td><a href="changeBook.jsp?bookId=<%=bookId %>">修改</a>&emsp;<a href="deleteBook.jsp?bookId=<%=bookId %>" onclick="return confirm('确定要删除吗？');">删除</a></td>
	   	 </tr>
	   <%} %>
	   </table>
	 </div>
  </body>
</html>
