package com.keshav;

import java.sql.*;

public class Conn {
	 
	    Connection con=null;
	    
	    String connectionURL = "jdbc:mysql://localhost:3303/e_commerce?autoReconnect=true&useSSL=false";
	    
	    public Connection start() throws ClassNotFoundException, SQLException
	    {
	        Class.forName("com.mysql.jdbc.Driver");
	        con=DriverManager.getConnection(connectionURL,"root","keshav@nitp");
	        return con;
	    }
	    public void stop() throws SQLException
	    {
	        con.close();
	    } 
}




