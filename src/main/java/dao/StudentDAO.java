package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.StudentBean;
import model.UserBean;

public class StudentDAO extends DAOparam{
	static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
	public StudentBean search_by_id(UserBean user) {
		try(Connection conn = DriverManager.getConnection(JDBC_URL,DB_USER,DB_PASS)){
			String sql = "select u.user_id,u.password,u.role,u.created_at,u.updated_at,u.updated_by "
					+ "s.student_name,s.class_id,s.email,s.phone,s.photo_path "
					+ "from users  u join students s on u.user_id = s.student_id "
					+ "where u.user_id = ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, user.getUser_id());
			
			ResultSet rs = pStmt.executeQuery();
			
			
			if (rs.next()) {
			    // (A) 親の情報を、DBから取得した rs からセット
			    String user_id = rs.getString("user_id");
			    String password = rs.getString("password");
			    String role = rs.getString("role");
			    String created_at = rs.getString("created_at");
			    String updated_at = rs.getString("updated_at");
			    String updated_by = rs.getString("updated_by");
			    
			    // (B) 子の情報を、DBから取得した rs からセット
			    String student_name = rs.getString("student_name");
			    String class_id = rs.getString("class_id");
			    String email = rs.getString("email");
			    String phone = rs.getString("phone");
			    String photo_path = rs.getString("photo_path");
			    
			    // (A)と(B) のすべての変数をコンストラクタに格納する
			    StudentBean student = new StudentBean(user_id,password,role,created_at,updated_at,updated_by,
			            student_name,class_id,email,phone,photo_path);
			    
			    //すべてが詰まった「完全な studentBean」を返す
			    return student;
			    
			}else {
			    return null;
			}
		}catch (SQLException e) {
			return null;
		}
	}
	public List<StudentBean> findall() {
		List<StudentBean> student_list = new ArrayList<>();
		try(Connection conn = DriverManager.getConnection(JDBC_URL,DB_USER,DB_PASS)){
			String sql = "select u.user_id,u.password,u.role,u.created_at,u.updated_at,u.updated_by, "
					+ "s.student_name,s.class_id,s.email,s.phone,s.photo_path "
					+ "from users  u join students s on u.user_id = s.student_id ";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			
			ResultSet rs = pStmt.executeQuery();
			
			
			while (rs.next()) {
			    // (A) 親の情報を、DBから取得した rs からセット
			    String user_id = rs.getString("user_id");
			    String password = rs.getString("password");
			    String role = rs.getString("role");
			    String created_at = rs.getString("created_at");
			    String updated_at = rs.getString("updated_at");
			    String updated_by = rs.getString("updated_by");
			    
			    // (B) 子の情報を、DBから取得した rs からセット
			    String student_name = rs.getString("student_name");
			    String class_id = rs.getString("class_id");
			    String email = rs.getString("email");
			    String phone = rs.getString("phone");
			    String photo_path = rs.getString("photo_path");
			    
			    // (A)と(B) のすべての変数をコンストラクタに格納する
			    StudentBean student = new StudentBean(user_id,password,role,created_at,updated_at,updated_by,
			            student_name,class_id,email,phone,photo_path);
			    student_list.add(student);
			}
			return student_list;
		}catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
}
