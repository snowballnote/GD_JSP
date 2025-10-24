package mvc3.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ex2Controller")
public class Ex2Controller extends HttpServlet {
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("x", 10);
		request.setAttribute("y", 3);
		
		request.setAttribute("n1", null); // 진짜 null
		request.setAttribute("n2", ""); // 공백
		request.getRequestDispatcher("/WEB-INF/view/ex2.jsp").forward(request, response);
	}
}
