<%@page import="java.text.DateFormat"%>
<%@page import="java.text.ParsePosition"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="data.db"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>查看借阅</title>
  </head>
  
  <body background="image/4.jpg">
    <div style="width:810px;margin:10px auto;line-height:40px;">
  	<h3>查看借阅</h3>
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
  	 <%
  	 	String sql="";
    	ResultSet rs=null;
    	sql="select * from lendBook where userId='"+loginUserId+"' and sign='false'";
    	rs=db.select(sql);
    	if(rs==null){
    			msg="数据库操作发生错误！"+back;
    			out.print(msg);
    			return;
    	}
    	if(rs.isBeforeFirst()==rs.isAfterLast()){
    		msg="暂无借阅书籍"+back;
    		out.print(msg);
    		return;
    	}
  	  %>
  	   <form action="longLendDo.jsp" method="post">
    <div style="margin:-25px 0px 40px;font-size:small;">
	    		欢迎：<%=loginUsername+"&emsp;("+loginMark %>)&emsp;
	    		<a href="Logout.jsp">注销登录</a>
	    		<a href="changeUser.jsp?userId=<%=loginUserId%>">个人设定</a>&emsp;&emsp;
	    		<a href="main.jsp?userId=<%=loginUserId%>">用户功能</a>
	    		</div>
    <table border="solid">	    		
    	<tr>
    		<td>图书名称</td><td>图书作者</td><td>剩余时间</td>
    	</tr>
    		<%
    		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-ddHH:mm:ss");//设置日期格式
        //System.out.println(df.format(new Date()));// new Date()为获取当前系统时间
    		while(rs.next()){
    			String lendId=rs.getString("lendId");
    			String bookname=rs.getString("bookname");
    			String author=rs.getString("author");
    			String timeRenew=String.format("%tF%<tT",rs.getTimestamp("timeRenew"));
    			//out.print(timeRenew);
    			Date date=new Date();
    			try{
    				date = df.parse(timeRenew);
    			}catch(Exception e){
    				e.printStackTrace();
    			}
    			long time=date.getTime();
    			Date datenow = new Date();
        		long timenow=datenow.getTime();
        		long time2=timenow-time;
        		long time3=(time2/1000/60/60/24);
        		long time4=30-time3;
    		%>
    	<tr>
    		<td><label><input type="radio" value=<%=lendId %> name="lendId"><%=bookname %></label></td>
    		<td><%=author%></td><td><%=time4 %>天</td>
    	</tr>
    		<%
    		}
    		%>
    	
    </table>
    <input type="submit" name="submit" value="续借">
    <input type="button" value="归还" onclick="as()">
    </form>    
  	  </div>
  </body>
  <script type="text/javascript">
  	function as(){
  		var id=document.getElementsByName("lendId");
  		for(var i=0;i<id.length;i++){
  		if(id[i].checked==true){
  		window.location.href('returnBookDo.jsp?lendId='+id[i].value)
  		}
  		}
  	}
  </script>
</html>
