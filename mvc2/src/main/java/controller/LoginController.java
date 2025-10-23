package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.MemberDao;

import dto.Member;

import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
	// loginForm
	// C - V 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/view/login.jsp").forward(request, response);
	}
	
	//loginAction
	// C - M
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		Member paramMember = new Member();
		paramMember.setId(id);
		paramMember.setPw(pw);
		
		// 인증 시도
		MemberDao memberDao = new MemberDao();
		try {
			Member loginMember = memberDao.login(paramMember);
			
			if(loginMember == null) {
				// 로그인 실패
				System.out.println("로그인 실패");
				response.sendRedirect(request.getContextPath()+"/login");
			}else { // 로그인 성공
				request.getSession().setAttribute("loginMember", loginMember);
				response.sendRedirect(request.getContextPath()+"/listController");
			}
		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect(request.getContextPath() + "/login");
		}
	}
}
