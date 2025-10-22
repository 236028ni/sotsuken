package filter;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class AuthFilter
 */
@WebFilter({"/teacher/*", "/student/*", "/admin/*"})
public class AuthFilter extends HttpFilter implements Filter {
    private static final Map<String,String> permissionMap = new HashMap<>();
    static {
        //「＃」にはチェックを通すためのURLパターンを記載
        //二つ目の「" "」には許可するロールを記載
        permissionMap.put("/teacher/","teacher");//講師ページにはteacherロールが必要
        permissionMap.put("/student","student");//学生ページにはstudentロールが必要
        permissionMap.put("/admin/","admin");//管理者ページにはadminロールが必要
    }
    /**
     * @see HttpFilter#HttpFilter()
     */
    public AuthFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see Filter#destroy()
     */
    @Override
    public void destroy() {
        // TODO Auto-generated method stub
    }
    /**
     * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
     */
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        //1.ログイン状況の確認
        boolean isLogin = (session != null && session.getAttribute("loginUser") != null);
        if(! isLogin) {
            //未ログインの場合
            String request_URI = httpRequest.getRequestURI();
            String query_String = httpRequest.getQueryString();
            if(query_String != null) {
                request_URI += "?" + query_String;
            }
            session = httpRequest.getSession(true);//新しくセッションを作成
            session.setAttribute("original_URL", request_URI);
            
            //ログインページへリダイレクト
            httpResponse.sendRedirect(httpRequest.getContextPath()+"/Login.jsp");
            return;//処理を中断
        }
        
        //2.ログイン済みの場合・権限チェック
        //セッションからユーザ情報（ロール等）を取得
        String user_role = (String)session.getAttribute("user_role");
        String request_path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        
        boolean has_permission = false;
        if(user_role != null) {
        	//すべてのURLをチェック
        	for(Map.Entry<String, String> entry : permissionMap.entrySet()) {
        		if(request_path.startsWith(entry.getKey())) {
        			//必要なロールを持っているか確認
        			if(user_role.equals(entry.getValue())) {
        				has_permission = true;
        				break;
        			}
        		}
        	}
        	//マップにないURLは、ログインしていれば誰でもアクセス可能とする場合
        	if(!permissionMap.keySet().stream().anyMatch(request_path::startsWith)) {
        		has_permission = true;
        	}
        }
        if(has_permission) {
        	//権限がある場合→本来の処理を続行
        	chain.doFilter(request, response);
        }else {
        	//権限がない場合→エラー画面へフォワード
        	request.setAttribute("error_msg", "このページへのアクセス権限がありません<br>ログイン画面に戻ります");
        	httpRequest.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    /**
     * @see Filter#init(FilterConfig)
     */
    @Override
    public void init(FilterConfig fConfig) throws ServletException {
        // TODO Auto-generated method stub
    }
    

}