package servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.LogDAO;
import logic.GetRegisterDateLogic;
import model.Account;
import model.DateSettings;
import model.Log;

/**
 * Servlet implementation class ReferLog
 */
@WebServlet("/ReferLog")
public class ReferLog extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReferLog() {
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
		
		DateSettings dateSettings = (DateSettings) request.getAttribute("dateSettings");
		if (dateSettings == null) {
			//最小値セット
			dateSettings = new DateSettings();
			dateSettings.setMinDate(new GetRegisterDateLogic().execute(account));
		} 
		
		//最大値とvalueをセット
		dateSettings.setMaxDate(new SimpleDateFormat("yyyy-MM").format(new Date()));
		
		request.setCharacterEncoding("UTF-8");
		String date = request.getParameter("date");
		dateSettings.setDate(date);
		
		request.setAttribute("dateSettings", dateSettings);
		
		//ログをスコープへ
		List<Log> logs = new LogDAO().execute(account, date);
		request.setAttribute("logs", logs);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/log.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
