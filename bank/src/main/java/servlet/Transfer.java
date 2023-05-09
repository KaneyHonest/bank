package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import logic.CheckDeposit;
import logic.CheckWithdraw;
import logic.ExistsAccountNumberLogic;
import logic.SearchBalanceLogic;
import logic.TransferLogic;
import model.Account;
import model.ErrorMessage;

/**
 * Servlet implementation class Transfer
 */
@WebServlet("/Transfer")
public class Transfer extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Transfer() {
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
		
		if (account == null) {
			response.sendRedirect("/bank/Bank");
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/transfer.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		Account account = (Account)session.getAttribute("account");
		
		new SearchBalanceLogic().execute(account);
		
		request.setCharacterEncoding("UTF-8");
		int amount = Integer.parseInt(request.getParameter("amount"));
		String transferAccountNumber = request.getParameter("accountNumber");
		
		//振込額のチェック
		
		boolean isPassed = new CheckWithdraw().execute(account, amount) && new ExistsAccountNumberLogic().execute(transferAccountNumber) && new CheckDeposit().execute(transferAccountNumber, amount);
		
		if (!isPassed) {
			ErrorMessage errorMessage = new ErrorMessage();
			errorMessage.setMessage("振込エラーです。");
			
			request.setAttribute("errorMessage", errorMessage);
			
			doGet(request, response);
			return;
		}
		
		new TransferLogic().execute(account, transferAccountNumber, amount);
		
		response.sendRedirect("/bank/Main");
	}

}
