package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.LogDAO;
import database.SetBalanceLogic;
import logic.IsLoginLogic;
import model.Account;
import model.Log;

@WebServlet("/Main")
public class Main extends HttpServlet {
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

		// 残高をセット
		new SetBalanceLogic().execute(account);

		// 直近５つ分の口座の記録を参照
		List<Log> logs = new LogDAO().execute(account, 5);
		request.setAttribute("logs", logs);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/account.jsp");
		dispatcher.forward(request, response);
	}
}
