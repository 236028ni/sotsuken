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
	public List<StudentBean> search_by_id_like(String in_student_id) {
		List<StudentBean>result_list = new ArrayList<>();
		try(Connection conn = DriverManager.getConnection(JDBC_URL,DB_USER,DB_PASS)){
			String sql = "select u.user_id,u.password,u.role,u.created_at,u.updated_at,u.updated_by, "
					+ "s.student_name,s.class_id,s.email,s.phone,s.photo_path "
					+ "from users  u join students s on u.user_id = s.student_id "
					+ "where u.user_id like ?";
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, "%"+in_student_id+"%");
			
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
			    result_list.add(student);
			    //すべてが詰まった「完全な studentBean」を返す
			    
			}
			return result_list;
		}catch (SQLException e) {
			return null;
		}
	}
	public List<StudentBean> search_by_name_like(String in_student_name) {
	    List<StudentBean> result_list = new ArrayList<>();
	    // JDBC_URL, DB_USER, DB_PASSは適切に定義されているものとします
	    try(Connection conn = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASS)){
	        
	        // ▼ 修正点 ▼
	        // DBに保存されている氏名の「半角スペース(' ')」と「全角スペース('　')」の両方を除去する
	        String sql = "select u.user_id, u.password, u.role, u.created_at, u.updated_at, u.updated_by, "
	                + "s.student_name, s.class_id, s.email, s.phone, s.photo_path "
	                + "from users u join students s on u.user_id = s.student_id "
	                + "where REPLACE(REPLACE(s.student_name, ' ', ''), '　', '') like ?"; // REPLACEをネスト
	        
	        PreparedStatement pStmt = conn.prepareStatement(sql);
	        
	        // 入力された検索語からも半角・全角スペースを除去（この処理は元のコードのままでOK）
	        String search_name = in_student_name.replace(" ", "").replace("　", "");
	        
	        pStmt.setString(1, "%" + search_name + "%");
	        
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
	            
	            // (A)と(B) のすべての変数をコンストラクtaに格納する
	            StudentBean student = new StudentBean(user_id, password, role, created_at, updated_at, updated_by,
	                    student_name, class_id, email, phone, photo_path);
	            result_list.add(student);
	        }
	        return result_list;
	    } catch (SQLException e) {
	        e.printStackTrace(); // エラーハンドリング
	        return null; // または空のリストを返す ( return result_list; )
	    }
	}
	public StudentBean search_by_id(UserBean user) {
		try(Connection conn = DriverManager.getConnection(JDBC_URL,DB_USER,DB_PASS)){
			String sql = "select u.user_id,u.password,u.role,u.created_at,u.updated_at,u.updated_by ,"
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
	public String search_name_by_id(String student_id) {
		try(Connection conn = DriverManager.getConnection(JDBC_URL,DB_USER,DB_PASS)) {
			String sql = "select student_name from students where student_id = ?";
			String student_name = null;
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, student_id);
			
			ResultSet rs = pStmt.executeQuery();
			if(rs.next()) {
				student_name = rs.getString("student_name");
			}
			return student_name;
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
			return null;
		}
		
	}
}
