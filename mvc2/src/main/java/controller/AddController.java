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
		String writer = request.getParameter("writer");
		
		GuestBoard gb = new GuestBoard();
		gb.setTitle(title);
		gb.setContent(content);
		gb.setWriter(writer);
		
		GuestBoardDao dao = new GuestBoardDao();
		try {
            int row = dao.insertGuestBoard(gb);

            if (row == 1) {
                // 성공 시 목록으로 이동
                response.sendRedirect(request.getContextPath() + "/listView");
            } else {
                // 실패 시 다시 글쓰기 폼으로 이동
                response.sendRedirect(request.getContextPath() + "/addController");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
}