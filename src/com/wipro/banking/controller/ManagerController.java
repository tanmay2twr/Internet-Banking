package com.wipro.banking.controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.wipro.banking.bean.ManagerBean;
import com.wipro.banking.bean.UserDetails;
import com.wipro.banking.service.ManagerService;

public class ManagerController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String trigerFrom = req.getParameter("bankingButton");
		PrintWriter out = resp.getWriter();

		if (trigerFrom.equals("ManagerLogin")) {
			int result = 0;
			int id = Integer.parseInt(req.getParameter("userID"));
			String pass = req.getParameter("pass");

			ManagerBean bean = new ManagerBean();
			bean.setUserID(id);
			bean.setPassword(pass);

			ManagerService service = new ManagerService();
			result = service.ManagerLogin(bean);

			if (result != 0) {
				HttpSession session = req.getSession();
				session.setAttribute("userID", id);

				resp.sendRedirect("ManagerPortal.jsp");
			} else {
				out.print("Invalid Credentials");
			}

		} else if (trigerFrom.equals("ManagerRequests")) {
			resp.setContentType("application/json");
			HttpSession session = req.getSession();
			int id=Integer.parseInt(session.getAttribute("userID").toString());
			String status = req.getParameter("status");
			ManagerService service=new ManagerService();
			String ifscCode=service.getifsc(id);
			List<Map<String,Object>> demolist = service.requests(ifscCode,status);
			String jsonData = new Gson().toJson(demolist);
			out.println(jsonData);
		} else if (trigerFrom.equals("UpdateRequests")) {
			ManagerService service = new ManagerService();
			int reqDa = Integer.parseInt(req.getParameter("reqData").toString());
			int status = Integer.parseInt(req.getParameter("status").toString());
			int result = service.updateRequestStatus(reqDa,status);
			out.println(result);
		} else if (trigerFrom.equals("ManagerDetail")) {
			ManagerService service = new ManagerService();
			HttpSession session = req.getSession(false);
			String object = req.getSession(false).getAttribute("userID").toString();
			UserDetails details = service.selectManagerData(Integer.parseInt(object));
			resp.setContentType("application/json");
			String demo = new Gson().toJson(details);
			out.println(demo);
		} else if (trigerFrom.equals("UpdateManagerDetail")) {
			UserDetails beanAdmin = new UserDetails();
			beanAdmin.setUserID(Integer.parseInt(req.getParameter("USER_ID")));
			beanAdmin.setMobile_No(req.getParameter("MOBILE_NO"));
			beanAdmin.setMailID(req.getParameter("MAIL_ID"));
			beanAdmin.setStreetAdd(req.getParameter("STREET_ADD"));
			beanAdmin.setCity(req.getParameter("CITY"));
			beanAdmin.setState(req.getParameter("STATE"));
			ManagerService bsMAnager = new ManagerService();
			int result = bsMAnager.updateManager(beanAdmin);
			resp.setContentType("text/html");
			out.println(Integer.toString(result));
		} 
		
	}
}
