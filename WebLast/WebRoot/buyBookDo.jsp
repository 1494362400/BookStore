<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="data.db"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>结算界面</title>
  </head>
  <body background="image/3.jpg" style="background-repeat:no-repeat;background-attachment: fixed;">
  	<div style="width:810px;margin:10px auto;line-height:40px;">
    	<h3>结算</h3>
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
     <table border frame=hsides>
  		<tr><td>图书名称</td><td>图书单价</td><td>作者</td><td>购买数量</td><td>金额</td></tr>
     <%
     	String sql="";
    	ResultSet rs=null;

    	sql="select * from buyBook";
    	rs=db.select(sql);
    	if(rs==null){
    			msg="数据库操作发生错误！"+back;
    			out.print(msg);
    			return;
    	}
    	//因为不知道数据有多少，所以先保存到列表中
    	String num[]=request.getParameterValues("count");
    	String selectId[]=request.getParameterValues("bookId");
    	List<String> bookIds=new ArrayList<String>();
    	List<String> booknames=new ArrayList<String>();
    	List<String> authors=new ArrayList<String>();
    	List<String> nums=new ArrayList<String>();
    	double total=0.0;
    	double money=0.0;
    	if(selectId!=null){
    		while(rs.next()){
    			String bookId=rs.getString("bookId");
    			bookIds.add(bookId);
    			String bookname=rs.getString("bookname");
    			String bookprice=rs.getString("bookprice");
    			double price=Double.valueOf(bookprice.toString());
    			String author=rs.getString("author");
    			String buynum=null;
    			for(int i=0;i< selectId.length;i++){
    				if(selectId[i].equals(bookId)){
    				for(int j=0;j<bookIds.size();j++){
    					if(bookId.equals(bookIds.get(j))){
    						money=price*Integer.parseInt(num[j]);
    						total+=money;
    						buynum=num[j];
    					}
    				}
    					
    					booknames.add(bookname);
    					authors.add(author);
    					nums.add(buynum);
    					%>
    		<tr align="center">
     			<td><%=bookname %></td>
     			<td><span style="color:red"><%=price %></span>元</td>
     			<td><%=author %></td>
     			<td><%=buynum %></td>
     			<td><span style="color:red"><%=money %></span>元</td>
     		</tr>
    				<%}
    			}
    		}
    		rs.close();
    		for(int i=0;i<booknames.size();i++){
    			sql="insert into buyInfo(userId,username,bookname,author,num) values('"+loginUserId+"','"+loginUsername+"','"+booknames.get(i)+"','"+authors.get(i)+"','"+nums.get(i)+"')";
    					String buy=db.insert(sql);
    					if(buy==null){
					  		msg="数据库操作发生错误！"+back;
					  		out.print(msg);
					  		return;
					  	}
    	}
    	}
      %>
      


      
     <td></td><td></td><td></td><td>总计金额：</td><td><span style="color:red"><%=total %></span>元<td>
     </table>
     <a href="buyBook.jsp">返回购买</a>
     </div>
  </body>
</html>
