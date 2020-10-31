<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="data.db"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>添加结果</title>
  </head>
  
  <body background="image/3.jpg">
    <div style="width:810px;margin:10px auto;line-height:40px;">
    	<h3>添加图书</h3>
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
  	 	String bookname=request.getParameter("bookname");
  	 	String bookprice=request.getParameter("bookprice");
  	 	String author=request.getParameter("author");
  	 	bookname=bookname.trim();
  	 	bookprice=bookprice.trim();
  	 	author=author.trim();
  	 	if(bookname.equals("")){
  	 		msg="请输入图书名称"+back;
  	 		out.print(msg);
  	 		return;
  	 	}
  	 	if(bookprice.equals("")){
  	 		msg="请输入图书价格"+back;
  	 		out.print(msg);
  	 		return;
  	 	}
  	 	if(author.equals("")){
  	 		msg="请输入作者"+back;
  	 		out.print(msg);
  	 		return;
  	 	}
  	 	
  	 	String sql="";
  	 	ResultSet rs=null;
  	 	sql="select * from buyBook where bookname='"+bookname+"' and author='"+author+"'";
  	 	rs=db.select(sql);
 		if(rs==null){
 			msg="数据库操作发生错误！"+back;
 			out.print(msg);
 			return;
 		}
 		if(rs.next()==true){
 			msg="已有该书"+back;
 			out.print(msg);
 			return;
 		}
 		double price=Double.parseDouble(bookprice);
 		sql="insert into buyBook(bookname,bookprice,author) values('"+bookname+"','"+price+"','"+author+"')";
 		String s=db.insert(sql);
 		if(s==null){
 			msg="数据库操作发生错误！"+back;
 			out.print(msg);
 			return;
 		}
 	
  	  %>
  	 </div>
  	 添加成功<p>
  	 <a href="addBook.jsp">返回添加</a>
  </body>
</html>
