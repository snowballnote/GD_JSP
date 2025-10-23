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

@WebFilter("/one/*")
public class AfterLoginOneFilter extends HttpFilter implements Filter {
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// 로그인 되어있고 grade > 0
		if(request instanceof HttpServletRequest) {
			HttpServletRequest req = (HttpServletRequest)request;
			HttpSession session = req.getSession();
			if(session.getAttribute("loginMember") == null) {
				if(response instanceof HttpServletRequest) {
					((HttpServletResponse)response).sendRedirect(req.getContextPath()+"/zero/loginForm.jsp");
				}
			}
			System.out.print(req.getRequestURI());
			System.out.println("--------- AfterLoginOneFilter 선행필터 작동");
		}
		chain.doFilter(request, response);
	}
}
