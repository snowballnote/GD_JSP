package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.GuestBoardDao;

import java.io.IOException;

import dto.GuestBoard;

@WebServlet("/addController")
public class AddController extends HttpServlet {
	// 글입력 폼
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/view/add.jsp").forward(request, response);
	}

	// 글입력 액션
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginMember") == null){
			// 로그인 Controller를 리다이렉트
			response.sendRedirect(request.getContextPath()+"/login");
		}
		
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		GuestBoard gb = new GuestBoard();
		gb.setTitle(title.trim());
		gb.setContent(content.trim());
		gb.setWriter(loginMember.getWriter());
		
		GuestBoardDao dao = new GuestBoardDao();
		
	}

}
