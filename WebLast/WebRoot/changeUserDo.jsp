<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="data.db"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

  </head>
  
  <body background="image/3.jpg">
    <div style="width:810px;margin:10px auto;line-height:40px;">
    	<h3>修改用户</h3>
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
	  String userId=request.getParameter("userId");
	  String password=request.getParameter("password");
	  password=password.trim();
	  String realName=request.getParameter("realName");
	  realName=realName.trim();
	  if(loginMark.equals("user")){
	  	String password1=request.getParameter("password1");
	  	password1=password1.trim();
	  	if(!password1.equals("")){
	  		if(password.equals("")){
	  			msg="请确认密码"+back;
	  			out.print(msg);
	  			return;
	  		}
	  		else if(!password1.equals(password)){
	  			msg="两次密码输入不一致"+back;
	  			out.print(msg);
	  			return;
	  		}
	  		else if(realName.equals("")){
	  			sql="update lib_user set password='"+password1+"' where userId='"+loginUserId+"'";
	  			msg="修改密码成功"+back;
	  		}
	  		else if(!realName.equals("")){
	  			sql="update lib_user set password='"+password1+"',realName='"+realName+"' where userId='"+loginUserId+"'";
	  			msg="修改密码和真实姓名成功"+back;
	  		}
	  	}
	  	if(!password.equals("")){
	  		if(password1.equals("")){
	  			msg="请输入原密码"+back;
	  			out.print(msg);
	  			return;
	  		}
	  	}
	  	if(!realName.equals("")||realName.equals("")){
	  		if(password1.equals("") && password.equals("")){
	  			sql="update lib_user set realName='"+realName+"' where userId='"+loginUserId+"'";
	  			msg="修改真实姓名成功"+back;
	  		}
	  	}
	  	int d=db.update(sql);
	  	if(d==0){
	  			msg="数据库操作发生错误！"+back;
    			out.print(msg);
    			return;
	  	}
	  }
	  
	  if(loginMark.equals("admin")){
	  	String mark=request.getParameter("mark");
	  	if(password.equals("")){
	  		sql="update lib_user set realName='"+realName+"',mark='"+mark+"' where userId='"+userId+"'";
	  		msg="修改真实姓名和身份成功"+back;
	  	}
	  	else if(!password.equals("")){
	  		sql="update lib_user set password='"+password+"',mark='"+mark+"',realName='"+realName+"' where userId='"+userId+"'";
	  		msg="修改密码，真实姓名和身份成功"+back;
	  	}
	  	int d=db.update(sql);
	  	if(d==0){
	  			msg="数据库操作发生错误！"+back;
    			out.print(msg);
    			return;
	  	}
	  }
	   %>
	 </div>
	 <%=msg %>&emsp;
	 <% if(loginMark.equals("admin")){ %>
	 <a href="userlist.jsp">用户列表</a>
	 <%} %>
  </body>
</html>
