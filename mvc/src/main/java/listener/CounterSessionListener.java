package listener;

import dao.CounterDao;
import jakarta.servlet.ServletContext;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

@WebListener
public class CounterSessionListener implements HttpSessionListener {
    // 세션 만들어질때
	public void sessionCreated(HttpSessionEvent se)  {
		// 현재 접속자 수
		ServletContext application = se.getSession().getServletContext();
		int c = (Integer)application.getAttribute("currentCount");
		application.setAttribute("currentCount", c+1);
		
		// 오늘 누적 접속자 수
		CounterDao counterDao = new CounterDao();
		Integer todayCount = null;
		try {
			todayCount = counterDao.selectToday();
			if(todayCount == null) { // 오늘 처음 접속시 - 오늘날짜 1
				counterDao.insertCounter();
			}else { // 오늘 카운트에 누적 - 오늘날짜 +1
				counterDao.updateCounter();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
	
	// 세션 종료 될때
    public void sessionDestroyed(HttpSessionEvent se)  { 
    	ServletContext application = se.getSession().getServletContext();
    	int c = (Integer)application.getAttribute("currentCount");
		application.setAttribute("currentCount", c-1);
    }
}
