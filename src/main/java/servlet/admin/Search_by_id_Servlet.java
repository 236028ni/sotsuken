package servlet.admin;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.StudentDAO;
import dao.TeacherDAO;
import model.StudentBean;
import model.TeacherBean;

/**
 * Servlet implementation class Search_by_id_Servlet
 */
@WebServlet("/Search_by_id_Servlet")
public class Search_by_id_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Search_by_id_Servlet() {
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
		HttpSession session = request.getSession();
		String in_student_id = request.getParameter("in_student_id");
		String in_teacher_id = request.getParameter("in_teacher_id");
		if(in_student_id != null) {
			StudentDAO sdao = new StudentDAO();
			List<StudentBean> result_list = sdao.search_by_id_like(in_student_id);
			System.out.println(result_list.size());
			if(result_list.size() == 0) {
				session.setAttribute("error_msg", "該当するデータがありません");
			}else {
				session.removeAttribute("error_msg");
			}
			session.setAttribute("result_list", result_list);
			session.setAttribute("in_student_id", in_student_id);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin/Student_list2.jsp");
			dispatcher.forward(request, response);
			
		}else if(in_teacher_id != null) {
			TeacherDAO tdao = new TeacherDAO();
			List<TeacherBean> result_list = tdao.search_by_id_like(in_teacher_id);
			System.out.println(result_list.size());
			if(result_list.size() == 0) {
				session.setAttribute("error_msg", "該当するデータがありません");
			}else {
				session.removeAttribute("error_msg");
			}
			session.setAttribute("result_list", result_list);
			session.setAttribute("in_teacher_id", in_teacher_id);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin/Teacher_list.jsp");
			dispatcher.forward(request, response);
		}else {
			session.setAttribute("error_msg", "予期せぬエラーが発生しました");
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/Error.jsp");
			dispatcher.forward(request, response);
			
		}
	}

}
