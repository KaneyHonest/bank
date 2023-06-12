package model;

import java.io.Serializable;

public class Log implements Serializable {
	private String operationTime;
	private String operation;
	private String address;
	private int amount;
	private int Balance;

	public String getOperationTime() {
		return operationTime;
	}

	public void setOperationTime(String operationTime) {
		this.operationTime = operationTime;
	}

	public String getOperation() {
		return operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getBalance() {
		return Balance;
	}

	public void setBalance(int Balance) {
		this.Balance = Balance;
	}
}
