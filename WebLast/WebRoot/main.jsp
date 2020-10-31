<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="data.db"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>用户功能</title>
  </head>
  <body background="image/2.jpg">
  	<div style="width:600px;margin:10px auto;line-height:40px;">
    	<h3>用户功能</h3>
    <span class="msg">
  <%
  	request.setCharacterEncoding("utf-8");
    String msg="";
    		
    if(session.getAttribute("loginUsername")==null){
		msg="您的登录已失效！请重新登录。";
		msg+="&emsp;<a href='Login.jsp'>登录</a>";
		out.print(msg);
		return;
	}
  	String loginMark=session.getAttribute("loginMark").toString();
  	String loginUserId=session.getAttribute("loginUserId").toString();
  	String loginUsername=session.getAttribute("loginUsername").toString();
   %>
   </span>
   <div style="margin:-25px 0px 40px;font-size:small;">
    		欢迎：<%=loginUsername+"&emsp;("+loginMark %>)&emsp;
    		<a href="Logout.jsp">注销登录</a>
    		<a href="changeUser.jsp?userId=<%=loginUserId%>">个人设定</a>&emsp;&emsp;
    	</div>
    	<%
    		String sql="";
    		ResultSet rs=null;
    		boolean sign=false;
    		String tip="温馨提示：你登记的书籍";
    		String back="&emsp;<a href='javascript:window.history.back();'>后退</a>";
    		sql="select * from needBook where userId='"+loginUserId+"'";
    		rs=db.select(sql);
    		if(rs==null){
    			msg="数据库操作发生错误！"+back;
    			out.print(msg);
    			return;
    		}
    		if(rs.isBeforeFirst()!=rs.isAfterLast()){			
    		List<String> namelist=new ArrayList<String>();
    		List<String> authorlist=new ArrayList<String>();
    			while(rs.next()){
    				namelist.add(rs.getString("bookname"));
    				authorlist.add(rs.getString("author"));
				}
				
				for(int i=0;i<namelist.size();i++){
    				sql="select * from buyBook where bookname='"+namelist.get(i)+"' and author='"+authorlist.get(i)+"'";
    				ResultSet rs2=db.select(sql);
    				if(rs2==null){
    					msg="数据库操作发生错误！"+back;
    					out.print(msg);
    					return;
    				}
    				if(rs2.next()==true){
    					sign=true;
    					tip+=authorlist.get(i)+"写的《"+namelist.get(i)+"》";
    			
    				}
    				}
    			
    			tip+="已加入，可以前往查看";
				if(sign==true){
    			%>
    			<div style="color:red"><marquee direction="left"><%=tip %></marquee>
    			</div>
    			
    			<%
    			}
    		}
    	 %>
    	 
    <table width="300" class="table_border table_border_bg table_hover" border="solid">
    	<tr height="50"class="tr_header">
    			<th colspan="2">
    				用户功能列表
    			</th>
    	</tr>
    	<tr align="center">
    		<td><a href="buyBook.jsp">购买图书</a></td>
    		<td><a href="lendBook.jsp">借阅图书</a></td>
    	</tr>
    	<tr>
    		<td align="center"><a href="lookLend.jsp">查看借阅</a></td>
    		<td align="center"><a href="lookInfo.jsp">查看记录</a></td>
    	</tr>
    	<tr align="center">
    		<td><a href="needBook.jsp">缺书登记</a></td>
    		<td><a href="Register.jsp">用户注册</a></td>
    	</tr>
    	<%
			if(loginMark.equals("admin")){    	
    	 %>
    	<tr align="center">
    		<td><a href="lookNeed.jsp">查看缺书</a></td>
    		<td><a href="addBook.jsp">添加图书</a></td>
    	</tr>
    	<tr align="center">
    		<td><a href="bookInfo.jsp">图书列表</a></td>
    		<td><a href="userlist.jsp">用户列表</a></td>
    	</tr>
    	<%} %>
    </table>
    </div>
  </body>
</html>
