<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="data.db"%>
<%@page import="java.sql.ResultSet"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>查看缺书</title>
  </head>
  
  <body background="image/4.jpg">
  	<div style="width:810px;margin:10px auto;line-height:40px;">
    	<h3>查看缺书</h3>
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
    	sql="select * from needBook where sign='false'";
    	rs=db.select(sql);
    	if(rs==null){
    			msg="数据库操作发生错误！"+back;
    			out.print(msg);
    			return;
    	}
    	if(rs.isBeforeFirst()==rs.isAfterLast()){
    		msg="暂无缺书"+back;
    		out.print(msg);
    		return;
    	}

  	  %>
  	  <form action="lookNeedDo.jsp" method="post">
  	  <table border="solid">
  	  <tr>
  	  <td>userId</td><td>username</td><td>图书名称</td><td>作者</td>
  	  </tr>
  	  <%
  	  while(rs.next()){
  	  String userId=rs.getString("userId");
  	  String username=rs.getString("username");
  	  String bookname=rs.getString("bookname");
  	  String author=rs.getString("author");
  	  String needId=rs.getString("needId");
  	  String sign=rs.getString("sign");
  	  %>
  	  	<tr>
  	  		<td><%=userId%></td><td><%=username %></td><td><%=bookname %></td><td><%=author %></td><td>操作</td>
  	  		<td><a href="addBook.jsp?needId=<%=needId %>">添加</a>&emsp;<a href="cancleBook.jsp?needId=<%=needId %>" onclick="return confirm('确定要取消吗？');">取消</a></td>
  	  	</tr>
  	  <%
  	  }
  	   %>
  	  </table>
  	  
  	  </form>
    </span>
    </div>
  </body>
</html>
