package logic;

import java.sql.Timestamp;

import database.LogLogic;
import database.UpdateBlanceLogic;
import model.Account;

public class TransferLogic {

	public void execute(Account account, Account transferAccount, int amount) {

		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		new LogLogic().execute(account, transferAccount, timestamp, "振込", -amount);
		new LogLogic().execute(transferAccount, account, timestamp, "振込", amount);

		new UpdateBlanceLogic().execute(account, -amount);
		new UpdateBlanceLogic().execute(transferAccount, amount);

	}
}
