<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="data.db"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>修改用户</title>
  </head>
  
  <body background="image/4.jpg">
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
  	 	<div style="margin:-25px 0px 40px;font-size:small;">
	    		欢迎：<%=loginUsername+"&emsp;("+loginMark %>)&emsp;
	    		<a href="Logout.jsp">注销登录</a>
	    		<a href="main.jsp?userId=<%=loginUserId%>">用户功能</a>
	   	</div>
	  </span>
	  <%
	  	String userId=request.getParameter("userId");
	  	String sql="";
	  	ResultSet rs=null;
	  	sql="select * from lib_user where userId='"+userId+"'";
	  	rs=db.select(sql);
	  	if(rs==null){
  	 			msg="数据库操作发生错误！"+back;
    			out.print(msg);
    			return;
  	 	}
	   %>
	   <form action="changeUserDo.jsp?userId=<%=userId %>" method="post">
	   <table border="solid"> 
	   	<%
	   		while(rs.next()){
	   		String username=rs.getString("username");
	   		String password=rs.getString("password");
	   		String realName=rs.getString("realName");
	   		String mark=rs.getString("mark");
	   		String timeRenew=String.format("%tF%<tT",rs.getTimestamp("timeRenew"));
	   		String checkedguest="",checkeduser="",checkedadmin="";
    		if(mark.equals("user"))
    			checkeduser="checked='checked'";
    		else if(mark.equals("admin"))
    			checkedadmin="checked='checked'";
	   	 %>
	   	 <tr>
	   	 	<td>userId</td><td><%=userId %></td>
	   	 </tr>
	   	 <tr>
	   	 	<td>用户名</td><td><%=username %></td>
	   	 </tr>
	   	 <%if(loginMark.equals("user")){ %>
	   	 <tr>
	   	 	<td>原密码</td><td><input type="password" name="password1"></td>
	   	 </tr>
	   	 <%} %>
	   	 <tr>
	   	 	<td>密码</td><td><input type="password" name="password"></td>
	   	 </tr>
	   	 <tr>
	   	 	<td>真实姓名</td><td><input type="text" name="realName" value=<%=realName %>></td>
	   	 </tr>
	   	 <%if(loginMark.equals("admin")){ %>
	   	 <tr>
	   	 	<td>mark</td><td><input type="radio" name="mark" value="user"<%=checkeduser %>>user&emsp;
	   	 	<input type="radio" name="mark" value="admin"<%=checkedadmin %>>admin</td>
	   	 </tr>
	   	 <%} %>
	   	 <tr>
	   	 	<td>更新时间</td><td><%=timeRenew %></td>
	   	 </tr>
	   <% 
	   } %>
	   
	   </table>
	   <input type="submit" name="submit" value="提交">
	   </form>
	 </div>
  </body>
</html>
