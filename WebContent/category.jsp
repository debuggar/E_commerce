<jsp:include page="header.jsp" />  

<body>    
<ul class="products">
    <%@ page import="java.sql.*" %>

		<%		
		    int pid=0,cost=0;
		    String pname=null,path=null;  
		
		    int id=0;
		
			try{
		        Connection con=null;
			    
			    String connectionURL = "jdbc:mysql://localhost:3303/e_commerce?autoReconnect=true&useSSL=false";
			
			    Class.forName("com.mysql.jdbc.Driver");
		    
			    con=DriverManager.getConnection(connectionURL,"root","keshav@nitp");
			    
			    String sql="select * from product";
		       
		        Statement st=con.createStatement();
		        
		        ResultSet rs=st.executeQuery(sql);
		        
		        while (rs.next())
		        {
		        	pid=rs.getInt("pid");
		        	pname=rs.getString("pname");
		        	cost=rs.getInt("cost");
		        	
		        	if(pname.contains("Television"))
		        	   path="image/television.jpg";
		        	else if(pname.contains("Laptop"))
			        	   path="image/laptop.jpg";
		        	else if(pname.contains("Mobile"))
			        	   path="image/mobile.jpg";
		        	else if(pname.contains("Refrigerator"))
			        	   path="image/refrigerator.jpg";
		        	else if(pname.contains("Camera"))
		        		path="image/camera.jpg";
		        	else
		        		path="image/img.jpg";
		        	
		        	%>
		        	 <li>
		        	 <a href="product.jsp?pid=<%=pid%>">
			            <img src=<%=path %> width="120" height="170">
			            <h4><%=pname %></h4>
			            <p><%=cost %></p>
			         </a>
			         </li>
		        	<%
		        }    
			}
			catch(Exception e)
		    {
		        System.out.print(e);;
		    } 
		%>  
</ul>
<body>
</html>    

