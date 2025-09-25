<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%	
		// 2 * 1 = 2	2 * 2 = 4
		for(int outt=2; outt<=9; outt++){
			for(int in=1; in<=9; in++){
				System.out.print(outt + "*" + in + "=" + (outt * in) + "\t");
			}
			System.out.println();
		}
		System.out.println();
		for(int outt=1; outt<=9; outt++){
			for(int in=2; in<=9; in++){
				System.out.print(in + "*" + outt + "=" + (in * outt) + "\t");
			}
			System.out.println();
		}
	%>
</body>
</html>