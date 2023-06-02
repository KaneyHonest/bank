package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import logic.CanLoginLogic;
import logic.IsLoginLogic;
import model.Account;
import model.ErrorMessage;
import model.User;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Login() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		Account account = (Account) session.getAttribute("account");

		boolean isLogin = new IsLoginLogic().execute(account);
		if (isLogin) {
			// ログイン状態なら口座画面へリダイレクト
			response.sendRedirect("/bank/Main");
			return;
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/loginForm.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		String accountNumber = request.getParameter("accountNumber");
		String password = request.getParameter("password");

		User user = new User();
		user.setAccountNumber(accountNumber);
		user.setPassword(password);

		boolean canLogin = new CanLoginLogic().execute(user);
		if (canLogin) { // ログイン成功
			Account account = new Account();
			account.setAccountNumber(accountNumber);

			HttpSession session = request.getSession();
			session.setAttribute("account", account);

			response.sendRedirect("/bank/Main");
		} else { // ログイン失敗
			ErrorMessage errorMessage = new ErrorMessage();
			errorMessage.setMessage("ログインに失敗しました。");

			request.setAttribute("errorMessage", errorMessage);

			doGet(request, response);
		}
	}
}
