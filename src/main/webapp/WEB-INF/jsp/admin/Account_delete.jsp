<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>アカウント削除</title>
    <style>
        /* -------------------- 基本スタイル (変更なし) -------------------- */
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            background-color: #f0f0f0;
        }

        .delete-container {
            width: 400px;
            padding: 30px;
            border: 1px solid #ccc;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: relative;
            transition: opacity 0.3s, filter 0.3s; 
        }

        .modal-active .delete-container {
            opacity: 0.5;
            filter: blur(1px);
            pointer-events: none;
        }
        
        h1 {
            font-size: 1.2em;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
            margin-top: 0;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .form-group input[type="text"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }
        
        .action-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 40px;
        }

        .action-buttons button,
        .action-buttons a {
            padding: 10px 20px;
            font-size: 1em;
            cursor: pointer;
            border: 1px solid #999;
            text-decoration: none;
            color: #333;
            background-color: #e0e0e0;
        }

        /* -------------------- モーダルウィンドウのスタイル (変更なし) -------------------- */

        .modal-overlay {
            display: none; 
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: white;
            padding: 40px;
            width: 300px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
            border: 1px solid #ccc;
        }

        .modal-content p {
            font-size: 1.2em;
            color: #cc0000;
            margin-bottom: 30px;
            font-weight: bold;
        }
        
        .modal-content h2 {
            font-size: 1.1em;
            font-weight: normal;
            margin: -20px 0 20px 0;
        }

        .modal-actions {
            display: flex; 
            justify-content: center;
            gap: 20px;
        }

        .modal-actions button {
            padding: 10px 20px;
            font-size: 1em;
            cursor: pointer;
            border-width: 2px;
            border-style: solid;
            /* *** 修正点: 横幅を 80px から 100px に拡大 *** */
            width: 100px; 
            margin: 0; 
        }

        #modal_yes {
            background-color: white;
            color: #cc0000;
            border-color: #cc0000;
        }

        #modal_no {
            background-color: white;
            color: #0000cc;
            border-color: #0000cc;
        }
    </style>
</head>
<body>
    <div class="delete-container" id="deleteContainer">
        <h1>アカウント削除</h1>

        <div class="form-group">
            <label for="selected_id_display">選択した番号・ID</label>
            <input type="text" id="selected_id_display" value="自動入力" readonly style="background-color: #f5f5f5;">
        </div>

        <div class="form-group">
            <label for="selected_name_display">選択した名前</label>
            <input type="text" id="selected_name_display" value="自動入力" readonly style="background-color: #f5f5f5;">
        </div>
        
        <div class="form-group">
            <label for="current_password">現在のパスワード</label>
            <input type="password" id="current_password" placeholder="パスワードを入力">
        </div>

        <div class="action-buttons">
            <a href="account_list.html" id="back_button">戻る</a>
            <button id="delete_confirm_button">削除</button>
        </div>
    </div>

    <div class="modal-overlay" id="deleteModal">
        <div class="modal-content">
            <h2>アカウント削除</h2> 
            <p>本当に削除しますか</p>
            <div class="modal-actions">
                <button id="modal_yes">はい</button>
                <button id="modal_no">いいえ</button>
            </div>
        </div>
    </div>
    
    <form action="delete_process.php" method="POST" id="deleteForm" style="display:none;">
        <input type="hidden" id="form_id_field" name="id" value="">
        <input type="hidden" id="form_password_field" name="password" value="">
    </form>


    <script>
        // URLのクエリパラメータ取得関数
        function getQueryParams() {
            const params = {};
            const queryString = window.location.search.substring(1);
            const regex = /([^&=]+)=([^&]*)/g;
            let m;
            while (m = regex.exec(queryString)) {
                params[decodeURIComponent(m[1])] = decodeURIComponent(m[2]);
            }
            return params;
        }

        const deleteContainer = document.getElementById('deleteContainer');
        const modal = document.getElementById('deleteModal');
        const deleteButton = document.getElementById('delete_confirm_button');
        const modalYes = document.getElementById('modal_yes');
        const modalNo = document.getElementById('modal_no');
        const passwordInput = document.getElementById('current_password');

        // ページロード時の処理
        window.onload = function() {
            const params = getQueryParams();
            const id = params['id'] || 'IDがありません';
            const name = params['name'] || '名前がありません';

            document.getElementById('selected_id_display').value = id;
            document.getElementById('selected_name_display').value = name;
            document.getElementById('form_id_field').value = id;
        };

        // 1. 「削除」ボタンでモーダルを表示
        deleteButton.addEventListener('click', function() {
            if (passwordInput.value.trim() === '') {
                alert('削除を確定するには現在のパスワードを入力してください。');
                return;
            }
            // モーダルを表示
            modal.style.display = 'flex';
            // 背後の画面を暗く、操作不可にする
            document.body.classList.add('modal-active');
        });

        // 2. モーダルで「はい」を押した場合
        modalYes.addEventListener('click', function() {
            document.getElementById('form_password_field').value = passwordInput.value;
            // 削除処理の実行
            document.getElementById('deleteForm').submit();
        });

        // 3. モーダルで「いいえ」を押した場合
        modalNo.addEventListener('click', function() {
            modal.style.display = 'none'; // モーダルを閉じる
            document.body.classList.remove('modal-active'); // 背後の画面を元に戻す
        });
    </script>
</body>
</html>
