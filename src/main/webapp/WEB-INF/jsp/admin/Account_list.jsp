<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>アカウント一覧</title>
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

        .list-container {
            width: 800px; /* 幅を広げ、一覧表が入るように調整 */
            padding: 20px;
            border: 1px solid #ccc;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: relative; /* 「戻る」ボタンのために必要 */
        }

        h1 {
            font-size: 1.2em;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
            margin-top: 0;
            margin-bottom: 20px;
        }
        
        /* 検索エリアのスタイル */
        .search-area {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px dashed #eee;
        }

        .search-area input[type="text"] {
            padding: 8px;
            border: 1px solid #ccc;
            width: 250px;
        }

        .search-area button {
            padding: 8px 15px;
            background-color: #f0f0f0;
            border: 1px solid #ccc;
            cursor: pointer;
        }

        /* 一覧テーブルのスタイル */
        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 50px; /* 戻るボタンのスペースを確保 */
        }

        .data-table th, .data-table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        .data-table th {
            background-color: #f5f5f5;
            text-align: center;
        }

        .data-table td.actions {
            text-align: center;
            width: 120px;
        }

        .data-table button {
            padding: 5px 8px;
            margin: 0 2px;
            cursor: pointer;
        }
        
        /* 戻るボタンのスタイル */
        .back-button {
            position: absolute;
            bottom: 10px;
            left: 20px;
            padding: 8px 15px;
            background-color: #ddd;
            border: 1px solid #ccc;
            text-decoration: none; /* <a>タグの場合 */
            color: #333;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="list-container">
        <h1>一覧</h1>

        <div class="search-area">
            <input type="text" placeholder="教師IDまたは学籍番号" id="search_input">
            <button id="search_button">検索</button>
            </div>

        <table class="data-table">
            <thead>
                <tr>
                    <th>教師ID</th>
                    <th>教師名</th>
                    <th>学籍番号</th>
                    <th>学生名</th>
                    <th class="actions">操作</th>
                </tr>
            </thead>
            <tbody id="account_list_body">
                <tr>
                    <td>T001</td>
                    <td>山田 太郎</td>
                    <td>-</td>
                    <td>-</td>
                    <td class="actions">
                        <a href="account_edit.html?id=T001"><button>変更</button></a>
                        <button onclick="deleteAccount('T001')">削除</button>
                    </td>
                </tr>
                <tr>
                    <td>-</td>
                    <td>-</td>
                    <td>S1001</td>
                    <td>佐藤 花子</td>
                    <td class="actions">
                        <a href="account_edit.html?id=S1001"><button>変更</button></a>
                        <button onclick="deleteAccount('S1001')">削除</button>
                    </td>
                </tr>
                </tbody>
        </table>

        <a href="account_management.html" class="back-button">戻る</a>
    </div>
    
    <script>
        // 【注意】これはHTML/CSSのみのサンプルです。
        // 実際の「検索機能」や「削除機能」は、JavaScriptとサーバー側の処理（PHP, Python, Rubyなど）が必要です。

        function deleteAccount(id) {
            if (confirm(id + 'のアカウントを削除してもよろしいですか？')) {
                // 削除処理のAPIエンドポイントにリクエストを送信する処理をここに記述
                console.log(id + 'を削除しました (実際の処理は未実装)');
            }
        }
        
        // 検索ボタンのクリックイベントに、検索APIへのリクエスト処理を記述します。
        // document.getElementById('search_button').addEventListener('click', function() {
        //     const query = document.getElementById('search_input').value;
        //     // 検索API (例: /api/accounts?query=xxx) を呼び出し、結果を一覧表に反映する処理
        // });
    </script>
</body>
</html>