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
@WebFilter("/AuthFilter")
public class AuthFilter extends HttpFilter implements Filter {
    private static final Map<String,String> permissionMap = new HashMap<>();
    static {
        //「＃」にはチェックを通すためのURLパターンを記載
        //二つ目の「" "」には許可するロールを記載
        permissionMap.put("#","teacher");
        permissionMap.put("#","student");
        permissionMap.put("#","admin");
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
            String requestURI = httpRequest.getRequestURI();
            String queryString = httpRequest.getQueryString();
            if(queryString != null) {
                requestURI += "?" + queryString;
            }
            session = httpRequest.getSession(true);//新しくセッションを作成
            session.setAttribute("originalURL", requestURI);
            
            //ログインページへリダイレクト
            httpResponse.sendRedirect(httpRequest.getContextPath()+"/Login.jsp");
            return;//処理を中断
        }
        
        //2.ログイン済みの場合・権限チェック
        //セッションからユーザ情報（ロール等）を取得
        String userRole = (String)session.getAttribute("userRole");
        String requestPath = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
    }

    /**
     * @see Filter#init(FilterConfig)
     */
    public void init(FilterConfig fConfig) throws ServletException {
        // TODO Auto-generated method stub
    }

}