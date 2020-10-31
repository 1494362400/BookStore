<%@page import="data.db"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>购买记录</title>
	<link rel="stylesheet" href="css/css.css">
  </head>
  
  <body background="image/4.jpg">
    <div style="width:810px;margin:10px auto;line-height:40px;">
    	<h3>购买记录</h3>
    	<span class="msg">
    	<%
    		request.setCharacterEncoding("utf-8");
    		String msg="";
    		String back="&emsp;<a href='javascript:window.history.back();'>后退</a>";
    		
    		if(session.getAttribute("loginUsername")==null){
    			msg="<br>您的登录已失效！请重新登录。";
    			msg+="&emsp;<a href='index.jsp'>登录</a>";
    			out.print(msg);
    			return;
    		}
    		String loginUserId=session.getAttribute("loginUserId").toString();
    		String loginUsername=session.getAttribute("loginUsername").toString();
    		String loginMark=session.getAttribute("loginMark").toString();
    		String linkAdmin="";
    		
    		if(loginMark.equals("admin")==false&&loginMark.equals("user")==false){
    			msg="您的权限不足！";
    			msg+="&emsp;<a href='main.jsp'>用户功能</a>";
    			out.print(msg);
    			return;
    		}
    		String field="userId";
    		String content="";
    		String buttonQuery=request.getParameter("buttonQuery");
    		
    		if(buttonQuery!=null){
    			field=request.getParameter("field");
    			content=request.getParameter("content").trim();
    		}
    		
    		String seletedUserId="",seletedBookName="",seletedAuthor="";
    		
    		if(field.equals("userId"))
    			seletedUserId="selected='selected'";
    		else if(field.equals("bookname"))
    			seletedBookName="selected='selected'";
    		else if(field.equals("author"))
    			seletedAuthor="selected='selected'";
    		String sql="";
    		ResultSet rs=null;
    		String sqlWhere="";
    		
    		if(content.equals("")==false)
    			sqlWhere=" where "+field+" like '%"+content+"%'";
    			if(loginMark.equals("admin")){
    				sql="select * from buyInfo"+sqlWhere+" order by buyId";
    			}
    			else if(loginMark.equals("user")){
    				sql="select * from buyInfo"+sqlWhere+" where userId='"+loginUserId+"' order by buyId";
    			}		
    			rs=db.select(sql);
    		
    		if(rs==null){
    			msg="数据库操作发生错误！"+back;
    			out.print(msg);
    			return;
    		}
    		String userId=request.getParameter("userId");
    	 %>
    	</span>
    	<form action="" method="post">
    	<table width="800" align="center">
    	<tr>
    	<td>
    	<div style="margin:-25px 0px 40px;font-size:small;">
    		欢迎：<%=loginUsername+"&emsp;("+loginMark %>)&emsp;
    		<a href="Logout.jsp">注销登录</a>
    		<a href="changeUser.jsp?userId=<%=loginUserId%>">个人设定</a>&emsp;&emsp;
    		<a href="main.jsp?userId=<%=loginUserId%>">用户功能</a>
    		<%=linkAdmin %>
    	</div>
    	<h3>购买记录</h3>
    	<div class="left" style="margin:40px 0px 5px 0px;">
    		&emsp;&emsp;数据查询:
    		<select name="field" style="vertical-align:middle;">
    			<option value="userId" <%=seletedUserId %>>userId</option>
    			<option value="bookname" <%=seletedBookName %>>图书名称</option>
    			<option value="author" <%=seletedAuthor %>>作者</option>	
    		</select>
    		<input type="text" name="content"value="<%=content%>"style="width:150px;">
    		<input type="submit"name="buttonQuery"value="查询">
    	</div>
    	</td>
    	</tr>
    	<tr>
    	<td>
    	<table class="table_border table_border_bg table_hover"width="100%">
    		<tr class="tr_header">
    			<td>buyId</td>
    			<td>userId</td>
    			<td>用户名</td>
    			<td>图书名称</td>
    			<td>作者</td>
    			<td>购买数量</td>
    			<td>购买时间</td>
    		</tr>
    		<%
    			String buyId,UserId,username,bookname,author,num, timeRenew;
    			while(rs.next()){
    				buyId=rs.getString("buyId");
    				UserId=rs.getString("userId");
    				username=rs.getString("username");
    				bookname=rs.getString("bookname");
    				author=rs.getString("author");
    				num=rs.getString("num");
	   			    timeRenew=rs.getString("timeRenew");
    		%>
    		<tr>
    			<td><%=buyId %></td>
    			<td><%=UserId %></td>
    			<td><%=username %></td>
    			<td><%=bookname %></td>
    			<td><%=author %></td>
    			<td><%=num %></td>
    			<td><%=timeRenew %></td>
    		</tr>			
    		<%
    			}
    			db.close();
    		 %>
    			
    	</table>
    	</td>
    	</tr>
    	</table>
    	</form>
    </div>
  </body>
</html>
