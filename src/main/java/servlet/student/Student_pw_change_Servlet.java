package servlet.student;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.StudentDAO;
import dao.UserDAO;
import model.StudentBean;
import model.UserBean;

/**
 * Servlet implementation class Student_pw_change_Servlet
 */
@WebServlet("/Student_pw_change_Servlet")
public class Student_pw_change_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Student_pw_change_Servlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // フィルターを通過しているので、ログイン済みを前提とする
        HttpSession session = request.getSession(false);
        UserBean user = (UserBean) session.getAttribute("user"); // ログイン中のユーザー（誰か）
        

        // 1. 【ここが重要】DAOを呼び出し、DBから現在の情報を取得する (SELECT)
        //    フォームに変更前の情報を表示するため。
        StudentDAO sdao = new StudentDAO();
        // セッションのUserBeanではなく、DBから最新のUserBeanを取得し直す
        StudentBean new_student = sdao.search_by_id(user); 
        
        // 2. 取得した「DBの最新情報」をJSPへ渡す
        request.setAttribute("student", new_student); 
        
        // 3. 「情報変更フォーム」のJSPへフォワード
        request.getRequestDispatcher("/WEB-INF/jsp/student/Student_pw_change.jsp").forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		String current_password = request.getParameter("current_password");
		String new_password = request.getParameter("new_password");
		String id = request.getParameter("user_id");
		
		UserBean user = (UserBean) session.getAttribute("user");
		
		UserDAO udao = new UserDAO();
		StudentDAO sdao = new StudentDAO();
		
		StudentBean student = sdao.search_by_id(user);
		String user_password = student.getPassword();
		
		boolean is_change = udao.change_password(new_password, id);
		
		if(!current_password.equals(user_password)) {
			//現在のPW違うときの処理
			session.setAttribute("error_msg","PW間違えてるようじゃだめかー");
			request.getRequestDispatcher("/WEB-INF/jsp/student/Student_pw_change.jsp").forward(request, response);
		}else {
			//現在のPWあってるとき
			if(is_change) {
				//正常に変更が完了したときは完了画面に遷移する
				//ここだけうまくいってない
				request.getRequestDispatcher("/WEB-INF/jsp/student/Student_pw_change_complete.jsp").forward(request, response);
			}else {
				//変更が異常終了した時は専用のエラーページ画面に遷移する
				session.setAttribute("error_msg", "予期せぬエラーが発生しました");
				request.getRequestDispatcher("/WEB-INF/jsp/Error.jsp").forward(request, response);
			}
		}
	}

}
