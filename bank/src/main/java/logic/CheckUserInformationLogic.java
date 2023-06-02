package logic;

public class CheckUserInformationLogic {

	public boolean execute(String name, String password) {
		return name.matches("^.{1,10}$") && password.matches("^[0-9a-zA-Z]{4,16}$");
	}
}
