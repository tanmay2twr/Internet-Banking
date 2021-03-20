package com.wipro.banking.logout;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Logout extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
		String trigerFrom=req.getParameter("bankingButton");
		PrintWriter out = res.getWriter();
		
		if(trigerFrom.equals("Profile")) {
			res.sendRedirect("AdminMyData.jsp");
		} else if(trigerFrom.equals("LogOut")) {
			HttpSession session = req.getSession();
			session.removeAttribute("userID");
			res.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
			res.setHeader("Pragma", "no-cache");
			res.setHeader("Expires", "0");
			if (session.getAttribute("userID") == null)
				res.sendRedirect("LandingPage.jsp");
		}
	}
}
