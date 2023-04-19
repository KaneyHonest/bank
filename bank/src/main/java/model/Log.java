package model;

import java.io.Serializable;

public class Log implements Serializable {
	private String operationTime;
	private String operation;
	private int beforeBalance;
	private int amount;
	private int afterBalance;
	
	public Log() {}

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

	public int getBeforeBalance() {
		return beforeBalance;
	}

	public void setBeforeBalance(int beforeBalance) {
		this.beforeBalance = beforeBalance;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getAfterBalance() {
		return afterBalance;
	}

	public void setAfterBalance(int afterBalance) {
		this.afterBalance = afterBalance;
	}
	
	
}
