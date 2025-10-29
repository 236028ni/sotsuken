package servlet.admin;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.StudentDAO;
import dao.TeacherDAO;
import model.AdminBean;

/**
 * Servlet implementation class Account_delete_Servlet
 */
@WebServlet("/Account_delete_Servlet")
public class Account_delete_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Account_delete_Servlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		
		//jspから送信された管理者情報を受け取る
		String in_admin_id = request.getParameter("admin_id");
		String in_admin_pw = request.getParameter("admin_pw");
		
		//削除対象の情報
		String del_student_id = request.getParameter("del_student_id");
		String del_teacher_id = request.getParameter("del_teacher_id");
		
		//AdminBeanの情報を持ってくる
		AdminBean admin = (session != null) ? (AdminBean)session.getAttribute("admin") : null;
		
		//管理者情報の検証
		boolean is_admin = false;
		if (admin != null && 
            admin.getUser_id().equals(in_admin_id) && 
            admin.getPassword().equals(in_admin_pw)) {
            
            is_admin= true;
        }
		
		//検証結果によって分岐
		if(is_admin) {
			//削除対象によって処理を分岐
			if(del_student_id != null) {
				//子クラスから先に追加する
				StudentDAO sdao = new StudentDAO();
			}else if(del_teacher_id != null) {
				//同様に子クラスから先に追加する
				TeacherDAO tdao = new TeacherDAO();
			}
		}else {
			// --- 管理者認証NG ---
            // エラーメッセージをリクエストスコープにセット
            request.setAttribute("admin_error", "管理者IDまたはパスワードが正しくありません。");
            
            // 6. 元の削除ページに「フォワード」する (リダイレクトではない！)
            // (JSPのファイル名を指定)
            request.getRequestDispatcher("/WEB-INF/jsp/admin/Account_delete.jsp").forward(request, response);
		}
	}

}
