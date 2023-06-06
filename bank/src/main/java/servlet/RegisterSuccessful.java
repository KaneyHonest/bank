package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import logic.IsLoginLogic;
import model.Account;
import model.User;

@WebServlet("/RegisterSuccessful")
public class RegisterSuccessful extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();

		User user = (User) session.getAttribute("user");
		if (user == null) {
			// ユーザー情報がなければ最初の画面へリダイレクト
			response.sendRedirect("/bank/Bank");
			return;
		}

		Account account = (Account) session.getAttribute("account");
		boolean isLogin = new IsLoginLogic().execute(account);
		if (isLogin) {
			// ログイン状態なら口座画面へリダイレクト
			response.sendRedirect("/bank/Main");
			return;
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/registerSuccessful.jsp");
		dispatcher.forward(request, response);
	}
}
