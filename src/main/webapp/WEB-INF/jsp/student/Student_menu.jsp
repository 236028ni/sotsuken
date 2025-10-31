<%@ page import = "java.util.*,model.UserBean,model.StudentBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%
    	StudentBean student = (StudentBean)session.getAttribute("student");
    	String user_id = student.getUser_id();
    	session.setAttribute("user_id", user_id);
    %>
    <c:set var = "user_id" value = "${sessionScope.user_id }"/>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>S.HOME</title>
    <style>
        body {
            font-family: sans-serif;
            margin: 0;
            background-color: #f8f8f8;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            padding-top: 20px;
        }

        .shome-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 95%;
            max-width: 450px;
            min-height: 500px;
            margin-top: 20px;
            display: flex;
            flex-direction: column;
            overflow: hidden;
            box-sizing: border-box;
        }

        .shome-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
        }

        .user-info {
            font-size: 16px;
            color: #333;
        }

        .student-id {
            margin-right: 15px;
            font-weight: bold;
        }

        .hamburger-button {
            background: none;
            border: none;
            font-size: 28px;
            cursor: pointer;
            color: #555;
            padding: 5px;
            z-index: 1001;
        }

        .shome-main {
            flex-grow: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .qr-code-placeholder {
            width: 80%;
            padding-top: 80%; /* 1:1のアスペクト比を維持 */
            position: relative;
            max-width: 250px;
            border: 2px solid #ccc;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 36px;
            color: #777;
            background-color: #f9f9f9;
        }
        .qr-code-placeholder::before {
            content: "QR";
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .menu-overlay {
            position: fixed;
            top: 0;
            right: -100%; /* 全画面幅で隠す */
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            transition: right 0.3s ease-in-out;
            z-index: 999;
            display: flex;
            justify-content: flex-end; /* メニューを右端に配置 */
        }

        .menu-overlay.open {
            right: 0;
        }
        
        .menu-content {
            background-color: #fff;
            width: 75%; /* スマホでのメニュー幅 */
            max-width: 300px; /* PCでのメニュー幅を制限 */
            height: 100%;
            padding: 20px;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
        }

        .close-button {
            align-self: flex-end;
            background: none;
            border: 1px solid #ccc;
            padding: 8px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            margin-bottom: 30px;
            color: #555;
        }

        .menu-nav ul {
            list-style: none;
            padding: 0;
            margin: 0;
            flex-grow: 1;
        }

        .menu-nav li {
            margin-bottom: 15px;
        }

        .menu-nav a {
            text-decoration: none;
            color: #007bff;
            font-size: 18px;
            padding: 8px 0;
            display: block;
            transition: color 0.2s ease;
        }

        .logout-button {
            background-color: #dc3545;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 18px;
            width: 100%;
            margin-top: 30px;
            transition: background-color 0.3s ease;
        }
    </style>
</head>
<body>
    <div class="shome-container">
        <header class="shome-header">
            <div class="user-info">
                <span class="student-id">学籍番号：</span>
                <span class="student-name">名前：</span>
            </div>
            <button class="hamburger-button" id="hamburgerButton">
                &#9776;
            </button>
        </header>

        <p>以下のQRコードをリーダーにかざしてください</p>
        <img src="Qr_code_Servlet?text=${sessionScope.user_id }" alt="出席登録用QRコード">
        ※QRコードは（株）デンソーウェーブの登録商標です
        
    </div>

    <div class="menu-overlay" id="menuOverlay">
        <div class="menu-content">
            <button class="close-button" id="closeMenuButton">閉じる</button>
            <nav class="menu-nav">
                <ul>
                    <li><a href="#">メール</a></li>
                    <li><a href="#">マイページ</a></li>
                    <li><a href="#">事前連絡</a></li>
                    <li><a href="#">出欠記録</a></li>
                </ul>
            </nav>
            <button class="logout-button">ログアウト</button>
        </div>
    </div>

    <script>
        const hamburgerButton = document.getElementById('hamburgerButton');
        const menuOverlay = document.getElementById('menuOverlay');
        const closeMenuButton = document.getElementById('closeMenuButton');

        hamburgerButton.addEventListener('click', () => {
            menuOverlay.classList.add('open');
        });

        closeMenuButton.addEventListener('click', () => {
            menuOverlay.classList.remove('open');
        });

        menuOverlay.addEventListener('click', (event) => {
            if (event.target === menuOverlay) {
                menuOverlay.classList.remove('open');
            }
        });
    </script>
</body>
</html>
