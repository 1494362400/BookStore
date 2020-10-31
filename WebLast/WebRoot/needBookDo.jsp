<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="data.db"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>登记结果</title>
  </head>
  <body background="image/3.jpg">
  	<div style="width:810px;margin:10px auto;line-height:40px;">
    	<h3>登记结果</h3>
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
     </span>
     <%
     	String sql="";
    	ResultSet rs=null;
    	String bookname=request.getParameter("bookname");
    	String author=request.getParameter("author");
    	sql="select * from buyBook where bookname='"+bookname+"' and author='"+author+"'";
    	rs=db.select(sql);
    	if(rs==null){
    			msg="数据库操作发生错误！"+back;
    			out.print(msg);
    			return;
    	}
    	if(rs.next()==true){
    		msg="已有该书，无需登记"+back;
    		out.print(msg);
    		return;
    	}
    	sql="select * from needBook where userId='"+loginUserId+"' and bookname='"+bookname+"' and author='"+author+"'";
    	ResultSet rs2=null;
    	rs2=db.select(sql);
    	if(rs2==null){
    			msg="数据库操作发生错误！"+back;
    			out.print(msg);
    			return;
    	}
    	if(rs2.next()==true){
    		msg="您已登记该书，无需重复登记"+back;
    		out.print(msg);
    		return;
    	}
    	sql="insert into needBook(userId,username,bookname,author,sign) values('"+loginUserId+"','"+loginUsername+"','"+bookname+"','"+author+"','false"+"')";
    	String need=db.insert(sql);
    	if(need==null){
    			msg="数据库操作发生错误！"+back;
    			out.print(msg);
    			return;
    	}
    	
	%>
	<table border="solid">
	<tr>
		<td>图书名称</td><td>作者</td><td>登记结果</td>
	</tr>
	<tr>
		<td><%=bookname %></td><td><%=author %></td><td style="color:red">登记成功</td>
	</tr>
	</table>
     <a href="needBook.jsp">返回登记</a>
     </div>
  </body>
</html>
