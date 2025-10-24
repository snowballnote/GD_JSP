package mvc3.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mvc3.dto.Member;

import java.io.IOException;

import java.util.ArrayList;
import java.util.List;


@WebServlet("/Ex3Controller")
public class Ex3Controller extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("gender", "여");
		request.setAttribute("score", 85);
		
		List<String> list = new ArrayList<>();
		list.add("루피");
		list.add("조로");
		list.add("상디");
		list.add("나미");
		request.setAttribute("list", list);
		
		List<Member> memberList = new ArrayList<>();
		memberList.add(new Member("admin", "1234"));
		memberList.add(new Member("guest1", null));
		memberList.add(new Member("guest2", ""));
		memberList.add(new Member("user", "1234"));
		request.setAttribute("memberList", memberList);
		
		request.getRequestDispatcher("/WEB-INF/view/ex3.jsp").forward(request, response);
	}
}