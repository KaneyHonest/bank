package logic;

import model.Account;
import model.AccountSetting;

public class CanDepositLogic {
	public boolean execute(Account account, int amount) {
		return account.getBalance() + amount <= AccountSetting.MAXIMUM_AMOUNT;
	}
}
