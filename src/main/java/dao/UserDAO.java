package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.UserBean;

public class UserDAO extends DAOparam{
	static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
	public UserBean certification(String id,String pw) {
		try(Connection conn = DriverManager.getConnection(JDBC_URL,DB_USER,DB_PASS)){
			String sql = "select * from users where user_id = ? and password = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, id);
			pStmt.setString(2, pw);
			
			ResultSet rs = pStmt.executeQuery();
			
			String user_id;
			String password;
			String role;
			String created_at;
			String updated_at;
			String updated_by;
			
			UserBean ub = new UserBean();
			int cnt = 0;
			
			while(rs.next()) {
				user_id = rs.getString("user_id");
				password = rs.getString("password");
				role = rs.getString("role");
				created_at = rs.getString("created_at");
				updated_at = rs.getString("updated_at");
				updated_by = rs.getString("updated_by");
				ub = new UserBean(user_id,password,role,created_at,updated_at,updated_by);
				cnt ++;
			}
			if(cnt!=0) {
				return ub;
			}else {
				return null;
			}
		}catch (SQLException e) {
			return null;
		}
	}
}
