<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ex4Form.jsp</title>
</head>
<body>
   <h1>수학 시험</h1>
   <form action="/p250924/ex4Action.jsp">
   <div>
   		이름 : <input type="text" name="name">
   </div>
      <!-- 문제1 -->
      <div>
         <div><!-- 문제 -->
            1. 3 + 1 =
         </div>
         
         <div><!-- 보기 -->
            <input type="radio" name="q1" value="1"> ① 2 
            <input type="radio" name="q1" value="2"> ② 3 
            <input type="radio" name="q1" value="3"> ③ 4 
            <input type="radio" name="q1" value="4"> ④ 5
         </div>
      </div>
      <hr>
      
      <!-- 문제2 -->
      <div>
         <div><!-- 문제 -->
            2. 7 - 5 =
         </div>
         
         <div><!-- 보기 -->
            <input type="radio" name="q2" value="1"> ① 1 
            <input type="radio" name="q2" value="2"> ② 2 
            <input type="radio" name="q2" value="3"> ③ 3 
            <input type="radio" name="q2" value="4"> ④ 4
         </div>
      </div>
      <hr>
      
      <!-- 문제3 -->
      <div>
         <div><!-- 문제 -->
            3. 14 + 17 =
         </div>
         
         <div><!-- 보기 -->
            <input type="radio" name="q3" value="1"> ① 11 
            <input type="radio" name="q3" value="2"> ② 21 
            <input type="radio" name="q3" value="3"> ③ 31 
            <input type="radio" name="q3" value="4"> ④ 41
         </div>
      </div>
      <hr>
      
      <!-- 문제4 -->
      <div>
         <div><!-- 문제 -->
            4. 3 * 0 =
         </div>
         
         <div><!-- 보기 -->
            <input type="radio" name="q4" value="1"> ① 0
            <input type="radio" name="q4" value="2"> ② 1 
            <input type="radio" name="q4" value="3"> ③ 2 
            <input type="radio" name="q4" value="4"> ④ 3
         </div>
      </div>
      <hr>
      
      <!-- 문제5 -->
      <div>
         <div><!-- 문제 -->
            5. 20 / 5 =
         </div>
         
         <div><!-- 보기 -->
            <input type="radio" name="q5" value="1"> ① 4
            <input type="radio" name="q5" value="2"> ② 5 
            <input type="radio" name="q5" value="3"> ③ 10
            <input type="radio" name="q5" value="4"> ④ 14
         </div>
      </div>
      <hr>
      
      <!-- 문제6 -->
      <div>
         <div><!-- 문제 -->
            6. 13 % 5 =
         </div>
         
         <div><!-- 보기 -->
            <input type="radio" name="q6" value="1"> ① 13
            <input type="radio" name="q6" value="2"> ② 3
            <input type="radio" name="q6" value="3"> ③ 10
            <input type="radio" name="q6" value="4"> ④ 5
         </div>
      </div>
      <hr>
      
      <!-- 문제7 -->
      <div>
         <div><!-- 문제 -->
            7. 9 % 3 =
         </div>
         
         <div><!-- 보기 -->
            <input type="radio" name="q7" value="1"> ① 0
            <input type="radio" name="q7" value="2"> ② 1
            <input type="radio" name="q7" value="3"> ③ 2
            <input type="radio" name="q7" value="4"> ④ 3
         </div>
      </div>
      <hr>
      
      <!-- 문제8 -->
      <div>
         <div><!-- 문제 -->
            8. 10 + 7 - 9 =
         </div>
         
         <div><!-- 보기 -->
            <input type="radio" name="q8" value="1"> ① 7
            <input type="radio" name="q8" value="2"> ② 8
            <input type="radio" name="q8" value="3"> ③ 9
            <input type="radio" name="q8" value="4"> ④ 10
         </div>
      </div>
      <hr>
      
      <!-- 문제9 -->
      <div>
         <div><!-- 문제 -->
            9. 11 + 20 - 7 =
         </div>
         
         <div><!-- 보기 -->
            <input type="radio" name="q9" value="1"> ① 21
            <input type="radio" name="q9" value="2"> ② 22
            <input type="radio" name="q9" value="3"> ③ 23
            <input type="radio" name="q9" value="4"> ④ 24
         </div>
      </div>
      <hr>
      
      <!-- 문제10 -->
      <div>
         <div><!-- 문제 -->
            10. 3 + 5 * 10 =
         </div>
         
         <div><!-- 보기 -->
            <input type="radio" name="q10" value="1"> ① 80
            <input type="radio" name="q10" value="2"> ② 53
            <input type="radio" name="q10" value="3"> ③ 150
            <input type="radio" name="q10" value="4"> ④ 180
         </div>
      </div>
      <hr>
      <div>
         <button type="submit">답안제출</button>
      </div>
   </form>
</body>
</html>