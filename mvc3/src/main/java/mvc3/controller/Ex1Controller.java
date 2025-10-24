package mvc3.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mvc3.dto.Member;

import java.io.IOException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/ex1Controller")
public class Ex1Controller extends HttpServlet {
	// GET
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String p1 = request.getParameter("p1");
		System.out.println(p1); //777
		String[] p2 = request.getParameterValues("p2");
		System.out.println(p2[0]+", " + p2[1]); //x, y
		
		request.getSession().setAttribute("name", "goodee");
		request.setAttribute("age", 20);
		
		Map<String, Object> m = new HashMap<>();
		m.put("mapName", "zoro");
		m.put("mapAge", 22);
		request.setAttribute("myMap", m);
		
		List<String> fruits = new ArrayList<>();
		fruits.add("apple");
		fruits.add("banana");
		fruits.add("cherry");
		request.setAttribute("fruits", fruits);
		
		Member member = new Member();
		member.setId("guest");
		member.setPw("1234");
		request.setAttribute("member", member);
		
		request.getRequestDispatcher("/WEB-INF/view/ex1.jsp").forward(request, response);
	}
}