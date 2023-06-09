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

import database.GetRegisterDateLogic;
import database.LogDAO;
import logic.IsLoginLogic;
import model.Account;
import model.DateSetting;
import model.Log;

@WebServlet("/ReferLog")
public class ReferLog extends HttpServlet {
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

		request.setCharacterEncoding("UTF-8");
		String date = request.getParameter("date");

		DateSetting dateSetting = new DateSetting();
		dateSetting.setDate(date);
		dateSetting.setMinDate(new GetRegisterDateLogic().execute(account)); // 口座登録日を最小年月
		dateSetting.setMaxDate(new SimpleDateFormat("yyyy-MM").format(new Date())); // 現在を最大年月

		request.setAttribute("dateSetting", dateSetting);

		// リクエストされた年月の記録を参照
		List<Log> logs = new LogDAO().execute(account, date);
		request.setAttribute("logs", logs);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/log.jsp");
		dispatcher.forward(request, response);
	}
}
