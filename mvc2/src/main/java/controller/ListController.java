package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.GuestBoardDao;

import java.io.IOException;
import java.util.List;

import dto.GuestBoard;

/*
 * M : POJO
 * V : JSP
 * C : Servlet
 * 
 * C -> M 통신, C -> V 통신, M - V : X, 반대쪽 화살표로도 : X
 */
@WebServlet("/listView")
public class ListController extends HttpServlet {
	// C - M - V
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginMember") == null){
			// 로그인 Controller를 리다이렉트
			response.sendRedirect(request.getContextPath()+"/login");
		}
		int rowPerPage = 10;
		
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		int startRow = (currentPage-1) * rowPerPage;
		
		GuestBoardDao guestBoardDao = new GuestBoardDao();
		try {
			List<GuestBoard> list = guestBoardDao.selectList(startRow, rowPerPage);
			int count = guestBoardDao.selectCount();
			int lastPage = count%rowPerPage==0 ? count/rowPerPage : (count/rowPerPage)+1;
			
			request.setAttribute("list", list);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("lastPage", lastPage);
			
			request.getRequestDispatcher("/WEB-INF/view/listView.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}