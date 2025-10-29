<%@page import="java.util.*,dao.StudentDAO,model.UserBean,model.StudentBean,model.TeacherBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "student" value = "${sessionScope.student}"/>
<c:set var = "teacher" value = "${sessionScope.teacher}"/>
<c:set var = "admin" value = "${sessionScope.admin }"/>
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
            <label for="selected_id_display">${not empty student.user_id?student.user_id:teacher.user_id }</label>
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
	
	<!-- モーダルメニュー -->
    <div class="modal-overlay" id="deleteModal">
        <div class="modal-content">
            <h2>アカウント削除</h2> 
            
            <%-- ▼ 1. エラーメッセージ表示領域を追加 ▼ --%>
            <c:if test="${not empty admin_error}">
                <p style="color: red; font-weight: bold; font-size: 0.9em; margin-bottom: 15px;">
                    <c:out value="${admin_error}" />
                </p>
            </c:if>
            <%-- ▲ 1. ここまで ▲ --%>

            <p>削除を行うには管理者のIDとパスワードを入力してください</p>
            <div>
		        <label for="check_id">ID:</label>
		        <input type="text" id="check_id">
		    </div>
		    <div>
		        <label for="check_pw">PW:</label>
		        <input type="password" id="check_pw">
		    </div>
            <div class="modal-actions">
                <%-- ▼ 2. modal_yes の disabled 属性を削除 (もしあれば) ▼ --%>
                <button id="modal_yes">削除</button>
                <button id="modal_no">閉じる</button>
            </div>
        </div>
    </div>
    <%-- ▼ 3. フォームの送信先(action)をサーブレットに変更 ▼ --%>
    <form action="DeleteAccountServlet" method="POST" id="deleteForm" style="display:none;">
      
        
        <%-- (削除対象のID用: この例ではstudent/teacherのID。必要に応じて修正) --%>
        <input type="hidden" name="target_id" value="<c:out value='${not empty student.user_id ? student.user_id : teacher.user_id}' />">
        
        <%-- ▼ 4. 管理者ID/PWを送るための hidden フィールドを追加 ▼ --%>
        <input type="hidden" id="form_admin_id" name="admin_id" value="${admin.user_id }">
        <input type="hidden" id="form_admin_pw" name="admin_pw" value="${admin.password }">
    </form>
    
    


    <script>
        // --- 要素の取得 (エラー修正) ---
        const deleteButton = document.getElementById('delete_confirm_button');
        const passwordInput = document.getElementById('current_password');
        const modal = document.getElementById('deleteModal');
        const modalYes = document.getElementById('modal_yes');
        const modalNo = document.getElementById('modal_no');
        const modalCheckID = document.getElementById('check_id');
        const modalCheckPW = document.getElementById('check_pw');
        const deleteForm = document.getElementById('deleteForm');

        // 1. 「削除」ボタンでモーダルを表示
        deleteButton.addEventListener('click', function() {
            modal.style.display = 'flex';
            document.body.classList.add('modal-active');
        });

        // 2. モーダルで「はい」を押した場合
        modalYes.addEventListener('click', function() {
            // ▼ 5. フォームに「現在のPW」と「管理者ID/PW」をセット ▼
            document.getElementById('form_password_field').value = passwordInput.value;
            document.getElementById('form_admin_id').value = modalCheckID.value;
            document.getElementById('form_admin_pw').value = modalCheckPW.value;
            
            // 削除処理の実行 (サーブレットへ送信)
            deleteForm.submit();
        });

        // 3. モーダルで「いいえ」を押した場合
        modalNo.addEventListener('click', function() {
            modal.style.display = 'none';
            document.body.classList.remove('modal-active');
        });
     
        // ▼ 6. JavaScriptの検証ロジック (validateInputs) は全て削除 ▼
        // ( const inputA = ... , validateInputs() ... などを全て削除 )


        // ▼ 7. エラー時にモーダルを自動表示する処理 ▼
        (function() {
            // EL式を使って、サーバーから "adminError" が渡されたかチェック
            <c:if test="${not empty adminError}">
                // エラーがある場合、このJSコードがHTMLに出力される
                console.log("管理者エラーによりモーダルを自動表示します。");
                modal.style.display = 'flex';
                document.body.classList.add('modal-active');
            </c:if>
        })();
        
    </script>
</body>
</html>
