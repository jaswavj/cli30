package util; 
import java.sql.*;
import javax.naming.*;
import javax.sql.*;

public final class DBConnectionManager 
	{
	private static 	DBConnectionManager manager = new DBConnectionManager();
	private DataSource ds;
		
	private DBConnectionManager()
		{
		try 
			{
			Context initCtx = new InitialContext();
			Context envCtx 	= (Context) initCtx.lookup("java:comp/env"); 
			ds 		= (DataSource)envCtx.lookup("jdbc/nammadb"); 
			System.out.println("Connection Created by Pooling Method"); 
			}
		catch(Exception e)
			{
			e.printStackTrace();	
			} 
		}
	
	public static Connection getConnectionFromPool() throws SQLException
		{
		Connection con = 	manager.ds.getConnection();
		con.setAutoCommit(false);
		try (Statement st = con.createStatement()) {
			st.execute("SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci");
			st.execute("SET CHARACTER SET utf8mb4");
			st.execute("SET character_set_connection = utf8mb4");
			st.execute("SET character_set_results = utf8mb4");
			st.execute("SET character_set_client = utf8mb4");
		}
		
		return con;
		}
	
	}////////////End of Class
