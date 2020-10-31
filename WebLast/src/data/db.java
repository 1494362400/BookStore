package data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class db {
	//记得添加库mysql-connector-java-5.1.48-bin.jar到web-Inf/lib文件夹
	private static String driver="com.mysql.cj.jdbc.Driver";	//jar库中的驱动程序
	//IP、端口、数据库名
	private static String connString="jdbc:mysql:///library?useUnicode=true&characterEncoding=UTF-8&useSSL=false&serverTimezone=UTC";
	
	private static String username="root";//连接数据库时的用户名
	private static String password="123456";//连接数据库时的密码
	
	private static Connection conn=null;//数据库连接
	private static Statement stmt=null;//接口实例，事务
	private static ResultSet rs=null;//结果集，记录集
	
	private static PreparedStatement pstmt=null;
	/**
	 * 创建数据库连接
	 */
	private static Connection getConnection(){
		Connection myConn=null;
		
		try {
			Class.forName(driver);//加载驱动程序
			myConn=DriverManager.getConnection(connString,username,password);//创建数据库连接
		} catch (Exception e) {
			System.err.println("\r\n创建数据库连接失败："+e.getMessage()+"\r\n");
			//转义符：\r是回车，\n是换行，前者是光标回到行首(return),后者是光标下移一行(next0
			// TODO: handle exception
		}
		return myConn;//返回null表示创建连接失败
		
	}
	/**
	 * 执行数据查询。需要调用db.close().除非查询时报错，即当rs=null时，才不需要调用db.close().
	 * @param sql-参数sql为准备执行的sql语句，如：select * from student.
	 * @return ResultSet-记录集。
	 */
	
	public static ResultSet select(String sql){
		rs=null;
		try{
			if(conn==null||conn.isClosed()){//如果尚未创建连接，或连接已关闭
				conn=getConnection();		//连接数据库
											//创建接口stmt，数据游标能向前移动，制度。效率更高
			stmt=conn.createStatement(ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);
					//	stmt=conn.createStatement();					//创建接口stmt，以默认方式 。效率更低
			}else if(stmt==null||stmt.isClosed()){
				stmt=conn.createStatement(ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);
			}
			rs=stmt.executeQuery(sql);
		}catch(Exception e){
			close();
			System.err.println("\r\n查询数据失败："+e.getMessage()+"\r\n");
		}
		return rs;
	}
	
	public static int update(String sql){
		return executeUpdate(sql);
	}
	
	public static int delete(String sql){
		return executeUpdate(sql);
	}
	
	private static int executeUpdate(String sql){
		int count=0;
		
		try{
			if(conn==null||conn.isClosed()){
				conn=getConnection();
				stmt=conn.createStatement();
			}else if(stmt==null||stmt.isClosed()){
				stmt=conn.createStatement();
			}
			
			count=stmt.executeUpdate(sql);
		}catch(Exception e){
			e.printStackTrace();
			System.err.println("\r\n数据更新或删除失败:"+e.getMessage()+"\r\n");
		}finally{
			close();
		}
		return count;
	}
	
	public static String insert(String sql){
		String id="0";
		int count=0;
		
		try{
			if(conn==null||conn.isClosed()){
				conn=getConnection();
				stmt=conn.createStatement();
			}else if(stmt==null||stmt.isClosed()){
				stmt=conn.createStatement();
			}
			
			count=stmt.executeUpdate(sql,Statement.RETURN_GENERATED_KEYS);
			
			if(count==0){
				return id;
			}
			rs=stmt.getGeneratedKeys();
					
			if(rs==null){
				return id;
			}
			if(rs.next()){
				id=rs.getString(1);
			}
		}catch(Exception e){
			System.err.println("\r\n数据新添失败:"+e.getMessage()+"\r\n");
		}finally{
			close();
		}
		return id;
	}
	
	public static void close(){
		if(rs!=null){
			try {
				if(rs.isClosed()==false)
					rs.close();
			} catch (Exception e) {
				System.err.println("\r\n关闭记录集rs失败："+e.getMessage()+"\r\n");
				// TODO: handle exception
			}
		}
		if(stmt!=null){
			try {
				if(stmt.isClosed()==false)
					stmt.close();
			} catch (Exception e) {
				System.err.println("\r\n关闭事务stmt失败："+e.getMessage()+"\r\n");
				// TODO: handle exception
			}
		}
		if(pstmt!=null){
			try {
				if(pstmt.isClosed()==false)
					pstmt.close();
			} catch (Exception e) {
				System.err.println("\r\n关闭预处理事务pstmt失败："+e.getMessage()+"\r\n");
				// TODO: handle exception
			}
		}
		if(conn!=null){
			try {
				if(conn.isClosed()==false)
					conn.close();
			} catch (Exception e) {
				System.err.println("\r\n关闭数据库连接conn失败："+e.getMessage()+"\r\n");
				// TODO: handle exception
			}
		}
	}
	

}
