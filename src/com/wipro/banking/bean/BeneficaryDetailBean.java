package com.wipro.banking.bean;

public class BeneficaryDetailBean {
	private String User_ID ;
	private int Beneficiary_Account;
	private String Beneficiary_name ;
	private String IFSC_Code ;
	public String getUser_ID() {
		return User_ID;
	}
	public void setUser_ID(String user_ID) {
		User_ID = user_ID;
	}
	public int getBeneficiary_Account() {
		return Beneficiary_Account;
	}
	public void setBeneficiary_Account(int beneficiary_Account) {
		Beneficiary_Account = beneficiary_Account;
	}
	public String getBeneficiary_name() {
		return Beneficiary_name;
	}
	public void setBeneficiary_name(String beneficiary_name) {
		Beneficiary_name = beneficiary_name;
	}
	public String getIFSC_Code() {
		return IFSC_Code;
	}
	public void setIFSC_Code(String iFSC_Code) {
		IFSC_Code = iFSC_Code;
	}
	
}
