package com.wipro.banking.bean;

public class CustomerAccountBean {

	private int user_ID ;
	private long Account_Num ;
	private String Customize_User_name ;
	private String IFSC_Code;
	private String profile_password ;
	private String Internet_bank_status ;
	private String Account_Type ;
	private long balance;
	public long getBalance() {
		return balance;
	}
	public void setBalance(long balance) {
		this.balance = balance;
	}
	public int getUser_ID() {
		return user_ID;
	}
	public void setUser_ID(int user_ID) {
		this.user_ID = user_ID;
	}
	public long getAccount_Num() {
		return Account_Num;
	}
	public void setAccount_Num(long account_Num) {
		Account_Num = account_Num;
	}
	public String getCustomize_User_name() {
		return Customize_User_name;
	}
	public void setCustomize_User_name(String customize_User_name) {
		Customize_User_name = customize_User_name;
	}
	public String getIFSC_Code() {
		return IFSC_Code;
	}
	public void setIFSC_Code(String iFSC_Code) {
		IFSC_Code = iFSC_Code;
	}
	public String getProfile_password() {
		return profile_password;
	}
	public void setProfile_password(String profile_password) {
		this.profile_password = profile_password;
	}
	public String getInternet_bank_status() {
		return Internet_bank_status;
	}
	public void setInternet_bank_status(String internet_bank_status) {
		Internet_bank_status = internet_bank_status;
	}
	public String getAccount_Type() {
		return Account_Type;
	}
	public void setAccount_Type(String account_Type) {
		Account_Type = account_Type;
	}
	
}
