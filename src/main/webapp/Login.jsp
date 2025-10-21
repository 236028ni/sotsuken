<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="login_error_msg" value="${sessionScope.login_error_msg}" />
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ログイン画面</title>
    <style>
        body {
            font-family: sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f0f0f0;
            margin: 0;
        }

        .login-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 90%; 
            max-width: 400px; 
            text-align: center;
            box-sizing: border-box;
        }

        h1 {
            font-size: 24px;
            margin-bottom: 25px;
            color: #333;
        }

        .input-group {
            margin-bottom: 20px;
            text-align: left;
            position: relative; /* パスワード表示切替アイコンのために必要 */
        }

        .input-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }

        .input-group input[type="text"],
        .input-group input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            box-sizing: border-box; /* paddingを含めた幅にする */
        }
        
        /* パスワード入力欄にアイコンを配置するための調整 */
        .password-input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }
        
        .password-input-wrapper input {
            padding-right: 40px; /* アイコン分のスペースを確保 */
        }

        .toggle-password {
            position: absolute;
            right: 10px;
            cursor: pointer;
            color: #888;
            font-size: 1.2em;
            user-select: none;
        }

        .login-button {
            background-color: #007bff;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 18px;
            width: 100%;
            transition: background-color 0.3s ease;
            margin-top: 10px;
        }

        .login-button:hover {
            background-color: #0056b3;
        }
        
        .error-message {
            color: #dc3545; /* 赤文字のエラーメッセージ */
            font-size: 14px;
            margin-top: 10px;
            text-align: center;
            min-height: 20px; /* メッセージがないときもレイアウト崩れを防ぐ */
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>ログイン画面</h1>
        <form id="loginForm" action = "LoginServlet" method = "post">
            <div class="input-group">
                <label for="user_id">学籍番号または教師ID</label>
                <input type="text" id="user_id" name="user_id" required>
            </div>
            <div class="input-group">
                <label for="password">パスワード</label>
                <div class="password-input-wrapper">
                    <input type="password" id="password" name="password" required>
                    <span class="toggle-password" id="togglePassword">&#128065;</span> </div>
            </div>
            
            <c:if test="${not empty login_error_msg }">
            	<p class="error-message" id="login_error_msg">${login_error_msg }</p>
			</c:if>
			
            <button type="submit" class="login-button">ログイン</button>
        </form>
    </div>

    <script>
        const passwordInput = document.getElementById('password');
        const togglePassword = document.getElementById('togglePassword');

        // パスワード表示/非表示機能
        togglePassword.addEventListener('click', function () {
            const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordInput.setAttribute('type', type);
            
            // アイコンの切り替え (👁️ <-> 🔒 をシミュレート)
            this.textContent = type === 'password' ? '\u{1F441}' : '\u{1F512}'; // 👁️ or 🔒
        });

        
    </script>
</body>
</html>