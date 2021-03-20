package com.wipro.banking.service;

import java.util.List;
import java.util.Map;

import com.wipro.banking.bean.ManagerBean;
import com.wipro.banking.bean.UserDetails;
import com.wipro.banking.dao.ManagerDAO;

public class ManagerService {
	public int ManagerLogin(ManagerBean bean) {
		ManagerDAO mdao = new ManagerDAO();
		return mdao.authorized(bean);
	}

	public String getifsc(int id) {
		String result=null;
		ManagerDAO dao=new ManagerDAO();
		result=dao.getifsc(id);
		return result;
	}
	public List<Map<String,Object>> requests(String ifscCode,String status) {
		List<Map<String,Object>> result = null;
		ManagerDAO dao=new ManagerDAO();
		result=dao.requests(ifscCode,status);
		return result;
	}
	public int updateRequestStatus(int reqID,int rejAppr) {
		int result = 0;
		ManagerDAO dao=new ManagerDAO();
		result=dao.updateRequestStatus(reqID, rejAppr);
		return result;
	}
	public UserDetails selectManagerData(int user_id)
	{
		ManagerDAO adao = new ManagerDAO();
		return adao.findManager(user_id);
	}
	public int updateManager(UserDetails ubean)  {
		ManagerDAO adao = new ManagerDAO();
		return adao.updateManager(ubean);
	}
}