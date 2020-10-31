<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="data.db"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>修改图书</title>
  </head>
  
  <body background="image/1.jpg">
    <div style="width:810px;margin:10px auto;line-height:40px;">
    	<h3>修改图书</h3>
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
	    		<a href="Edit.jsp?userId=<%=loginUserId%>">个人设定</a>&emsp;&emsp;
	    		<a href="main.jsp?userId=<%=loginUserId%>">用户功能</a>
	   	</div>
	  </span>
	  <%
	  	String bookId=request.getParameter("bookId");
	  	String sql="";
	  	ResultSet rs=null;
	  	sql="select * from buyBook where bookId='"+bookId+"'";
	  	rs=db.select(sql);
	  	if(rs==null){
  	 			msg="数据库操作发生错误！"+back;
    			out.print(msg);
    			return;
  	 	}
	   %>
	   <form action="changeBookDo.jsp?bookId=<%=bookId %>" method="post">
	   <table border="solid"> 
	   	<%
	   		while(rs.next()){
	   		String bookname=rs.getString("bookname");
	   		String bookprice=rs.getString("bookprice");
	   		String author=rs.getString("author");
	   	 %>
	   	 <tr>
	   	 	<td>图书名称</td><td><%=bookname %></td>
	   	 </tr>
	   	 <tr>
	   	 	<td>作者</td><td><%=author %></td>
	   	 </tr>
	   	 <tr>
	   	 	<td>图书价格</td><td><input type="text" name="bookprice" value=<%=bookprice %> style="color:red"></td>
	   	 </tr>
	   <%} %>
	   </table>
	   <input type="submit" name="submit" value="提交">
	   </form>
	 </div>
  </body>
</html>
