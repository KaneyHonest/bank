package logic;

import java.sql.Timestamp;

import database.LogTransactionLogic;
import database.UpdateBlanceLogic;
import model.Account;

public class WithdrawLogic {
	public void execute(Account account, int amount) {
		new LogTransactionLogic().execute(account, new Timestamp(System.currentTimeMillis()), "出金", "-" + amount, account.getBalance() - amount);
		new UpdateBlanceLogic().execute(account, account.getBalance() - amount);
	}
}
