<%@page import="data.db"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>删除登记</title>
<link rel="stylesheet" href="css/css.css">
</head>

<body background="image/3.jpg">
	<div style="width:600px;margin:10px auto;line-height:40px;">
		<h3>删除登记</h3>
		<span class="msg"> <%
 	request.setCharacterEncoding("utf-8");
 	String msg = "";
 	String back = "&emsp;<a href='javascript:window.history.back();'>后退</a>";
	String userId=session.getAttribute("loginUserId").toString();
 	if (session.getAttribute("loginUsername") == null) {
 		msg = "您的登录已失效！请重新登录。";
 		msg += "&emsp;<a href='index.jsp'>登录</a>";
 		out.print(msg);
 		return;
 	}

 	String loginMark = session.getAttribute("loginMark").toString();

 	if (loginMark.equals("admin") == false) {
 		msg = "您的权限不足！";
 		msg += "&emsp;<a href='main.jsp?userId="+userId+"'>用户功能</a>";
 		out.print(msg);
 		return;
 	}
 	String needId = request.getParameter("needId");

 	try {
 		Integer.parseInt(needId);
 	} catch (Exception e) {
 		msg = "参数needId错误！" + back;
 		out.print(msg);
 		return;
 	}

 	String sql = "";
 	ResultSet rs = null;

 	sql = "select * from needBook where needId='" + needId + "'";
 	rs = db.select(sql);

 	if (rs == null) {
 		msg = "数据库操作发生错误！" + back;
 		out.print(msg);
 		return;
 	}

 	if (rs.next() == false) {
 		db.close();
 		msg = "对应的记录已不存在！" + back;
 		out.print(msg);
 		return;
 	}
	
	rs.close();
	
	sql="delete from needBook where needId='"+needId+"'";
	int count=db.delete(sql);
	
	if(count==0){
		msg="刪除登记信息失敗！請重試。"+back;
		out.print(msg);
		return;
	}
	msg="刪除登记信息成功！";
	out.print(msg);
 	
 %>
		</span>

		
		<br> <a href="lookNeed.jsp?userId=<%=userId %>">返回</a>

	</div>
</body>
</html>
