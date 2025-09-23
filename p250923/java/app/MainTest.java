package app;
import java.util.Calendar; //짧은버전

public class MainTest {
	public static void main(String[] args) {
		//java.util.Calendar today = java.util.Calendar.getInstance(); 너무김.
		Calendar today = Calendar.getInstance();
		System.out.println(today); //today.toString() 생략되어있음
		//
		
		System.out.println(today.get(Calendar.YEAR)); //2025
		System.out.println(today.get(Calendar.MONTH) + 1); //9
		System.out.println(today.get(Calendar.DATE)); //23
		System.out.println(today.get(Calendar.HOUR)); //9
		System.out.println(today.get(Calendar.MINUTE)); //28
		System.out.println(today.get(Calendar.MILLISECOND)); //560
		System.out.println(today.get(Calendar.DAY_OF_WEEK)); //1일요일, 2월-7토
		switch(today.get(Calendar.DAY_OF_WEEK)) {
			case 1: 
				System.out.println("일"); break;
			case 2: 
				System.out.println("월"); break;
			case 3: 
				System.out.println("화"); break;
			case 4: 
				System.out.println("수"); break;
			case 5: 
				System.out.println("목"); break;
			case 6: 
				System.out.println("금"); break;
			case 7: 
				System.out.println("토"); break;
		}
	}
}