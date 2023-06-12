package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.SetBalanceLogic;
import logic.CanWithdrawLogic;
import logic.IsLoginLogic;
import logic.WithdrawLogic;
import model.Account;
import model.AccountSetting;
import model.ErrorMessage;

@WebServlet("/Withdraw")
public class Withdraw extends HttpServlet {
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

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/withdraw.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();

		Account account = (Account) session.getAttribute("account");
		new SetBalanceLogic().execute(account);

		request.setCharacterEncoding("UTF-8");
		int amount = Integer.parseInt(request.getParameter("amount"));

		// 出金額のチェック
		boolean isPassed = AccountSetting.isNotExceedSingleTransactionLimit(amount)
				&& new CanWithdrawLogic().execute(account, amount);

		if (!isPassed) {
			ErrorMessage errorMessage = new ErrorMessage();
			errorMessage.setMessage("出金に失敗しました");

			request.setAttribute("errorMessage", errorMessage);

			doGet(request, response);
			return;
		}

		// 出金処理
		new WithdrawLogic().execute(account, amount);

		response.sendRedirect("/bank/Main");
	}
}
