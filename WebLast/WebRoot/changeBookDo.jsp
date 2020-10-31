<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="data.db"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>修改结果</title>
  </head>
  
  <body background="image/3.jpg">
    <div style="width:810px;margin:10px auto;line-height:40px;">
    	<h3>修改结果</h3>
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
	  String bookprice=request.getParameter("bookprice");
	  double price=Double.parseDouble(bookprice);
	  String bookId=request.getParameter("bookId");
	  String sql="";
	  sql="update buyBook set bookprice='"+price+"' where bookId='"+bookId+"'";
	  int rs=db.update(sql);
	  if(rs==0){
  	 			msg="数据库操作发生错误！"+back;
    			out.print(msg);
    			return;
  	 	}
	  %>
	  修改成功<p>
	 <a href="bookInfo.jsp">图书列表</a>
	  </div>
  </body>
</html>
