package com.keshav;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
          
    public LoginServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
			String username = request.getParameter("username");
			String password = request.getParameter("password");
		
		 try{
	            Conn c=new Conn();
	            Connection con=c.start();
	            
	            String sql="select username,password from user"; 
	            
	            Statement st=con.createStatement();
	            
	            ResultSet rs=st.executeQuery(sql);
	                
	            int id; 
	    	     
	            String username_=null,password_;
	            
	            PrintWriter out = response.getWriter(); 
	            
	            boolean sucess=false;
	            
	            while (rs.next())
	            {
	            	username_=rs.getString("username");
	            	password_=rs.getString("password");
	            	
	            	if(username_.equals(username)&&password_.equals(password))
	            	{
	            		 HttpSession session=request.getSession();  
	            	     session.setAttribute("username",username);  
	            		 RequestDispatcher rd = request.getRequestDispatcher("/home.jsp");
	            		 rd.include(request, response); 
	            		 sucess=true;
	            		 break;
	            	}
	            }
	            if(!sucess){
	            	out.print("Sorry UserName or Password Error!");  
	        		RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
	        		rd.include(request, response); 
	            }
	        }
	        catch(Exception e)
	        {
	        	System.out.print(e);
	        } 			
	  }
}
