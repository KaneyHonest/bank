package model;

public class AccountSetting {
	public static final int MAXIMUM_AMOUNT = 1000000000; // 口座の上限金額（１０億）
	public static final int SINGLE_TRANSACTION_LIMIT = 10000000; // １回あたりの取引金額上限（１千万）

	private AccountSetting() {}

	public static boolean isNotExceedSingleTransactionLimit(int amount) {
		return amount <= SINGLE_TRANSACTION_LIMIT;
	}
}
