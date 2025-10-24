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
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; /* フォントをモダンなものに変更 */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            background-color: #f0f4f8; /* 背景色を少し明るく */
        }

        /* 画面内コンテナのサイズ調整 */
        .account-management-container {
            width: 400px; /* 幅を広げ、ゆとりを持たせる */
            padding: 30px;
            border: 1px solid #ddd;
            background-color: white;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* シャドウを強調 */
            border-radius: 8px; /* 角を丸く */
        }

        h1 {
            font-size: 1.5em; /* フォントサイズを大きく */
            text-align: center;
            border-bottom: 2px solid #007bff; /* メインカラーのライン */
            padding-bottom: 15px;
            margin-top: 0;
            margin-bottom: 30px; 
            color: #333;
        }

        /* 一覧・追加ボタンの共通スタイル */
        .link-button {
            display: block;
            width: 100%;
            padding: 20px 0; /* 上下のパディングを広く */
            margin: 15px 0; /* マージンを調整 */
            font-size: 1.3em;
            color: white; 
            text-decoration: none;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s, transform 0.1s;
        }

        .link-button:hover{
            transform: translateY(-2px); /* ホバーで少し浮き上がらせる */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        /* 一覧ボタンと追加ボタンの色を設定 */
        #list-button {
            background-color: #007bff; /* 青 */
        }
        #list-button:hover {
            background-color: #0056b3;
        }

        #add-button {
            background-color: #28a745; /* 緑 */
        }
        #add-button:hover {
            background-color: #1e7e34;
        }
        
        /* 戻るボタンのスタイルを調整 */
        .back-button {
            display: block;
            width: 100%;
            padding: 15px 0; 
            margin: 30px 0 0 0; /* 上のマージンを大きくして区切りを明確に */
            font-size: 1.1em;
            color: #6c757d; /* 落ち着いた灰色 */
            background-color: #f8f9fa; /* 薄い背景色 */
            border: 1px solid #dee2e6;
            border-radius: 6px;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .back-button:hover{
            background-color: #e2e6ea;
            color: #495057;
        }
    </style>
</head>
<body>
    <div class="account-management-container">
        <h1>アカウント管理メニュー</h1>

        
        <div class="menu-item">
            <form action = "Redirect_Teacher_list_Servlet" method = "post">
            	<button type = "submit" class = "link-button" id="list-button">講師一覧</button>
            </form>
        </div>
        
        <div class="menu-item">
            <form action = "Redirect_Student_list_Servlet" method = "post">
            	<button type = "submit" class = "link-button" id="list-button">学生一覧</button>
            </form>
        </div>

        <div class="menu-item">
            <form action = "Redirect_Account_add_Servlet" method = "post">
            	<button type = "submit" class = "link-button" id="add-button">追加</button>
           	</form>
        </div>

        <div class="menu-item">
            <form action="Redirect_Admin_menu_Servlet" method = "post">
            	<button type = "submit" class = "back-button">管理者メニューへ戻る</button>
           	</form>
        </div>
    </div>
</body>
</html>