<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="data.db"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>添加图书</title>
  </head>
  <body background="image/4.jpg">
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
  	 <div style="margin:-25px 0px 40px;font-size:small;">
	    		欢迎：<%=loginUsername+"&emsp;("+loginMark %>)&emsp;
	    		<a href="Logout.jsp">注销登录</a>
	    		<a href="changeUser.jsp?userId=<%=loginUserId%>">个人设定</a>&emsp;&emsp;
	    		<a href="main.jsp?userId=<%=loginUserId%>">用户功能</a>
	    		</div>
  	 <%
  	 	String sql="";
  	 	ResultSet rs=null;
  	 		String needId=request.getParameter("needId");
  	 		sql="select * from needBook where needId='"+needId+"'";
  	 		rs=db.select(sql);
  	 		if(rs==null){
  	 			msg="数据库操作发生错误！"+back;
    			out.print(msg);
    			return;
  	 		}
  	 		while(rs.next()){
  	 		String bookname=rs.getString("bookname");
  	 		String author=rs.getString("author");
  	 		double price=20+Math.random()*200%181;
  	 		sql="select * from buyBook where bookname='"+bookname+"' and author='"+author+"'";
  	 		ResultSet find=db.select(sql);
  	 		if(find==null){
  	 			msg="数据库操作发生错误！"+back;
    			out.print(msg);
    			return;
  	 		}
  	 		if(find.next()==true){
  	 			msg="已有该书"+back;
  	 			out.print(msg);
  	 			return;
  	 		}
  	 		sql="insert into buyBook(bookname,bookprice,author) values('"+bookname+"','"+price+"','"+author+"')";
  	 		String s=db.insert(sql);
  	 		if(s==null){
  	 			msg="数据库操作发生错误！"+back;
    			out.print(msg);
    			return;
  	 		}
  	 		sql="update needBook set sign='true' where needId='"+needId+"'";
  	 		int d=db.delete(sql);
  	 		if(d==0){
  	 			msg="数据库操作发生错误！"+back;
    			out.print(msg);
    			return;
  	 		}
  	 		msg="添加成功";
  	 		out.print(msg);
  	 		return;
  	 		}
  	 		%>
  	 		<form action="addBookDo.jsp" method="post">
  	 		<table>
  	 		<tr>
  	 		<td>图书名称</td><td>图书价格</td><td>作者</td>
  	 		</tr>
  	 		<tr>
  	 		<td><input type="text" name="bookname"></td>
  	 		<td><input type="text" name="bookprice"></td>
  	 		<td><input type="text" name="author"></td>
  	 		</tr>
  	 		</table>
  	 		<input type="submit" name="submit" value="提交">
  	 		</form>
  	 		<%
 			
  	 		 %>
  	 
  	 </span>
  	 </div>
  </body>
</html>
