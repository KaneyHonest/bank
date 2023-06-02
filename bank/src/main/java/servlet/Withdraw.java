package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import logic.CanWithdrawLogic;
import logic.IsLoginLogic;
import logic.SetBalanceLogic;
import logic.WithdrawLogic;
import model.Account;
import model.ErrorMessage;

@WebServlet("/Withdraw")
public class Withdraw extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Withdraw() {
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

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/withdraw.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Account account = (Account) session.getAttribute("account");

		request.setCharacterEncoding("UTF-8");
		int amount = Integer.parseInt(request.getParameter("amount"));

		new SetBalanceLogic().execute(account);

		//振込額のチェック
		boolean isPassed = new CanWithdrawLogic().execute(account, amount);

		if (!isPassed) {
			ErrorMessage errorMessage = new ErrorMessage();
			errorMessage.setMessage("出金エラーです。残高が減少したため、出金すると残高がマイナスになります。");

			request.setAttribute("errorMessage", errorMessage);

			doGet(request, response);
			return;
		}

		new WithdrawLogic().execute(account, amount);

		response.sendRedirect("/bank/Main");
	}

}
