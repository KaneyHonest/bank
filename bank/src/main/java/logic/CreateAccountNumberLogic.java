package logic;

public class CreateAccountNumberLogic {
	public String execute() {
		String accountNumber = "1";
		for (int i = 0; i < 9; i++) {
			accountNumber += (int)(Math.random() * 10);
		}
		
		return accountNumber;
	}
}
