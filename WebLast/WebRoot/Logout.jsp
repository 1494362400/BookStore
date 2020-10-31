<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>注销登录</title>
	<link rel="stylesheet" href="css/css.css">
  </head>
  
  <body background="image/1.jpg">
    <div style="width:600px;margin:10px auto;line-height:40px;">
    	<h3>注销登录</h3>
    	<span class="msg">
    		<%
    			session.invalidate();
    		 %>
    		 注销登录成功！&emsp;
    		<a href="Login.jsp">返回登录</a>
    	</span>
    </div>
  </body>
</html>
