<%@ page import = "java.util.*,model.UserBean,model.StudentBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
   	StudentBean student = (StudentBean)session.getAttribute("student");
   	session.setAttribute("student", student);
%>
<c:set var = "student" value = "${sessionScope.student }"/>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>S.アカウント情報</title>
    <style>
        body {
            font-family: sans-serif;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            background-color: #f8f8f8; 
            margin: 0;
            padding-top: 20px;
        }

        .account-info-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
            box-sizing: border-box;
        }

        h1 {
            font-size: 22px;
            margin-bottom: 25px;
            color: #333; 
            text-align: left;
        }

        .input-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .input-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555; 
        }

        .input-group input[type="text"] {
            width: calc(100% - 20px);
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            background-color: #f9f9f9; 
            color: #666;
        }

        .password-change-button {
            background-color: #007bff;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.2s ease;
            font-size: 16px;
            width: 100%;
            max-width: 150px;
            margin-top: 15px;
            box-sizing: border-box;
        }

        .password-change-button:hover {
            background-color: #0056b3;
        }
        
        .back-button {
            /* 参照元 (.action-button) のスタイルを適用 */
            background-color: #6c757d;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px; /* 5px から 4px に変更 */
            cursor: pointer;
            
            /* この画面のレイアウト維持に必要なスタイル */
            font-size: 16px;
            width: 100%;
            max-width: 150px;
            margin-top: 30px;
            transition: background-color 0.3s ease;
        }

        .back-button:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
    <div class="account-info-container">
        <h1>S.アカウント情報</h1>
        <div class="input-group">
            <label for="studentId">学籍番号</label>
            <input type="text" id="student_id" name="student_id" value="${student.getUser_id() }" readonly>
        </div>
        <div class="input-group">
            <label for="name">名前</label>
            <input type="text" id="student_name" name="student_name" value="${student.getStudent_name() }" readonly>
        </div>
        <form action = "Redirect_Password_change_Servlet" method = "post">
        	<button type = "submit" class = "password-change-button">パスワード変更</button>
        </form>
        <form action = "Redirect_Student_menu_Servlet" method = "post">
        	<button type = "submit" class="back-button">戻る</button>
        </form>
    </div>
</body>
</html>