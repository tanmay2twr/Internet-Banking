package com.wipro.banking.bean;

public class TranscationsBean {

	private int Transaction_Id ;
	private String Transfer_mode ;
	private int debit_from ;
	private int credit_to;
	private String status;
	private String Remarks_Customer;
	private String Remarks_System ;
	public int getTransaction_Id() {
		return Transaction_Id;
	}
	public void setTransaction_Id(int transaction_Id) {
		Transaction_Id = transaction_Id;
	}
	public String getTransfer_mode() {
		return Transfer_mode;
	}
	public void setTransfer_mode(String transfer_mode) {
		Transfer_mode = transfer_mode;
	}
	public int getDebit_from() {
		return debit_from;
	}
	public void setDebit_from(int debit_from) {
		this.debit_from = debit_from;
	}
	public int getCredit_to() {
		return credit_to;
	}
	public void setCredit_to(int credit_to) {
		this.credit_to = credit_to;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getRemarks_Customer() {
		return Remarks_Customer;
	}
	public void setRemarks_Customer(String remarks_Customer) {
		Remarks_Customer = remarks_Customer;
	}
	public String getRemarks_System() {
		return Remarks_System;
	}
	public void setRemarks_System(String remarks_System) {
		Remarks_System = remarks_System;
	}
	
}
