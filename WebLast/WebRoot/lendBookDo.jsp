<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="data.db"%>
<%@page import="java.sql.ResultSet"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>借阅结果</title>
  </head>
  <body background="image/3.jpg">
  	<div style="width:810px;margin:10px auto;line-height:40px;">
    	<h3>借阅结果</h3>
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
     	String sql="";
    	ResultSet rs=null;
    	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
        //System.out.println(df.format(new Date()));// new Date()为获取当前系统时间
    	List<String> bookidlist=new ArrayList<String>();
    	List<String> namelist=new ArrayList<String>();
    	List<String> authorlist=new ArrayList<String>();
    	sql="select * from buyBook";
    	rs=db.select(sql);
    	if(rs==null){
    			msg="数据库操作发生错误！"+back;
    			out.print(msg);
    			return;
    	}
    	//因为不知道数据有多少，所以先保存到列表中
    	while (rs.next()) {
    		bookidlist.add(rs.getString("bookId"));
    		namelist.add(rs.getString("bookname"));
    		authorlist.add(rs.getString("author"));
   		}
    	String newBooks[]=new String[bookidlist.size()];
    	String newauthor[]=new String[authorlist.size()];
    	String selectId[]=request.getParameterValues("bookId");  	
    	double total=0.0;
    	if(selectId!=null){
    		for(int i=0;i<selectId.length;i++){
    			for(int j=0;j< bookidlist.size();j++){
    				if(selectId[i].equals(bookidlist.get(j))){
    					ResultSet select=null;
    					sql="select * from lendBook where userId='"+loginUserId+"' and bookname='"+namelist.get(j)+"' and author='"+authorlist.get(j)+"' and sign='false'";
    					select=db.select(sql);
    					if(select.next()==false){
    					sql="insert into lendBook(userId,username,bookname,author,sign) values ('"+loginUserId+"','"+loginUsername
    					+"','"+namelist.get(j)+"','"+authorlist.get(j)+"','false')";
    					String lendBook=db.insert(sql);
    					if(lendBook==null){
					  		msg="数据库操作发生错误！"+back;
					  		out.print(msg);
					  		return;
					  	}
					  	newBooks[i]=namelist.get(j);
    					newauthor[i]=authorlist.get(j);
    				}
    				else{
    					msg="你已借阅该书，如需续借请前往续借界面；"+back;
    					out.print(msg);
    					return;
    				}
    			}
    		}
    	}
    	}
      %>
      <table border frame=hsides>
  		<tr><td>图书名称</td><td>作者</td><td>借阅人</td><td>借阅结果</td></tr>
      <%
     if(selectId!=null){
      for(int k=0;k<selectId.length;k++){
       %>
  		<tr align="center">
     		<td><%=newBooks[k] %></td>
     		<td><%=newauthor[k] %></td>
     		<td><%=loginUsername %></td>
     		<td style="color:red">借阅成功</td>
     	</tr>
      
      <%} 
      }%>
     </table>
     <a href="lendBook.jsp">返回借阅</a>
     </div>
  </body>
</html>
