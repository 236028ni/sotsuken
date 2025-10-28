package servlet.adminredirect;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.UserBean;

/**
 * Servlet implementation class Redirect_Account_list_Servlet
 */
@WebServlet("/Redirect_Student_list_Servlet")
public class Redirect_Student_list_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Redirect_Student_list_Servlet() {
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
	    request.getRequestDispatcher("/WEB-INF/jsp/admin/Student_list2.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getSession().removeAttribute("result_list");
		request.getSession().removeAttribute("in_student_id");
		request.getSession().removeAttribute("error_msg");
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin/Student_list2.jsp");
		dispatcher.forward(request, response);
	}

}
