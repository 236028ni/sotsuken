package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.TeacherBean;
import model.UserBean;

public class TeacherDAO extends DAOparam{
	static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
	public List<TeacherBean> search_by_id_like(String in_teacher_id) {
		List<TeacherBean> result_list = new ArrayList<>();
		try(Connection conn = DriverManager.getConnection(JDBC_URL,DB_USER,DB_PASS)){
			String sql = "select u.user_id,u.password,u.role,u.created_at,u.updated_at,u.updated_by, "
					+ "t.teacher_name,t.email,t.phone "
					+ "from users  u join teachers t on u.user_id = t.teacher_id "
					+ "where u.user_id like ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, "%"+in_teacher_id+"%");
			
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
			    String teacher_name = rs.getString("teacher_name");
			    String email = rs.getString("email");
			    String phone = rs.getString("phone");
			    
			    // (A)と(B) のすべての変数をコンストラクタに格納する
			    TeacherBean teacher = new TeacherBean(user_id,password,role,created_at,updated_at,updated_by,
			            teacher_name,email,phone);
			    result_list.add(teacher);
			    //すべてが詰まった「完全な teacherBean」を返す
			}
			return result_list;
		}catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
public TeacherBean search_by_id(UserBean user) {
		
		try(Connection conn = DriverManager.getConnection(JDBC_URL,DB_USER,DB_PASS)){
			String sql = "select u.user_id,u.password,u.role,u.created_at,u.updated_at,u.updated_by, "
					+ "t.teacher_name,t.email,t.phone "
					+ "from users  u join teachers t on u.user_id = t.teacher_id "
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
			    String teacher_name = rs.getString("teacher_name");
			    String email = rs.getString("email");
			    String phone = rs.getString("phone");
			    
			    // (A)と(B) のすべての変数をコンストラクタに格納する
			    TeacherBean teacher = new TeacherBean(user_id,password,role,created_at,updated_at,updated_by,
			            teacher_name,email,phone);
			    
			    //すべてが詰まった「完全な teacherBean」を返す
			    return teacher;
			    
			}else {
			    return null;
			}
		}catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	public List<TeacherBean> findall() {
		List<TeacherBean>teacher_list = new ArrayList<>();
		try(Connection conn = DriverManager.getConnection(JDBC_URL,DB_USER,DB_PASS)){
			String sql = "select u.user_id,u.password,u.role,u.created_at,u.updated_at,u.updated_by, "
					+ "t.teacher_name,t.email,t.phone "
					+ "from users  u join teachers t on u.user_id = t.teacher_id ";
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
			    String teacher_name = rs.getString("teacher_name");
			    String email = rs.getString("email");
			    String phone = rs.getString("phone");
			    
			    // (A)と(B) のすべての変数をコンストラクタに格納する
			    TeacherBean teacher = new TeacherBean(user_id,password,role,created_at,updated_at,updated_by,
			            teacher_name,email,phone);
			    
			    //すべてが詰まった「完全な teacherBean」を返す
			    teacher_list.add(teacher);
			    
			}
			return teacher_list;
		}catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
}
