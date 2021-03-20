package com.wipro.banking.bean;
import javax.servlet.http.HttpServlet;

public class BranchBean extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private String branchName;
	 private String ifsccode;
	 private String streetAdd;
	 private String city;
	 private String State;
	 private int managerUserId;
	public String getBranchName() {
		return branchName;
	}
	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}
	public String getIfsccode() {
		return ifsccode;
	}
	public void setIfsccode(String ifsccode) {
		this.ifsccode = ifsccode;
	}
	public String getStreetAdd() {
		return streetAdd;
	}
	public void setStreetAdd(String streetAdd) {
		this.streetAdd = streetAdd;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getState() {
		return State;
	}
	public void setState(String state) {
		State = state;
	}
	public int getManagerUserId() {
		return managerUserId;
	}
	public void setManagerUserId(int managerUserId) {
		this.managerUserId = managerUserId;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	 

}
