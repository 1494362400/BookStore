<%@page import="java.net.URLDecoder"%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<title>用户登录</title>
	<link rel="stylesheet" href="css/css.css">
  </head>
  
  <body background="image/1.jpg">
    <div style="width:600px;margin:10px auto;line-height:40px;">
    <%
    	request.setCharacterEncoding("utf-8");
    	String msg="";
    	String value="";
    	String username="";
    	String password="";
    	
    	Cookie[] cookies=request.getCookies();
    	
    	if(cookies!=null){
    		for(int i=0;i<cookies.length;i++){
    			if(cookies[i].getName().equals("msg")){
    				value=cookies[i].getValue();
    				msg=URLDecoder.decode(value,"utf-8");
    				continue;
    			}
    			if(cookies[i].getName().equals("username")){
    				value=cookies[i].getValue();
    				username=URLDecoder.decode(value,"utf-8");
    				continue;
    			}
    			if(cookies[i].getName().equals("password")){
    				value=cookies[i].getValue();
    				password=URLDecoder.decode(value,"utf-8");
    				continue;
    			}
    		}
    	}
     %>
    	<h3>用户登录</h3>
    	<form action="LoginDoPost" method="post">
		   	用户名：
		   	<input type="text" name="username" value="<%=username%>"style="width:150px;">&ensp;
		   	<br>
		   	密&emsp;码：
		   	<input type="password" name="password" value="<%=password%>" style="width:150px;">&ensp;
			<br>
			验证码：
			<input type="text" name="numberRand" maxlength="4" style="width:80px;">&ensp;
			<a href="#"></a><img src="VerifyCodeChar" id="imgCode" onclick="codeChange();"
				style="vertical-align:middle;border:0px;"></a>
			<a href="#" style="font-size:small;"onclick="codeChange();">刷新</a>
			<br>
			&emsp;&emsp;&emsp;&emsp;&emsp;
			<input type="submit" value="登录">
			&emsp;
			<input type="button" name="register" value="注册" onclick="window.location.href('Register.jsp')" class="button">
			&emsp;
			<p>
			<span id="msg" style="color:red;font-size:small;"><%=msg %></span>
		</form>
	</div>
  </body>
  <script type="text/javascript">
  		window.onload=codeChange();		
  		function codeChange(){
  			var t=(new Date()).getTime();
  			document.getElementById("imgCode").src="VerifyCodeChar?t="+t;
  			document.getElementsByName("numberRand")[0].focus();
  		}
  </script>
</html>
