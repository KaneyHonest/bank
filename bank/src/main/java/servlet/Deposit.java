package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import logic.CanDepositLogic;
import logic.DepositLogic;
import logic.IsLoginLogic;
import logic.SetBalanceLogic;
import model.Account;
import model.ErrorMessage;

@WebServlet("/Deposit")
public class Deposit extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Deposit() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		
		Account account = (Account) session.getAttribute("account");
		boolean isLogin = new IsLoginLogic().execute(account);
		if (!isLogin) {
			// ログイン状態でないなら初期画面へリダイレクト
			response.sendRedirect("/bank/Bank");
			return;
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/deposit.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		Account account = (Account) session.getAttribute("account");

		request.setCharacterEncoding("UTF-8");
		int amount = Integer.parseInt(request.getParameter("amount"));

		new SetBalanceLogic().execute(account);

		//振込額のチェック
		boolean isPassed = new CanDepositLogic().execute(account, amount);

		if (!isPassed) {
			ErrorMessage errorMessage = new ErrorMessage();
			errorMessage.setMessage("入金エラーです。残高が増加したため、入金すると口座の上限金額を超えてしまいます。");

			request.setAttribute("errorMessage", errorMessage);

			doGet(request, response);
			return;
		}

		new DepositLogic().execute(account, amount);

		response.sendRedirect("/bank/Main");
	}

}
