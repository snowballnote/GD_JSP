package filter;

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

import java.io.IOException;

@WebFilter("/zero/*")
public class BeforeLoginFilter extends HttpFilter implements Filter {
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException{
		// 선 필터
		// session 분기
		System.out.println("--------- BeforeLoginFilter 선행필터 작동");
		if(request instanceof HttpServletRequest) {
			HttpServletRequest req = ((HttpServletRequest)request);
			HttpSession session = ((HttpServletRequest)request).getSession();
			// 로그인 되어 있다면 다른 곳으로 분기
			if(session.getAttribute("loginMember") != null) { // 존재한다면 로그인 되어있는 상태
				if(response instanceof HttpServletRequest) {
					((HttpServletResponse)response).sendRedirect(req.getContextPath()+"/one/memberHome.jsp");
				}
			}
			System.out.print(req.getRequestURI());
			System.out.println("--------- BeforeLoginFilter 선행필터 작동");
		}	
		chain.doFilter(request, response);
		// 후 필터
	}
}
