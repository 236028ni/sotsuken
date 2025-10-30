package servlet.adminredirect;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.StudentDAO;
import dao.TeacherDAO;
import dao.UserDAO;
import model.UserBean;

/**
 * Servlet implementation class Redirect_Account_delete_Servlet
 */
@WebServlet("/Redirect_Account_delete_Servlet")
public class Redirect_Account_delete_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Redirect_Account_delete_Servlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// フィルターを通過したので、ログイン済みであることを前提に処理を開始する
	    HttpSession session = request.getSession(false);
	    
	    // 1. セッションからログイン時に保存したBeanを取得する
	    //    (DBへの問い合わせは行わない)
	    UserBean user = (UserBean) session.getAttribute("user");
	    
	    // 2. 取得したBeanをJSPへ渡す
	    //    (JSPが ${student.name} のように参照できるようにする)
	    request.setAttribute("user", user); 
	    
	    // 3. JSPへフォワード
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		session.removeAttribute("student");
		session.removeAttribute("teacher");
		UserDAO udao = new UserDAO();
		//先に学生から取得を試行（デフォルトを学生とする）
		String del_id = request.getParameter("del_student_id");
		if(del_id != null) {
			//学生がnullじゃない（削除したいのが学生）ならそのまま実行
			StudentDAO sdao = new StudentDAO();
			UserBean user = udao.findall(del_id);
			session.setAttribute("student", sdao.search_by_id(user));
		}else {
			//学生がnull（削除したいのが講師）なら講師のIDを取得して実行
			del_id = request.getParameter("del_teacher_id");
			TeacherDAO tdao = new TeacherDAO();
			UserBean user = udao.findall(del_id);
			session.setAttribute("teacher", tdao.search_by_id(user));
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin/Account_delete.jsp");
		dispatcher.forward(request, response);
	}

}
