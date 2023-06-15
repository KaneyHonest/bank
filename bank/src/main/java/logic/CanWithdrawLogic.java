package logic;

import model.Account;

public class CanWithdrawLogic {
	public boolean execute(Account account, int amount) {
		return account.getBalance() >= amount;
	}
}
