<%@ page import = "java.util.*,model.UserBean,model.TeacherBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	TeacherBean teacher = (TeacherBean)session.getAttribute("teacher");
	session.setAttribute("teacher", teacher);
%>
<c:set var = "teacher" value = "${sessionScope.teacher }"/>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>T.アカウント情報</title>
    <style>
        body {
            font-family: sans-serif;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            background-color: #f0f0f0;
            margin: 0;
            padding-top: 20px;
        }

        .container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 95%;
            max-width: 400px;
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
            font-size: 15px;
        }

        .input-group input[type="text"] {
            width: calc(100% - 20px);
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            background-color: #f9f9f9; /* Read-only appearance */
            color: #666;
        }

        .password-change-link {
            display: block;
            margin: 25px 0;
            font-size: 16px;
            color: #007bff;
            text-decoration: none;
            cursor: pointer;
            transition: color 0.2s ease;
            text-align: left;
        }

        .password-change-link:hover {
            color: #0056b3;
        }

        .back-button {
            background-color: #6c757d;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
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
    <div class="container">
        <h1>T.アカウント情報</h1>
        <div class="input-group">
            <label for="teacherId">教師ID</label>
            <input type="text" id="teacherId" name="teacherId" value="${teacher.getUser_id() }" readonly>
        </div>
        <div class="input-group">
            <label for="name">名前</label>
            <input type="text" id="name" name="name" value="${teacher.getTeacher_name() }" readonly>
        </div>
        <form action = "Redirect_Teacher_Password_change_Servlet" method = "post">
        	<button type = "submit" class = "password-change-button">パスワード変更</button>
        </form>
        <form action = "Redirect_Teacher_menu_Servlet" method = "post">
        	<button type = "submit" class="back-button">戻る</button>
        </form>
    </div>
</body>
</html>