package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.ExistsAccountNumberLogic;
import database.RegisterUserLogic;
import logic.CheckUserInformationLogic;
import logic.CreateAccountNumberLogic;
import logic.IsLoginLogic;
import model.Account;
import model.ErrorMessage;
import model.User;

@WebServlet("/Register")
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;

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

		User user = (User) session.getAttribute("user");
		if (user != null) {
			// ユーザーのセッションがあれば登録フォームではなく、口座番号の確認画面へリダイレクト
			response.sendRedirect("/bank/RegisterSuccessful");
			return;
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/registerForm.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		String name = request.getParameter("name");
		String password = request.getParameter("password");

		// バリデーションチェック
		boolean valid = new CheckUserInformationLogic().execute(name, password);
		if (!valid) {
			ErrorMessage errorMessage = new ErrorMessage();
			errorMessage.setMessage("登録に失敗しました");

			request.setAttribute("errorMessage", errorMessage);

			doGet(request, response);
			return;
		}

		// １から始まる１０桁の口座番号の生成
		String accountNumber = "";
		do {
			accountNumber = new CreateAccountNumberLogic().execute();
		} while (new ExistsAccountNumberLogic().execute(accountNumber));

		// Beans
		User user = new User();
		user.setName(name);
		user.setPassword(password);
		user.setAccountNumber(accountNumber);

		// データベースにユーザー情報を登録
		new RegisterUserLogic().execute(user);

		// 以下、二重送信防止のためPRGパターンを使用
		HttpSession session = request.getSession();
		session.setAttribute("user", user);

		response.sendRedirect("/bank/RegisterSuccessful");
	}
}
