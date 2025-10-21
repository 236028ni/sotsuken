<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理者メニュー</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            background-color: #f0f0f0; /* 背景色を追加 */
        }

        .admin-menu-container {
            width: 400px;
            padding: 20px;
            border: 1px solid #ccc;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: relative; /* ログアウトボタン配置のために必要 */
        }

        h1 {
            font-size: 1.2em;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
            margin-top: 0;
            margin-bottom: 20px;
        }

        .menu-item a {
            display: block;
            text-align: center;
            padding: 15px 0;
            margin: 20px 0;
            font-size: 1.1em;
            color: #cc0000; /* 画像に合わせた赤っぽい色 */
            text-decoration: none; /* 下線を非表示 */
            border: 1px solid transparent; /* ホバー効果のために透明な枠線を用意 */
            transition: background-color 0.3s;
        }

        .menu-item a:hover {
            background-color: #f9f9f9;
            border-color: #ddd;
        }

        .logout-link {
            position: absolute;
            bottom: 10px; /* 下からの位置 */
            right: 15px; /* 右からの位置 */
            font-size: 1em;
            color: #333; /* 標準的な色 */
            text-decoration: none;
            padding: 5px;
        }

        .logout-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="admin-menu-container">
        <h1>管理者メニュー</h1>

        <div class="menu-item">
            <form action = "Account_management_Servlet" method = "post">
            	アカウント管理
            </form>
        </div>

        <div class="menu-item">
            <form action = "Data_management_Servlet" method = "post">
            	データ集計（保留）
            </form>
        </div>

        <div class="menu-item">
            <form action = "room_log_management_Servlet" method = "post">
            	入退室ログ管理
            </form>
        </div>
        
        <a href="Logout.html" class="logout-link">ログアウト</a>
    </div>
</body>
</html>