package logic;

import java.sql.Timestamp;

import database.LogLogic;
import database.UpdateBlanceLogic;
import model.Account;

public class TransferLogic {

	public void execute(Account account, Account transferAccount, int amount) {

		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		new LogLogic().execute(account, transferAccount, timestamp, "振込", "-" + amount, account.getBalance() - amount);
		new LogLogic().execute(transferAccount, account, timestamp, "振込", "+" + amount, transferAccount.getBalance() + amount);

		new UpdateBlanceLogic().execute(account, account.getBalance() - amount);
		new UpdateBlanceLogic().execute(transferAccount, transferAccount.getBalance() + amount);

	}
}
