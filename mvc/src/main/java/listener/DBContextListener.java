package listener;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class DBContextListener implements ServletContextListener {

  
    public void contextInitialized(ServletContextEvent sce)  { 
    	System.out.print("DBContextListener");
    	// 톰캣 실행시 실행코드
    	try {
    		Class.forName("com.mysql.cj.jdbc.Driver");
    		System.out.println("------------------com.mysql.cj.jdbc.Driver 로딩성공!");
    	}catch (Exception e) {
			System.out.println("Class forName() 메서드 예외 발생!");
			e.printStackTrace();
		}
    }
    
    
    public void contextDestroyed(ServletContextEvent sce)  { 
    	// 톰캣 종료시 실행코드
    }
	
}
