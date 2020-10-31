<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="data.db"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>用户注册</title>
  </head>
  
  <body background="image/4.jpg">
    <div style="width:810px;margin:10px auto;line-height:40px;">
  	<h3>用户注册</h3>
  	<%
  		request.setCharacterEncoding("utf-8");
   		String msg="";
   		String back="&emsp;<a href='javascript:window.history.back();'>后退</a>";


  	 %>
  	 <form action="RegisterDo.jsp" method="post">
  	 	用户名&emsp;：<input type="text" name="username"><p>
  	 	密码&emsp;&emsp;：<input type="password" name="password"><p>
  	 	确认密码：<input type="password" name="password2"><p>
  	 	真实姓名：<input type="text" name="realName"><p>
  	 	<%
  	 	try{
  	 	   	String loginUserId=session.getAttribute("loginUserId").toString();
   			String loginUsername=session.getAttribute("loginUsername").toString();
   			String loginMark=session.getAttribute("loginMark").toString();
  	 		if(loginMark.equals("admin")){%>
  	 			<input type="radio" name="mark" value="admin" checked="checked">admin
  	 			<input type="radio" name="mark" value="user">user<p>
  	 		<%}
  	 		}catch(Exception e){
  	 		
  	 		}
  	 	 %>
  	 	 <input type="submit" name="submit" value="注册">
  	 	 <%
  	 	try{
  	 	   	String loginUserId=session.getAttribute("loginUserId").toString();
  	 		if(loginUserId!=null){%>
  	 			<a href="Login.jsp">用户登录</a>
  	 			<a href="main.jsp">用户功能</a>
  	 		<%}
  	 		}catch(Exception e){%>
  	 			<a href="Login.jsp">用户登录</a>
  	 		<%}
  	 	 %>
  	 </form>
  	 </div>
  </body>
</html>
