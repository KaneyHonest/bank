package logic;

import model.Account;

public class CheckWithdraw {
	public boolean execute(Account account, int amount) {
		return account.getBalance() >= amount;
	}
}
