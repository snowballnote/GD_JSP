<!-- /exam/question/addQuestionForm.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
   String categoryId = request.getParameter("categoryId");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addQuestionForm.jsp</title>
</head>
<body>
   <h1>시험문제 등록(+ 4지선다 보기 등록)</h1>
   <form action="<%=request.getContextPath()%>/question/addQuestionAction.jsp" method="post">
      <fieldset>
         <legend>문제</legend>
         <table border="1">
            <tr>
               <th>회차(category_id)</th>
               <td>
                  <input type="number" name="categoryId" value="<%=categoryId%>" readonly>
               </td>
            </tr>
            <tr>
               <th>문제번호(question_no)</th>
               <td>
                  <input type="number" name="questionNo">
               </td>
            </tr>
            <tr>
               <th>문제내용(question_title)</th>
               <td>
                  <textarea name="questionTitle" rows="2" cols="50"></textarea>
               </td>
            </tr>
            <tr>
               <th>정답(question_answer)</th>
               <td>
                  <input type="radio" name="questionAnswer" value="1">1
                  <input type="radio" name="questionAnswer" value="2">2
                  <input type="radio" name="questionAnswer" value="3">3
                  <input type="radio" name="questionAnswer" value="4">4
               </td>
            </tr>
         </table>
      </fieldset>
      <fieldset>
         <legend>보기</legend>
         <table border="1">
            <tr>
               <th>1</th>
               <td><input type="text" name="itemTitle"></td>
            </tr>
            <tr>
               <th>2</th>
               <td><input type="text" name="itemTitle"></td>
            </tr>
            <tr>
               <th>3</th>
               <td><input type="text" name="itemTitle"></td>
            </tr>
            <tr>
               <th>4</th>
               <td><input type="text" name="itemTitle"></td>
            </tr>
         </table>
      </fieldset>
      <div style="margin-top:12px;">
      	<button type="submit">문제추가</button>
        <a href="<%=request.getContextPath()%>/question/questionListByCategory.jsp?">[문제목록]</a>
      </div>
   </form>
</body>
</html>