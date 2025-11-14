package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import model.RequestBean;

public class RequestDAO extends DAOparam{
	static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
	public boolean add_request(RequestBean req) {
		try(Connection conn = DriverManager.getConnection(JDBC_URL,DB_USER,DB_PASS)){
			String sql = "INSERT INTO Requests(student_id,timing,request_date,period,status,reason,attachment_path,updated_by) VALUES(?,?,?,?,?,?,?,?)";
			
			PreparedStatement pStmt = conn.prepareStatement(sql);
			pStmt.setString(1, req.getStudent_id());//対象学籍番号
			pStmt.setString(2, req.getTiming());//事前及び事後判定
			pStmt.setString(3, req.getRequest_date());//申請対象日時
			pStmt.setInt(4, req.getPeriod());//対象時限
			pStmt.setString(5, req.getStatus());//申請区分（欠席・公欠等）
			pStmt.setString(6, req.getReason());//申請理由
			pStmt.setString(7, req.getAttachment_path());//画像のパス名（サーブレットで指定）
			pStmt.setString(8, req.getUpdated_by());//変更者（サーブレットで当該学生を指定）
			
			int result = pStmt.executeUpdate();
			if(result != 1) {
				return false;
			}
		}catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
}
