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
import logic.CanWithdrawLogic;
import logic.ExistsAccountNumberLogic;
import logic.IsLoginLogic;
import logic.SetBalanceLogic;
import logic.TransferLogic;
import model.Account;
import model.AccountSetting;
import model.ErrorMessage;

@WebServlet("/Transfer")
public class Transfer extends HttpServlet {
	private static final long serialVersionUID = 1L;

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

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/transfer.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();

		Account account = (Account) session.getAttribute("account");
		new SetBalanceLogic().execute(account);

		request.setCharacterEncoding("UTF-8");
		int amount = Integer.parseInt(request.getParameter("amount"));
		String transferAccountNumber = request.getParameter("accountNumber");

		// 振込額と振込先のチェック
		boolean isPassed = AccountSetting.isNotExceedSingleTransactionLimit(amount)
				&& new CanWithdrawLogic().execute(account, amount)
				&& new ExistsAccountNumberLogic().execute(transferAccountNumber)
				&& new CanDepositLogic().execute(transferAccountNumber, amount);

		if (!isPassed) {
			ErrorMessage errorMessage = new ErrorMessage();
			errorMessage.setMessage("振込に失敗しました");

			request.setAttribute("errorMessage", errorMessage);

			doGet(request, response);
			return;
		}

		// 振込処理
		new TransferLogic().execute(account, transferAccountNumber, amount);

		response.sendRedirect("/bank/Main");
	}
}
