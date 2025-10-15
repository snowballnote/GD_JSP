<!-- addDeptEmpForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addDeptEmpForm.jsp</title>
</head>
<body>
  <jsp:include page="/inc/menu.jsp"></jsp:include>
  <h1>addDeptEmp</h1>

  <form method="post" action="<%=request.getContextPath()%>/deptEmp/addDeptEmpAction.jsp">
    <div>
      사번(empNo): 
      <input type="number" name="empNo" required>
    </div>
    <div>
      현재/새 부서번호(deptNo): 
      <input type="text" name="deptNo" required placeholder="예: d005">
    </div>
    <div>
      새 소속 시작일(fromDate): 
      <input type="date" name="fromDate" required>
    </div>
    <div>
      현재 소속 종료일(toDate): 
      <input type="date" name="toDate" required>
    </div>
    <div style="margin-top:8px;">
      <button type="submit">저장</button>
      <a href="<%=request.getContextPath()%>/employee/employeeList.jsp">취소</a>
    </div>
  </form>
</body>
</html>
