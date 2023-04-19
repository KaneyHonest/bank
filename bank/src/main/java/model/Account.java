package model;

import java.io.Serializable;

public class Account implements Serializable {
	private String accountNumber;
	private int balance;
	
	public Account() {}

	public String getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

	public int getBalance() {
		return balance;
	}

	public void setBalance(int balance) {
		this.balance = balance;
	}
}
