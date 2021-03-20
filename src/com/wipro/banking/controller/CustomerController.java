package com.wipro.banking.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.wipro.banking.bean.BeneficaryDetailBean;
import com.wipro.banking.bean.CustomerAccountBean;
import com.wipro.banking.bean.DebitCardBean;
import com.wipro.banking.bean.RequestsBean;
import com.wipro.banking.bean.UserDetails;
import com.wipro.banking.bean.statementBean;
import com.wipro.banking.service.CustomerService;

public class CustomerController extends HttpServlet {

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String trigerFrom = req.getParameter("bankingButton");
		PrintWriter out = resp.getWriter();

		if (trigerFrom.equals("CustomerLogin")) {
			String id = req.getParameter("userID").trim();
			String pass = req.getParameter("pass");

			CustomerAccountBean customerBean = new CustomerAccountBean();
			customerBean.setCustomize_User_name(id);
			customerBean.setProfile_password(pass);

			CustomerService service = new CustomerService();
			CustomerAccountBean result = service.customerLogin(customerBean);

			if (result.getUser_ID() != 0) {
				HttpSession session = req.getSession();
				session.setAttribute("userID", result.getUser_ID());
				session.setAttribute("account_num", result.getAccount_Num());
				resp.sendRedirect("CustomerPortal.jsp");
			} else {
				out.print("Invalid Credentials");
			}

		} else if (trigerFrom.equals("Statement")) {
			String acc_num = req.getSession(false).getAttribute("account_num").toString();
			CustomerService service = new CustomerService();
			List<statementBean> list = service.statement(acc_num);
			resp.setContentType("application/json");
			String jsonData = new Gson().toJson(list);
			out.println(jsonData);

		} else if (trigerFrom.equals("AddBenificiary")) {
			int result = 0;
			String bank = req.getParameter("bank");
			String id = req.getSession(false).getAttribute("userID").toString();
			String acc_num = req.getSession(false).getAttribute("account_num").toString();
			BeneficaryDetailBean bean = new BeneficaryDetailBean();
			bean.setBeneficiary_Account(Integer.parseInt(req.getParameter("AccNum")));
			bean.setBeneficiary_name(req.getParameter("name"));
			bean.setIFSC_Code(req.getParameter("ifsc"));
			bean.setUser_ID(id);
			if (acc_num.equals(Integer.toString(bean.getBeneficiary_Account()))) {
				result = 3;
			} else {
				if (bank.equals("Axis Bank")) {
					CustomerService service = new CustomerService();
					result = service.addBeneficiary(bean);

				} else {
					CustomerService service = new CustomerService();
					result = service.otherBenificiary(bean);
				}
			}
			resp.sendRedirect("CustomerAddBeneficiary.jsp?result=" + Integer.toString(result));

		} else if (trigerFrom.equals("selectBenificiary")) {
			String id = req.getSession(false).getAttribute("userID").toString();
			String call = req.getSession(false).getAttribute("call").toString();
			resp.setContentType("application/json");
			CustomerService service = new CustomerService();
			List<BeneficaryDetailBean> list = service.getBeneficiary(id, call);
			String jsonData = new Gson().toJson(list);
			out.println(jsonData);

		} else if (trigerFrom.equals("selectBenificiary1")) {
			String call = req.getSession(false).getAttribute("call").toString();
			if (call.equals("within"))
				resp.sendRedirect("CustomerWithinBeneficiary.jsp");
			else
				resp.sendRedirect("CustomerOtherBeneficiary.jsp");

		} else if (trigerFrom.equals("withinBank")) {
			HttpSession session = req.getSession();
			session.setAttribute("call", "within");
			String id = req.getSession(false).getAttribute("userID").toString();
			CustomerService service = new CustomerService();
			CustomerAccountBean bean = new CustomerAccountBean();
			bean = service.getCustomerDetails(id);
			resp.sendRedirect(
					"TransferWithin.jsp?accountNum=" + bean.getAccount_Num() + "&balance=" + bean.getBalance());

		} else if (trigerFrom.equals("getCustomerDetails")) {
			String id = req.getSession(false).getAttribute("userID").toString();
			CustomerService service = new CustomerService();
			CustomerAccountBean bean = new CustomerAccountBean();
			bean = service.getCustomerDetails(id);
			resp.sendRedirect("TransferWithin.jsp?accountNum=" + bean.getAccount_Num() + "&name="
					+ bean.getCustomize_User_name() + "&ifsc=" + bean.getIFSC_Code());

		} else if (trigerFrom.equals("checkDebitwithin")) {
			int result = 0;
			String id = req.getSession(false).getAttribute("userID").toString();
			Long accNum = Long.parseLong(req.getParameter("accNum"));
			int amount = Integer.parseInt(req.getParameter("amount"));
			String password = req.getParameter("tpassword");
			CustomerService service = new CustomerService();
			result = service.checkDebitwithin(id, accNum, amount, password);
			resp.sendRedirect("TransStatus.jsp?result=" + result);

		} else if (trigerFrom.equals("checkDebitother")) {
			int result = 0;
			String id = req.getSession(false).getAttribute("userID").toString();
			String mode = req.getSession(false).getAttribute("mode").toString();
			Long accNum = Long.parseLong(req.getParameter("accNum"));
			int amount = Integer.parseInt(req.getParameter("amount"));
			String tpassword = req.getParameter("tpassword");
			CustomerService service = new CustomerService();
			result = service.checkDebitother(id, accNum, amount, mode, tpassword);
			resp.sendRedirect("TransStatus.jsp?result=" + result);

		} else if (trigerFrom.equals("otherBankIMPS") || trigerFrom.equals("otherBankNEFT")) {
			HttpSession session = req.getSession();
			session.setAttribute("call", "other");
			int i = trigerFrom.indexOf("IMPS", 8);
			if (i > 0) {
				session.setAttribute("mode", "IMPS");
			} else {
				session.setAttribute("mode", "NEFT");
			}
			String id = req.getSession(false).getAttribute("userID").toString();
			CustomerService service = new CustomerService();
			CustomerAccountBean bean = new CustomerAccountBean();
			bean = service.getCustomerDetails(id);
			resp.sendRedirect(
					"TransferOther.jsp?accountNum=" + bean.getAccount_Num() + "&balance=" + bean.getBalance());

		} else if (trigerFrom.equals("CustomerStatus")) {
			RequestsBean result = new RequestsBean();
			int id = Integer.parseInt(req.getParameter("rid"));

			RequestsBean requestsBean = new RequestsBean();
			requestsBean.setRequestid(id);
			CustomerAccountBean customerAccountBean = new CustomerAccountBean();

			CustomerService service = new CustomerService();
			result = service.customerStatus(id);

			customerAccountBean.setUser_ID(result.getUserid());
			customerAccountBean = service.fetchInternetBanking(result.getUserid());
			try {
				if (result.getStatus().equalsIgnoreCase("rejected")) {

					resp.sendRedirect("CustomerStatus.jsp?result=rejected");

				} else if (result.getStatus().equalsIgnoreCase("pending")) {

					resp.sendRedirect("CustomerStatus.jsp?result=pending");

				} else if (result.getStatus().equalsIgnoreCase("approved")
						&& customerAccountBean.getInternet_bank_status().equalsIgnoreCase("disable")) {
					// enable the status of Internet banking in CustomerAccount table
					resp.sendRedirect("CustomerStatusApproved.jsp?result=" + id);

				} else if (result.getStatus().equalsIgnoreCase("approved")
						&& customerAccountBean.getInternet_bank_status().equalsIgnoreCase("enabled")) {
					resp.sendRedirect("CustomerStatus.jsp?result=approvedenabled");

				} else if (result.getStatus().equalsIgnoreCase("approved")
						&& customerAccountBean.getInternet_bank_status().equalsIgnoreCase("freezed")) {
					resp.sendRedirect("CustomerStatus.jsp?result=approvedfreeze");

				} else if (result.getStatus().equalsIgnoreCase("null")) {
					resp.sendRedirect("CustomerStatus.jsp?result=notfound");

				}
			} catch (NullPointerException e) {
				resp.sendRedirect("CustomerStatus.jsp?result=notfound");
			}

			out.print(result.getStatus() + result.getUserid());

		} else if (trigerFrom.equals("CustomerStatus1")) {

			resp.sendRedirect("CustomerStatus.jsp");

		} else if (trigerFrom.equals("CustomerRegister1")) {

			resp.sendRedirect("CustomerRegister.jsp");

		} else if (trigerFrom.equals("CustomerStatusApproved")) {
			int rid = Integer.parseInt(req.getParameter("rid"));
			long accno = Long.parseLong(req.getParameter("accountnumber"));
			int pin = Integer.parseInt(req.getParameter("pin"));
			int useridtemp;
			long accnotemp;
			String uname = req.getParameter("uname");
			String password = req.getParameter("password");
			String tpassword = req.getParameter("tpassword");
			CustomerService service = new CustomerService();
			RequestsBean requestsBean = new RequestsBean();
			DebitCardBean debitCardBean = new DebitCardBean();
			CustomerAccountBean customerAccountBean = new CustomerAccountBean();
			requestsBean = service.customerStatus(rid);
			useridtemp = requestsBean.getUserid();
			customerAccountBean.setUser_ID(requestsBean.getUserid());
			customerAccountBean.setAccount_Num(service.fetchInternetBanking(useridtemp).getAccount_Num());
			debitCardBean = service.debitDetails(customerAccountBean.getAccount_Num());

			if (pin != debitCardBean.getPin()) {
				resp.sendRedirect("CustomerStatusApproved.jsp?result=failure");
			} else {
				int a = 0;

				a = service.updateCustomerDetails(uname, password, requestsBean.getUserid(), tpassword);

				if (a == 1)
					resp.sendRedirect("CustomerStatusApproved.jsp?result=success");
				else
					resp.sendRedirect("CustomerStatusApproved.jsp?result=issue");

			}

		} else if (trigerFrom.equals("CustomerRegister")) {
			DebitCardBean result = new DebitCardBean();
			RequestsBean bean = new RequestsBean();
			CustomerAccountBean result1 = new CustomerAccountBean();

			int acc_no = Integer.parseInt(req.getParameter("AccNo"));
			long CardNo = Long.parseLong(req.getParameter("DebitNo"));
			int Pin = Integer.parseInt(req.getParameter("PinNo"));
			DebitCardBean debitcardbean = new DebitCardBean();
			debitcardbean.setAccount_NUm(acc_no);
			CustomerService service = new CustomerService();
			result = service.Register(acc_no);
			if (CardNo == result.getCard_No() && Pin == result.getPin()) {
				bean = service.CustomerAcc(acc_no);
				if (bean.getRequestid() != 0)
					resp.sendRedirect("CustomerRegister.jsp?result=repeat");
				else {
					bean = service.ReqId(acc_no);

					resp.sendRedirect("CustomerRegister.jsp?result=success&rid=" + bean.getRequestid());
					// req.setAttribute("name",bean.getRequestid() );
					// req.getRequestDispatcher("home.jsp").forward(req, resp);
				}
			} else
				resp.sendRedirect("CustomerRegister.jsp?result=fail");

		} else if (trigerFrom.equals("CustomerDetail")) {
			CustomerService service = new CustomerService();
			HttpSession session = req.getSession(false);
			String object = req.getSession(false).getAttribute("userID").toString();
			UserDetails details = service.selectCustomerData(Integer.parseInt(object));
			resp.setContentType("application/json");
			String demo = new Gson().toJson(details);
			out.println(demo);

		} else if (trigerFrom.equals("UpdateCustomerDetail")) {
			UserDetails beanAdmin = new UserDetails();
			beanAdmin.setUserID(Integer.parseInt(req.getParameter("USER_ID")));
			beanAdmin.setMobile_No(req.getParameter("MOBILE_NO"));
			beanAdmin.setMailID(req.getParameter("MAIL_ID"));
			beanAdmin.setStreetAdd(req.getParameter("STREET_ADD"));
			beanAdmin.setCity(req.getParameter("CITY"));
			beanAdmin.setState(req.getParameter("STATE"));
			CustomerService bsCustomer = new CustomerService();
			int result = bsCustomer.updateCustomer(beanAdmin);
			resp.setContentType("text/html");
			out.println(Integer.toString(result));
		}
	}
}
