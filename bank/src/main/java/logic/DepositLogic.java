package logic;

import java.sql.Timestamp;

import database.LogLogic;
import database.UpdateBlanceLogic;
import model.Account;

public class DepositLogic {

	public void execute(Account account, int amount) {

		new LogLogic().execute(account, new Timestamp(System.currentTimeMillis()), "入金", "+" + amount, account.getBalance() + amount);
		new UpdateBlanceLogic().execute(account, account.getBalance() + amount);
		
	}
}
