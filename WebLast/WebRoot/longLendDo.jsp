<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="data.db"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>续借结果</title>
  </head>
  <body background="image/3.jpg">
  	<div style="width:810px;margin:10px auto;line-height:40px;">
    	<h3>续借结果</h3>
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
      <table border="solid">
  		<tr><td>图书名称</td><td>作者</td><td>续借人</td><td>续借结果</td></tr>
     <%
     	String sql="";
    	ResultSet rs=null;
    	String selectId=request.getParameter("lendId");	
    	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
    	sql="select * from lendBook where userId='"+loginUserId+"' and sign='false'";
    	rs=db.select(sql);
    	if(rs==null){
    			msg="数据库操作发生错误！"+back;
    			out.print(msg);
    			return;
    	}
    	if(selectId!=null){
    			while(rs.next()){
    				String lendId=rs.getString("lendId");
    				String bookname=rs.getString("bookname");
    				String author=rs.getString("author");
    					if(selectId.equals(lendId)){					  	     
       %>
  		<tr align="center">
     		<td><%=bookname %></td>
     		<td><%=author %></td>
     		<td><%=loginUsername %></td>
     		<td style="color:red">续借成功</td>
     	</tr>
      <%
    			}

    		
    	}
    	rs.close();
    	sql="Update lendBook set timeRenew=now() where lendId='"+selectId+"'";
    					int longLend=db.update(sql);
    					if(longLend==0){
					  		msg="数据库操作发生错误！"+back;
					  		out.print(msg);
					  		return;
					  	}
    	}
      %>

     </table>
     <a href="main.jsp">用户功能</a>
     </div>
  </body>
</html>
