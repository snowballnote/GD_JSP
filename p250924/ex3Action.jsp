<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%
	//1)controller Layer	
	String myRsp = request.getParameter("rsp");
	System.out. println(myRsp + " <---myRsp");
	
	//2)Model Layer
	String[] comRspArr = {"가위", "바위", "보"};
	String comRsp = comRspArr[(int)(Math.random()*3)]; //0,1,2
	System.out.println(comRsp + " <---comRsp");
	
	String result = "";
	
	if(myRsp.equals(comRsp)){
		result = "비겼다.";
	}else if(myRsp.equals("가위")&&comRsp.equals("보") || myRsp.equals("바위")&&comRsp.equals("가위") || myRsp.equals("보")&&comRsp.equals("바위")){
		result = "유저 승";
	}else{
		result = "컴퓨터 승";
	}
%>

<!-- View Layer -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		나 : <%=myRsp %> vs 컴퓨터 : <%=comRsp %>
	</div>
	<div>
		결과 : <%=result %>
	</div>
</body>
</html>