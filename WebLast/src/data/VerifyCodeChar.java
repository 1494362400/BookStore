package data;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class VerifyCodeChar extends HttpServlet {

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

		response.setContentType("image/gif");					
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);

		ServletOutputStream out = response.getOutputStream();	
		
		Font mFont = new Font("Times New Roman", Font.PLAIN, 18); 	
		int width = 60, height = 20;						
		
		BufferedImage image = new BufferedImage(width, height,	
				BufferedImage.TYPE_INT_RGB); 
		Graphics gra = image.getGraphics();
		
		Random random = new Random(); 							

		gra.setColor(getRandColor(200, 250)); 					
		gra.fillRect(0, 0, width, height); 						
		gra.setColor(Color.black); 								
		gra.setFont(mFont); 		
		gra.setColor(getRandColor(160, 200));
		for (int i = 0; i < 100; i++) {							
			int x = random.nextInt(width);
			int y = random.nextInt(height);
			int xl = random.nextInt(12);
			int yl = random.nextInt(12);
			gra.drawLine(x, y, x + xl, y + yl); 				
		}
		
		String numberRand = "";
		
		for (int i = 0; i < 4; i++) {							
			//String rand = String.valueOf(random.nextInt(10)); 	
			String[] str={"1","2","3","4","5","6","7","8","9","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"};
			String rand=str[random.nextInt(str.length)];
			numberRand += rand;
			
			gra.setColor(new Color(20 + random.nextInt(110), 
					20 + random.nextInt(110), 20 + random.nextInt(110))); 	
			gra.drawString(rand, 13 * i + 6, 16);				
		}
		
		gra.setColor(getRandColor(160, 200)); 					
		
		for (int i = 0; i < 20; i++) {							
			int x = random.nextInt(width);
			int y = random.nextInt(height);
			int xl = random.nextInt(12);
			int yl = random.nextInt(12);
			gra.drawLine(x, y, x + xl, y + yl); 				
		}
		
		HttpSession session = request.getSession(true);	 	
		session.setAttribute("numberRand", numberRand); 	
		session.setMaxInactiveInterval(30); 				
		
		ImageIO.write(image, "gif", out);						
		out.close();
	}

	static Color getRandColor(int fc, int bc) { 				
		Random random = new Random();
		if (fc > 255)
			fc = 255;
		if (bc > 255)
			bc = 255;
		int r = fc + random.nextInt(bc - fc);
		int g = fc + random.nextInt(bc - fc);
		int b = fc + random.nextInt(bc - fc);
		return new Color(r, g, b);
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

		doGet(request, response);
	}

}
