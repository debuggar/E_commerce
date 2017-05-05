<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>E Commerce</title>
<link rel="stylesheet" type="text/css" href="style.css">

 <h2>E Commerce Website using Pearson Cofficient</h2>

<%
    String username=null;
    if(request.getSession(false) != null){
          HttpSession session2 = request.getSession();
          username=(String)session.getAttribute("username"); 
          if(username!=null)
          {
        	  %>
        	  <div class="home">
        	        <a href="home.jsp">Home</a>
	        	    <h4>Hello <%=username %></h4>
	        	    <a href="logout">Logout</a>
	        	    <a href="category.jsp"> Products </a>
	        	       
        	   </div>  
        	<%   
          } 
	else{
	  %>
	     <div class="home">
		    <a href="home.jsp">Home</a>
		    <a href="login.jsp">Login</a>
		    <a href="register.jsp">Register</a> 
		    <a href="category.jsp"> Products </a> 
		   
         </div>	
		<% 
	}
}         
%>
</head>
