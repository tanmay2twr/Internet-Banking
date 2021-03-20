package com.wipro.banking.service;

import java.util.List;

import com.wipro.banking.bean.BeneficaryDetailBean;
import com.wipro.banking.bean.CustomerAccountBean;
import com.wipro.banking.bean.DebitCardBean;
import com.wipro.banking.bean.RequestsBean;
import com.wipro.banking.bean.UserDetails;
import com.wipro.banking.bean.statementBean;
import com.wipro.banking.dao.CustomerDAO;

public class CustomerService {

	public CustomerAccountBean customerLogin(CustomerAccountBean customerBean) {
		CustomerDAO adao = new CustomerDAO();
		return adao.authorized(customerBean);
	}

	public List<statementBean> statement(String acc_num) {
		CustomerDAO dao = new CustomerDAO();
		List<statementBean> result = null;
		result = dao.statement(acc_num);
		return result;
	}

	public RequestsBean customerStatus(int rid) {
		CustomerDAO adao = new CustomerDAO();
		return adao.status(rid);
	}

	public int addBeneficiary(BeneficaryDetailBean bean) {
		int result = 0;
		CustomerDAO dao = new CustomerDAO();
		result = dao.addBeneficiary(bean);
		return result;
	}

	public int otherBenificiary(BeneficaryDetailBean bean) {
		int result = 0;
		CustomerDAO dao = new CustomerDAO();
		result = dao.otherBeneficiary(bean);
		return result;
	}

	public List<BeneficaryDetailBean> getBeneficiary(String id, String call) {
		CustomerDAO dao = new CustomerDAO();
		List<BeneficaryDetailBean> list = dao.getBeneficiary(id, call);
		return list;
	}

	public CustomerAccountBean getCustomerDetails(String id) {
		CustomerAccountBean bean = new CustomerAccountBean();
		CustomerDAO dao = new CustomerDAO();
		bean = dao.getCustomerDetails(id);
		return bean;
	}

	public DebitCardBean debitDetails(long account_Num) {
		CustomerDAO dao = new CustomerDAO();
		DebitCardBean debitCardBean = dao.fetchDebitCardDetails(account_Num);
		return debitCardBean;
	}

	public DebitCardBean Register(int accno) {
		CustomerDAO adao = new CustomerDAO();
		return adao.validate(accno);

	}

	public RequestsBean ReqId(int accno) {
		CustomerAccountBean bean = new CustomerAccountBean();
		RequestsBean bean1 = new RequestsBean();
		CustomerDAO adao = new CustomerDAO();
		bean1 = adao.RequestId(accno);
		return bean1;

	}

	public RequestsBean CustomerAcc(int accno) {
		RequestsBean bean = new RequestsBean();
		CustomerDAO adao = new CustomerDAO();
		bean = adao.CustomerAcc(accno);
		return bean;
	}

	public int updateCustomerDetails(String uname, String password, int userid,String tpassword) {
		CustomerDAO dao = new CustomerDAO();
		int result = dao.updateCustomerDetails(uname, password, userid, tpassword);
		return result;
	}

	public CustomerAccountBean fetchInternetBanking(int userid) {
		CustomerDAO dao = new CustomerDAO();
		CustomerAccountBean customerAccountBean = dao.fetchInternetBanking(userid);
		return customerAccountBean;
	}

	public int checkDebitwithin(String id, Long accNum, int amount, String password) {
		int result = 0;
		CustomerDAO dao = new CustomerDAO();
		result = dao.checkDebitwithin(id, accNum, amount, password);
		return result;
	}

	public int checkDebitother(String id, Long accNum, int amount, String mode, String tpassword) {
		int result = 0;
		CustomerDAO dao = new CustomerDAO();
		result = dao.checkDebitother(id, accNum, amount, mode,tpassword);
		return result;
	}

	public UserDetails selectCustomerData(int user_id) {
		CustomerDAO adao = new CustomerDAO();
		return adao.findCustomer(user_id);
	}

	public int updateCustomer(UserDetails ubean) {
		CustomerDAO adao = new CustomerDAO();
		return adao.updateCustomer(ubean);
	}

}
