package com.keshav;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class loginServlet
 */
@WebServlet("/loginServlet")
public class RegisterServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
  
    public RegisterServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String username = request.getParameter("username");
     	String password = request.getParameter("password");
     	
     	PrintWriter writer = response.getWriter();
				
     	String htmlRespone = "<html>";
     	htmlRespone="Sucess";
     	htmlRespone="</html>";
     	
     	 try{
	            Conn c=new Conn();
	            Connection con=c.start();
	            
	            PreparedStatement ps=con.prepareStatement("insert into user(username,password) values(?,?)" ); // ?--placeholder
	            
	            ps.setString(1,username);
	            ps.setString(2,password);		    		    
	            
	            int x=ps.executeUpdate();  
	            
	            if(x!=0){
	              	    RequestDispatcher rs = request.getRequestDispatcher("/login.jsp");
	            	    rs.include(request, response); 
	            }
	            else
	            {
	            	    RequestDispatcher rs = request.getRequestDispatcher("/register.jsp");
	            	    rs.include(request, response); 
	            }	          
	            	
	        }
	        catch(Exception e)
	        {
	        	System.out.print(e);
	        } 	
	}
}
