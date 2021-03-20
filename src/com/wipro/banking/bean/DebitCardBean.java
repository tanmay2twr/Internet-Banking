package com.wipro.banking.bean;

public class DebitCardBean {
	private int Account_NUm ;
	private long Card_No ;
	private int Valid_month ;
	private int valid_year ;
	private String Status ;
	private int Pin;
	private int CVV ;

	public int getAccount_NUm() {
		return Account_NUm;
	}

	public void setAccount_NUm(int account_NUm) {
		Account_NUm = account_NUm;
	}

	public long getCard_No() {
		return Card_No;
	}

	public void setCard_No(long card_No) {
		Card_No = card_No;
	}

	public int getValid_month() {
		return Valid_month;
	}

	public void setValid_month(int valid_month) {
		Valid_month = valid_month;
	}

	public int getValid_year() {
		return valid_year;
	}

	public void setValid_year(int valid_year) {
		this.valid_year = valid_year;
	}

	public String getStatus() {
		return Status;
	}

	public void setStatus(String status) {
		Status = status;
	}

	public int getCVV() {
		return CVV;
	}

	public void setCVV(int cVV) {
		CVV = cVV;
	}

	public int getPin() {
		return Pin;
	}

	public void setPin(int pin) {
		Pin = pin;
	}

}
