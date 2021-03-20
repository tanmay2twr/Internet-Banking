package com.wipro.banking.bean;

import javax.servlet.http.HttpServlet;

public class statementBean extends HttpServlet {
	private int transactionID;
	private String chronicle;
	private String transactionMode;
//	private int amount;
	private int credit;
	private int debit;
	public int getTransactionID() {
		return transactionID;
	}
	public void setTransactionID(int transactionID) {
		this.transactionID = transactionID;
	}
	public String getChronicle() {
		return chronicle;
	}
	public void setChronicle(String chronicle) {
		this.chronicle = chronicle;
	}
	public String getTransactionMode() {
		return transactionMode;
	}
	public void setTransactionMode(String transactionMode) {
		this.transactionMode = transactionMode;
	}
	/*public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}*/
	public int getCredit() {
		return credit;
	}
	public void setCredit(int credit) {
		this.credit = credit;
	}
	public int getDebit() {
		return debit;
	}
	public void setDebit(int debit) {
		this.debit = debit;
	}
	
}
