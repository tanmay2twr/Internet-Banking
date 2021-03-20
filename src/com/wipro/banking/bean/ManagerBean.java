package com.wipro.banking.bean;

import javax.servlet.http.HttpServlet;

public class ManagerBean
{
	private int userID;
	private String password;
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
}