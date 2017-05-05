<jsp:include page="header.jsp" />  

<body>

<div class="clearfix float-my-children outer">
   
   <%!
        public static double Correlation(ArrayList<Integer> xs, ArrayList<Integer> ys) {
	    //TODO: check here that arrays are not null, of the same length etc

			    double sx = 0.0;
			    double sy = 0.0;
			    double sxx = 0.0;
			    double syy = 0.0;
			    double sxy = 0.0;
		
			    int n = xs.size();
			    
			    if(n==0)
			    	 return -1.00;
		
			    for(int i = 0; i < n; ++i) {
			      double x = xs.get(i);
			      double y = ys.get(i);
		
			      sx += x;
			      sy += y;
			      sxx += x * x;
			      syy += y * y;
			      sxy += x * y;
			    }
		
			    // covariation
			    double cov = sxy / n - sx * sy / n / n;
			    // standard error of x
			    double sigmax = Math.sqrt(sxx / n -  sx * sx / n / n);
			    // standard error of y
			    double sigmay = Math.sqrt(syy / n -  sy * sy / n / n);
		
			    // correlation is just a normalized covariation
			    return cov / sigmax / sigmay;
	  }
   %>
   
   <%!
	   private static HashMap sortByValues(HashMap map) { 
	       List list = new LinkedList(map.entrySet());
	       // Defined Custom Comparator here
	       Collections.sort(list, new Comparator() {
	            public int compare(Object o1, Object o2) {
	               return  -1*((Comparable) ((Map.Entry) (o1)).getValue())
	                  .compareTo(((Map.Entry) (o2)).getValue());
	            }
	       });
	
	       // Here I am copying the sorted list in HashMap
	       // using LinkedHashMap to preserve the insertion order
	       HashMap sortedHashMap = new LinkedHashMap();
	       for (Iterator it = list.iterator(); it.hasNext();) {
	              Map.Entry entry = (Map.Entry) it.next();
	              sortedHashMap.put(entry.getKey(), entry.getValue()); 
	       } 
	     
	       return sortedHashMap;
	  }
   %>
   
   
   <%@ page import="java.sql.*"
            import="java.util.*"
    %>

		<%		
		    int pid=Integer.parseInt(request.getParameter("pid"));
		    int cost=0;
		    String pname=null,path=null;  
		
			try{
		        Connection con=null;
			    
			    String connectionURL = "jdbc:mysql://localhost:3303/e_commerce?autoReconnect=true&useSSL=false";
			
			    Class.forName("com.mysql.jdbc.Driver");
		    
			    con=DriverManager.getConnection(connectionURL,"root","keshav@nitp");
			    
			    String sql="select pname,cost from product where pid="+pid;
		       
		        Statement st=con.createStatement();
		        
		        ResultSet rs=st.executeQuery(sql);
		        
		        while (rs.next())
		        {
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
		        }    
		        
		        String username=null, user=null;  int productid=0; boolean alreadyPresent=false;
		        
		        if(request.getSession(false) != null)
		        {
		        	HttpSession session2 = request.getSession();
		         
		        	username=(String)session.getAttribute("username"); 
		            
		        	if(username!=null)
		        	{	        	
			            sql="select user,productid from profile";
			              
			            rs=st.executeQuery(sql);
			              
		                  while(rs.next())
		                  {
		            	       user=rs.getString("user");
		            	       productid=rs.getInt("productid");
		            	       if(user.equals(username)&&productid==pid)
		            		        alreadyPresent=true;
		                  }
		             }	       
	             }
		                        
	              if(username!=null&&!alreadyPresent)
	              {
	            	  PreparedStatement ps=con.prepareStatement("insert into profile(user,productid,count) values(?,?,?)" ); // ?--placeholder
	  	            
		  	          ps.setString(1,username);
		  	          ps.setInt(2,pid);		    		    
  			  	          ps.setInt(3,1);
		  	          
		  	          int x=ps.executeUpdate();  
	              }
	              
	              if(username!=null&&alreadyPresent)
	              {
	            	  String pid_=Integer.toString(pid);
	            	  String sql2="update profile set count=count+1 where user=" + "\"" + username + "\"" + " AND productid="+ pid;
	            	  st.execute(sql2);  
	              }
	        
	             ArrayList<Integer> array=new ArrayList<Integer>();
	            
	             ArrayList<Integer> array2=new ArrayList<Integer>();      

	             ArrayList<Integer> result=new ArrayList<Integer>();
	             
	             String sql2=null,sql3=null,sql4=null;  int next_pid=0,count=0;
	             
	             Statement st2=con.createStatement(); ResultSet rs2=st.executeQuery(sql);
	             
	             Statement st3=con.createStatement(); ResultSet rs3=st.executeQuery(sql);
	             
	             Statement st4=con.createStatement(); ResultSet rs4=st.executeQuery(sql);
	             
	             HashMap<Integer, Double> hmap = new HashMap<Integer, Double>();
	             
	       	     Map<Integer, Double> map3=null;
	             
	             if(username!=null)
	             {
	            	  sql="select distinct productid from profile where productid <>"+pid;
	            	  
	            	  rs=st.executeQuery(sql);
	
	            	  while(rs.next())
	                  {
	            	       next_pid=rs.getInt("productid");
	     		  
	            		   sql2="SELECT DISTINCT user FROM profile WHERE productid="+pid +" && user IN ( SELECT user FROM profile WHERE productid=" +next_pid+" )" ;
	            		
	            		   rs2=st2.executeQuery(sql2);  
	            		   
		            		   while(rs2.next())
		            		   {
		            			   user=rs2.getString("user");
		            			   
		            			   //System.out.println("user "+user);
		            			   
		            			   sql3="SELECT * FROM `profile` WHERE ( productid ="+ pid  +" ) && user ="+"\"" + user + "\"";
		            			   
		            			   rs3=st3.executeQuery(sql3);
		            
		            			   while(rs3.next())
		            			   {
		            				   count=rs3.getInt("count");
		            				   
		                               array.add(count);     	
		                        	  // System.out.println("added");
		            			   }
		            			   
		            			   sql4="SELECT * FROM `profile` WHERE ( productid ="+ next_pid  +" ) && user ="+"\"" + user + "\"";
		            			   
		            			   rs4=st4.executeQuery(sql4);
		          
		            			   while(rs4.next())
		            			   {
		            				   count=rs4.getInt("count");
		       
		            				   array2.add(count);
		            				   //System.out.println("added2");
		            			   }
		            		   }
	                       
                        	  // System.out.println( "Correlation "+Correlation(array,array2) ) ;
		     	      
                        	  double relation=Correlation(array,array2);	 
                          
		            		  if(relation>=0.500){
		            			    result.add(next_pid);
		            			    hmap.put(next_pid,relation);
		            		  }
		            		
		            		 /*  Set set = hmap.entrySet();
		            	      Iterator iterator = set.iterator();
		            	      while(iterator.hasNext()) {
		            	           Map.Entry me = (Map.Entry)iterator.next();
		            	           System.out.print(me.getKey() + ": ");
		            	           System.out.println(me.getValue());
		            	      } */
		            		  
		            		 map3 = sortByValues(hmap); 
		            		
		            		 /*  Set set2 = map3.entrySet();
		            	      Iterator iterator2 = set2.iterator();
		            	      
		            	      while(iterator2.hasNext()) {
		            	           Map.Entry me2 = (Map.Entry)iterator2.next();
		            	           System.out.print(me2.getKey() + ": ");
		            	           System.out.println(me2.getValue());
		            	      } */
		            	      
		            	      array.clear(); array2.clear();
	            	  } 
	             }
	             %>
	             
	             
	             <img  src=<%=path %> width="170" height="250">	
	             
	             <div class="desc">	
	                <h3> <%=pname %></h3><br>
	                   Cost : Rs <%=cost %><br>
	                  
	             </div>             
	
           <h3>Recommended Product According to item to item correlation</h3>             
	       <ul class="products">   
	             <%
	             
		          Set set2 = map3.entrySet();
	       	      Iterator iterator2 = set2.iterator();
	       	      int pcount=0;
	       	      
	       	      System.out.println("For Item to Item Filteration");
	       	      while(iterator2.hasNext()&&pcount++<5) {
	       	    	  
	       	           Map.Entry me2 = (Map.Entry)iterator2.next();
	       	            System.out.print(me2.getKey() + " : ");
	       	           System.out.print(me2.getValue()+"   ");
	       	            
	       	        String sql5="select pname,cost from product where pid="+me2.getKey();
	 		      
			        Statement st5=con.createStatement();
			        
			        ResultSet rs5=st.executeQuery(sql5);  
			     
			        while (rs5.next())
			        {
			        	pname=rs5.getString("pname");
			        	cost=rs5.getInt("cost");
			        }	
	       	           
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
					        	 <a href="product.jsp?pid=<%=me2.getKey()%>">
						            <img src=<%=path %> width="120" height="170">
						            <h4><%=pname %></h4>
						            <p><%=cost %></p>
						         </a>
			               </li>
	       	           <%
	       	      }
	             %>
                   </ul>	    
                    <h3>Recommended Product According to person to person correlation</h3>         
	             <%
	             
                 HashMap<String, Double> hmap2 = new HashMap<String, Double>();
	             
	       	     Map<String, Double> map4=null;      
	             
	       	System.out.println("\nFor person to person");   
	       	
	       if(username!=null) 
	       {
	             sql="select distinct user from profile where user!="+"\"" +username+"\"";
	             
	             rs=st.executeQuery(sql);
	             
	             while(rs.next())
	             { 
	            	 user=rs.getString("user");
	            	 
	            	 sql2="SELECT distinct productid FROM `profile` WHERE user="+"\"" +username+"\""+ " && productid IN (SELECT productid FROM profile WHERE user ="+ "\"" +user+"\""+")";      
	         	 
	            	 rs2=st2.executeQuery(sql2);
	            	 
	            	 while(rs2.next())
	            	 {
	            		next_pid=rs2.getInt("productid");
	            		
	            		sql3="select count from profile where user="+"\"" +username+"\"" +" and productid="+next_pid;
	            		
	            		rs3=st3.executeQuery(sql3);
	            		
	            		while(rs3.next())
	            		{
	            			count=rs3.getInt("count");
	            			array.add(count);
	            		}
	            		
	            		sql4="select count from profile where user="+"\"" +user+"\"" +" and productid="+next_pid;
	            		
	            		rs4=st4.executeQuery(sql4);
	            		
	            		while(rs4.next())
	            		{
	            			count=rs4.getInt("count");
	            			array2.add(count);
	            		}	 
	            	 }
	            	 
	            	 double relation=Correlation(array,array2);	 
	            	 
           		    if(relation>=0.200){
           			   hmap2.put(user,relation);
           		    }
	            	 
	           		 map4 = sortByValues(hmap2); 
	        
	        	     array.clear(); array2.clear();
	        	     
	             } 
	      }  
	     
	          Set set3 = map4.entrySet();
     	      Iterator iterator3 = set3.iterator();
     	      ArrayList<Integer> array3=new ArrayList<Integer>();
     	     
     	      pcount=0;
     	      
     	      while(iterator3.hasNext()&&pcount++<5) {
     	    	  
	     	           Map.Entry me2 = (Map.Entry)iterator3.next();
	     	            System.out.print(me2.getKey() + " : ");
	     	            System.out.print(me2.getValue()+" ");
	     	            
	     	            
	     	        String sql6="select distinct productid from profile where user="+"\""+me2.getKey()+"\""+" && productid not in ( select productid from profile where user=" +"\""+username+"\""+" )";       
	       
	     	        Statement st6=con.createStatement();
	   		        
	   		        ResultSet rs6=st.executeQuery(sql6);      
	     	        
	   		        boolean found=false;
	   		        while(rs6.next())
	   		        {
	   		        	int productid2=rs6.getInt("productid");
	   		        	found=false;
	   		            for(int i=0; i<array3.size(); i++)
	   		            {
	   		                 if(array3.get(i)==productid2)
	   		                 {
	   		                	 found=true;
	   		                	 break;
	   		                 }
	   		            }
	   		             if(!found)
	   		        	    array3.add(productid2);
	   		        }
     	       } 
   		        
     	      
   	           int productid3=0;
	     	 
	   	        %>
	   		    
	 	       <ul class="products">   
	            <%
            
     	       for(int i=0; i<array3.size()&&i<5; i++){
		     	        String sql5="select pname,cost from product where pid="+ array3.get(i);
		     	        productid3=array3.get(i);
				        ResultSet rs5=st.executeQuery(sql5); 
				        while (rs5.next()){
				        	pname=rs5.getString("pname");
				        	cost=rs5.getInt("cost");
				        }	  
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
						        	    <a href="product.jsp?pid=<%=productid3 %>">
							            <img src=<%=path %> width="120" height="170">
							            <h4><%=pname %></h4>
							            <p><%=cost %></p>
							            </a>
				               </li>
		     	           <%
		     	  }
		           %>
		       </ul>	   
			     <%    
			     System.out.println("\n");
			}
			catch(Exception e)
		    {
		        System.out.print(e);
		    } 
	 %>  
	 
</div>

</body>

</html>