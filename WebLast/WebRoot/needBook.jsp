<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="data.db"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  	<title>缺书登记</title>
  </head>
  
  <body background="image/4.jpg">
      <div style="width:810px;margin:10px auto;line-height:40px;">
  	<h3>缺书登记</h3>
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
  	 <form action="needBookDo.jsp" method="post">
  	  	<div style="margin:-25px 0px 40px;font-size:small;">
	    		欢迎：<%=loginUsername+"&emsp;("+loginMark %>)&emsp;
	    		<a href="Logout.jsp">注销登录</a>
	    		<a href="changeUser.jsp?userId=<%=loginUserId%>">个人设定</a>&emsp;&emsp;
	    		<a href="main.jsp?userId=<%=loginUserId%>">用户功能</a>
	    </div>
	    <table border="solid">
	    	<tr>
	    		<td>图书名称</td><td>作者</td>
	    	</tr>
    	<tr>
    		<td><label><input type="text" name="bookname"></label></td>
    		<td><label><input type="text" name="author"></label></td>
    	</tr>
	    </table>
	    <input type="submit" name="submit" value="登记">
  	  </form>
  	</div>
  </body>
</html>
