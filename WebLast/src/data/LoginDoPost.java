package data;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.sql.SQLException;

import data.db;
public class LoginDoPost extends HttpServlet {

	/**
		 * The doGet method of the servlet. <br>
		 *
		 * This method is called when a form has its tag value method equals to get.
		 * 
		 * @param request the request send by the client to the server
		 * @param response the response send by the server to the client
		 * @throws ServletException if an error occurred
		 * @throws IOException if an error occurred
		 */
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
		 * The doPost method of the servlet. <br>
		 *
		 * This method is called when a form has its tag value method equals to post.
		 * 
		 * @param request the request send by the client to the server
		 * @param response the response send by the server to the client
		 * @throws ServletException if an error occurred
		 * @throws IOException if an error occurred
		 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");				
		response.setContentType("text/html;charset=UTF-8");	
		String numberRand=request.getParameter("numberRand");
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		PrintWriter out=response.getWriter();
		String msg="";
		for(int f=0;f<1;f++){
			username=username.trim();
			password=password.trim();
			if(username.equals("")){
				msg="请输入用户名！";
				break;
			}
			if(password.equals("")){
				msg="请输入密码！";
				break;
			}
			if(numberRand==null||numberRand.trim().length()!=4){
				msg="请输入4位验证码";
				break;
			}
			HttpSession sessionRand=request.getSession();
			if(sessionRand.getAttribute("numberRand")==null){
				msg="验证码已过期，请重新输入！";
				break;
			}
			String sql="";
	 		ResultSet rs=null;
	 		
	 		sql="select userId,mark from lib_user "
	 			+" where username='"+username+"' and password='"+password+"'";
	 		rs=db.select(sql);
	 		if(rs==null){
	 			msg="数据库操作发生错误！";
	 			return;
	 		}

			try {
				if(rs.next()==false){
					db.close();
					msg="登录失败！所输入的用户名或者密码不正确。";
					break;
				}
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}

			
				// TODO Auto-generated catch block
				
	 		String userId = null;
	 		String mark=null;
			try {
				userId = rs.getString("userId");
				mark=rs.getString("mark");
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	 		
	 		
	 		
			String numberRandSession=sessionRand.getAttribute("numberRand").toString();
			if(numberRandSession.toLowerCase().equals(numberRand.toLowerCase())==false){
				msg="请输入正确的验证码！";
				break;
			}
			sessionRand.invalidate();
			HttpSession session = request.getSession();
			session.setAttribute("loginUserId", userId);
			session.setAttribute("loginMark", mark);
			session.setAttribute("loginUsername", username);
			response.sendRedirect("main.jsp?userId="+userId);	
			return;
		}
		msg=URLEncoder.encode(msg,"utf-8");
		Cookie msgCookie=new Cookie("msg",msg);
		msgCookie.setMaxAge(5);
		response.addCookie(msgCookie);
		
		username=URLEncoder.encode(username,"utf-8");
		Cookie usernameCookie=new Cookie("username",username);
		usernameCookie.setMaxAge(5);
		response.addCookie(usernameCookie);
		
		password=URLEncoder.encode(password,"utf-8");
		Cookie passwordCookie=new Cookie("password",password);
		passwordCookie.setMaxAge(5);
		response.addCookie(passwordCookie);
		
		response.sendRedirect("Login.jsp");
		
	}

}
