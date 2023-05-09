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
import model.Account;
import model.ErrorMessage;
import model.User;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		Account account = (Account) session.getAttribute("account");
		
		if (account != null) {
			response.sendRedirect("/bank/Main");
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/loginForm.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		String accountNumber = request.getParameter("accountNumber");
		String password = request.getParameter("password");
		
		//口座番号とパスワードチェック
		
		User user = new User();
		user.setAccountNumber(accountNumber);
		user.setPassword(password);
		boolean canLogin = new CanLoginLogic().execute(user);
		
		if (canLogin) {
			Account account = new Account();
			account.setAccountNumber(accountNumber);
			
			/*
			 * 後で作る
			new LogDAO().execute(account);
			*/
			
			HttpSession session = request.getSession();
			session.setAttribute("account", account);
			
			response.sendRedirect("/bank/Main");
		} else {
			
			
			//エラー
			ErrorMessage errorMessage = new ErrorMessage();
			errorMessage.setMessage("ログインに失敗しました。");
			
			request.setAttribute("errorMessage", errorMessage);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/loginForm.jsp");
			dispatcher.forward(request, response);
		}
	}

}
