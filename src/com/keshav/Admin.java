package com.keshav;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Admin")
public class Admin extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public Admin() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String category = request.getParameter("category");
		String string2= request.getParameter("minCost");
		String string3 = request.getParameter("maxCost");
		String string4 = request.getParameter("pcount");
		int minCost=Integer.parseInt(string2);
		int maxCost=Integer.parseInt(string3);
		int pcount=Integer.parseInt(string4);
		
		System.out.println("category is "+category);
		
		Random r = new Random();
		
		int pid=0,cost;
		
		PrintWriter out = response.getWriter(); 
		
		 try{
	            Conn c=new Conn();
	            Connection con=c.start();
	            
                String sql="select pid from product order by pid desc limit 1";
	            
	            Statement st=con.createStatement();
	            
	            ResultSet rs=st.executeQuery(sql);
	                  
	            while (rs.next())
	            {
	            	pid=rs.getInt("pid");
	            }
	            
	            int x=0;
	            
	            for(int i=1; i<=pcount; i++){
  
		            String pname=category;
		    		pname+="_"+Integer.toString(++pid);
		    		
		    		cost = r.nextInt(maxCost-minCost) + minCost;
		            
		    		System.out.println("pname,cost "+pname+" "+cost);
	            	
	                PreparedStatement ps=con.prepareStatement("insert into product(pname,cost) values(?,?)" ); // ?--placeholder
	            
		            ps.setString(1,pname);
		            ps.setInt(2,cost);		    		    
		            
		            x=ps.executeUpdate(); 
	            }
	            if(x!=0){
              	    RequestDispatcher rd = request.getRequestDispatcher("/category.jsp");
            	    rd.include(request, response); 
                }
	            else
	            {
	            	    out.print("Product not updated!");  
	            }
		            
	        }
	        catch(Exception e)
	        {
	        	System.out.print(e);
	        } 	
	}
}


