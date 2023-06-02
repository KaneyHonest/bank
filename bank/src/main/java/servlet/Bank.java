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

@WebServlet("/Bank")
public class Bank extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Bank() {
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

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/index.jsp");
		dispatcher.forward(request, response);
	}
}
