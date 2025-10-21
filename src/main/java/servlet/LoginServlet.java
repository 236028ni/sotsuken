package servlet;

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
import model.StudentBean;
import model.TeacherBean;
import model.UserBean;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getSession().setAttribute("loginErrorMsg", "不正なアクセスです<br>再ログインしてください");
        response.sendRedirect("Login.jsp");
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
    	String user_id = request.getParameter("user_id");//入力されたIDを取得
        String password = request.getParameter("password");//入力されたPWを取得
        
        UserDAO udao = new UserDAO();
        StudentDAO sdao = new StudentDAO();
        TeacherDAO tdao = new TeacherDAO();
        
        UserBean user = udao.certification(user_id,password);
        
        System.out.println(user);
        session.removeAttribute("login_error_msg");
        if(user==null) {
        	//すべての情報がnull（＝ID,PWの組が存在しない）場合、ログイン画面に戻る
        	session.setAttribute("login_error_msg", "IDもしくはPWが間違っています");
        	RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
        	dispatcher.forward(request, response);
        }else {
        	
        	String role = user.getRole();
        	if(role.equals("student")) {
            	//studentの情報をセッションスコープに格納して次の画面へ
            	StudentBean student = sdao.findall(user);
            	session.setAttribute("student", student);
            }else if(role.equals("teacher")) {
            	//teacherの情報をセッションスコープに格納して次の画面へ
            	TeacherBean teacher = tdao.findall(user);
            	session.setAttribute("teacher", teacher);
            	RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/teacher/Teacher_menu.jsp");
            	dispatcher.forward(request, response);
            }else{
            	//userの情報をadminに置き換えてセッションスコープに格納
            	session.setAttribute("admin", user);
            	RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/admin/Admin_menu.jsp");
            	dispatcher.forward(request, response);
            }
        }
        
        
    }

}