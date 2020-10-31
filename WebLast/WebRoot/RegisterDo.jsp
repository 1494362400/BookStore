<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="data.db"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>注册结果</title>
  </head>
  
  <body background="image/3.jpg">
    <div style="width:810px;margin:10px auto;line-height:40px;">
  	<h3>注册结果</h3>
  	<%
  		request.setCharacterEncoding("utf-8");
   		String msg="";
   		String back="&emsp;<a href='javascript:window.history.back();'>后退</a>";
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		String password2=request.getParameter("password2");
		String realName=request.getParameter("realName");
		username=username.trim();
		password=password.trim();
		password2=password2.trim();
		realName=realName.trim();
		
		if(username==null){
			msg="请输入用户名"+back;
			out.print(msg);
			return;
		}
		if(password==null){
			msg="请输入密码"+back;
			out.print(msg);
			return;
		}
		if(password2==null){
			msg="请输入确认密码"+back;
			out.print(msg);
			return;
		}
		if(!password.equals(password2)){
			msg="两次密码输入不一致"+back;
			out.print(msg);
			return;
		}
		
		String sql="";
		ResultSet rs=null;
		sql="select * from lib_user where username='"+username+"'";
		rs=db.select(sql);
		if(rs==null){
			msg="数据库操作发生错误"+back;
			out.print(msg);
			return;
		}
		if(rs.next()==true){
			msg="用户名已存在"+back;
			out.print(msg);
			return;
		}
		try{
			String loginMark=session.getAttribute("loginMark").toString();
			if(loginMark.equals("admin")){
				String mark=request.getParameter("mark");
				sql="insert into lib_user(username,password,realName,mark) values('"+username+"','"+password+"','"+realName+"','"+mark+"')";
				
			}
		}catch(Exception e){
			sql="insert into lib_user(username,password,realName,mark) values('"+username+"','"+password+"','"+realName+"','user')";
		}
		String user=db.insert(sql);
		if(user==null){
			msg="数据库操作发生错误"+back;
			out.print(msg);
			return;
		}
  	 %>
  	 用户注册成功
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
  	 </div>
  </body>
</html>
