package com.wipro.banking.service;

import java.util.Map;

import com.wipro.banking.bean.AdminBean;
import com.wipro.banking.bean.ManagerBean;
import com.wipro.banking.bean.UserDetails;
import com.wipro.banking.dao.AdminDAO;


public class AdminService
{
	public int adminLogin(AdminBean adminBean)
	{
		AdminDAO adao = new AdminDAO();
		return adao.authorized(adminBean);
	}
	public UserDetails selectAdminData(int user_id)
	{
		AdminDAO adao = new AdminDAO();
		return adao.findAdmin(user_id);
	}
	public int updateAdmin(UserDetails ubean)  {
		AdminDAO adao = new AdminDAO();
		return adao.updateAdmin(ubean);
	}
	public int addmanager(ManagerBean bean , UserDetails details) {
		AdminDAO dao=new AdminDAO();
		return dao.addManager(bean , details);
	}
	public int deleteManager(int user_id)  {
		AdminDAO dao = new AdminDAO();
		return dao.deleteManager(user_id);
	}
	public int modifymanager(UserDetails bean){
		AdminDAO dao=new AdminDAO();
		return dao.modifyBankManager(bean);
		
	}
	public Map<String, Object> managerBranchDetail(){
		AdminDAO dao=new AdminDAO();
		return dao.managerBranchDetail();
	}
	public int updateDelete(String modifyData,int status) {
		AdminDAO dao=new AdminDAO();
		return dao.updateDelete(modifyData, status);
	}
	public int addManager(String managerDetail) {
		AdminDAO dao=new AdminDAO();
		return dao.addManager(managerDetail);
	}
}