<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>アカウント管理</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            background-color: #f0f0f0;
        }

        .account-management-container {
            width: 350px; /* メニューの幅を調整 */
            padding: 20px;
            border: 1px solid #ccc;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h1 {
            font-size: 1.2em;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
            margin-top: 0;
            margin-bottom: 30px; /* メニューとの間隔を広げる */
        }

        .menu-item a {
            display: block;
            text-align: center;
            padding: 25px 0; /* 上下のパディングを広く */
            margin: 20px 0;
            font-size: 1.2em;
            color: #333; /* 標準的な色 */
            text-decoration: none;
            border: 1px solid #eee;
            transition: background-color 0.3s, border-color 0.3s;
        }

        .menu-item a:hover {
            background-color: #f5f5f5;
            border-color: #ccc;
        }
        .link-button {
            display: block;
            text-align: center;
            padding: 15px 0; /* 上下のパディングを広く */
            margin: 20px 0;
            font-size: 1.1em;
            color: #cc0000; /* 標準的な色 */
            text-decoration: none;
            border: 1px solid #eee;
            transition: background-color 0.3s;
            
            width:100%;
            max-width:500px;
            background-color:transparent;
        }

        .link-button:hover{
            background-color: #f9f9f9;
            border-color: #ddd;
        }
        .back-button {
            display: block;
            text-align: center;
            padding: 15px 0; /* 上下のパディングを広く */
            margin: 20px 0;
            font-size: 1.1em;
            color: #cc0000; /* 標準的な色 */
            text-decoration: none;
            border: 1px solid #eee;
            transition: background-color 0.3s;
        }

        .back-button:hover{
            background-color: #f9f9f9;
            border-color: #ddd;
        }
    </style>
</head>
<body>
    <div class="account-management-container">
        <h1>アカウント管理</h1>

        
        <div class="menu-item">
            <form action = "Redirect_Account_list_Servlet" method = "post">
            	<button type = "submit" class = "link-button">一覧</button>
            </form>
        </div>

        <div class="menu-item">
            <form action = "Redirect_Account_add_Servlet" method = "post">
            	<button type = "submit" class = "link-button">追加</button>
           	</form>
        </div>

        <div class="menu-item">
            <form action="Redirect_Admin_menu_Servlet" method = "post">
            	<button type = "submit" class = "back-button">戻る</button>
           	</form>
        </div>
    </div>
</body>
</html>