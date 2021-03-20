package com.wipro.banking.controller;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.wipro.banking.bean.AdminBean;
import com.wipro.banking.bean.ManagerBean;
import com.wipro.banking.bean.UserDetails;
import com.wipro.banking.service.AdminService;

public class AdminController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String trigerFrom=req.getParameter("bankingButton");
		PrintWriter out=resp.getWriter();
		
		if(trigerFrom.equals("AdminLogin"))
		{
			int result=0;
			int id=Integer.parseInt(req.getParameter("userID"));       
			String pass=req.getParameter("pass");
			
			AdminBean adminBean=new AdminBean();
			adminBean.setUser_ID(id);adminBean.setPassword(pass);
			
			AdminService service=new AdminService();
			result=service.adminLogin(adminBean);
			
			if(result!=0)
			{
				HttpSession session=req.getSession();
				session.setAttribute("userID", id);
				
				resp.sendRedirect("AdminControl.jsp");
			}else
			{
				out.print("Invalid Credentials");
			}
			
			
		} else if (trigerFrom.equals("AdminDetail")) {
			AdminService service = new AdminService();
			HttpSession session = req.getSession(false);
			String object = req.getSession(false).getAttribute("userID").toString();
			UserDetails details = service.selectAdminData(Integer.parseInt(object));
			resp.setContentType("application/json");
			String demo = new Gson().toJson(details);
			out.println(demo);
		} else if (trigerFrom.equals("UpdateAdminDetail")) {
			UserDetails beanAdmin = new UserDetails();
			beanAdmin.setUserID(Integer.parseInt(req.getParameter("USER_ID")));
			beanAdmin.setMobile_No(req.getParameter("MOBILE_NO"));
			beanAdmin.setMailID(req.getParameter("MAIL_ID"));
			beanAdmin.setStreetAdd(req.getParameter("STREET_ADD"));
			beanAdmin.setCity(req.getParameter("CITY"));
			beanAdmin.setState(req.getParameter("STATE"));
			AdminService bsAdm = new AdminService();
			int result = bsAdm.updateAdmin(beanAdmin);
			resp.setContentType("text/html");
			out.println(Integer.toString(result));
		}  else if(trigerFrom.equals("AddManager")) {
			int result=0;
			
			ManagerBean mbean = new ManagerBean();
			mbean.setPassword("C745Sad*&^&");
			String dsfcdfg = req.getParameter("name");
			System.out.print(dsfcdfg);
			UserDetails details=new UserDetails();
			details.setName(req.getParameter("name"));
			details.setMobile_No(req.getParameter("mobile"));
			details.setGender(req.getParameter("gender"));
			details.setMailID(req.getParameter("emailID"));
			details.setStreetAdd(req.getParameter("streetAdd"));
			details.setCity(req.getParameter("city"));
			details.setState(req.getParameter("state"));
			details.setAadhaar(req.getParameter("aadhaar"));
			details.setPAN(req.getParameter("PAN"));
			AdminService service=new AdminService();
			result=service.addmanager(mbean,details);
			if(result!=0)
			{
				out.println("Manager Added");
			}
			else {
				
			}
			
		}else if(trigerFrom.equals("ManagerDelete")) {
			AdminService service = new AdminService();
			int details;
			try {
				details = service.deleteManager(Integer.parseInt(req.getParameter("userID")));
				if(details!=0)
				{
					out.println("Manager Deleted");
				}
				else
				{
					
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		
		
		}
		 else if(trigerFrom.equals("ManagerModify")) {
				int result=0;
				
				ManagerBean mbean = new ManagerBean();
				
				//String dsfcdfg = req.getParameter("name");
				//System.out.print(dsfcdfg);
				UserDetails details=new UserDetails();
				details.setUserID(Integer.parseInt(req.getParameter("userID")));
				details.setName(req.getParameter("name"));
				details.setMobile_No(req.getParameter("mobile"));
				details.setGender(req.getParameter("gender"));
				details.setMailID(req.getParameter("emailID"));
				details.setStreetAdd(req.getParameter("streetAdd"));
				details.setCity(req.getParameter("city"));
				details.setState(req.getParameter("state"));
				details.setAadhaar(req.getParameter("aadhaar"));
				details.setPAN(req.getParameter("PAN"));
				AdminService service=new AdminService();
				try {
					result=service.modifymanager(details);
				} catch (Exception e) {
					e.printStackTrace();
				}
				if(result!=0)
				{
					out.println("Manager Modified");
				}
				else
				{
					
				}
			} else if (trigerFrom.equals("GetManagerDetail")) {
				AdminService service = new AdminService();
				resp.setContentType("application/json");
				Map<String, Object> tempData = service.managerBranchDetail();
				String demo = new Gson().toJson(tempData);
				out.print(demo);
				
			} else if(trigerFrom.equals("GetConfirmDeleteUpdate")) {
				AdminService service = new AdminService();
				if(Integer.parseInt(req.getParameter("udstatus")) == 1) {
					String data = req.getParameter("updateDeleteVal").toString();
					int val = service.updateDelete(data, 1);
					out.print(Integer.toString(val));
				} else {
					String data = req.getParameter("updateDeleteVal").toString();
					int val = service.updateDelete(data, 0);
					out.print(Integer.toString(val));
				}
			} else if(trigerFrom.equals("AddManagerData")) {
				AdminService service = new AdminService();
				String tempData = req.getParameter("managerData");
				int result = service.addManager(tempData);
				out.print(result);
			}

	}
}
