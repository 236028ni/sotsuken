<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <title>アカウント追加</title>
   <style>
       /* ======================================== */
       /* 授業スケジュール (ターゲット) のスタイルを適用 */
       /* ======================================== */
       body {
           font-family: Arial, sans-serif;
           margin: 0;
           padding: 0;
           background-color: #f4f4f4;
       }
       .container {
           display: flex;
           max-width: 1200px;
           min-height: 80vh; /* 高さを確保 */
           margin: 20px auto;
           background-color: white;
           box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
           position: relative; /* サイドメニューの基準 */
           overflow: hidden; /* サイドメニューではみ出ないよう */
       }
       .schedule-area { /* メインコンテンツエリア (フォーム画面) */
           flex-grow: 1;
           padding: 20px;
       }
      
       /* サイドメニュー (確認・完了画面) */
       .side-menu {
           width: 350px; /* 幅をフォームに合わせる */
           min-height: 100%;
           position: absolute;
           right: 0;
           top: 0;
           height: 100%;
           background-color: white;
           box-shadow: -5px 0 15px rgba(0, 0, 0, 0.1);
           transition: transform 0.3s ease;
           transform: translateX(100%); /* 初期状態は隠す */
           padding: 20px;
           box-sizing: border-box;
           z-index: 10;
       }
       .side-menu.active {
           transform: translateX(0); /* 表示状態 */
       }
       .close-button {
           position: absolute;
           top: 10px;
           right: 15px;
           font-size: 24px;
           cursor: pointer;
           color: #999;
       }
       .menu-content h2 {
           font-size: 1.8em;
           margin-bottom: 30px;
           text-align: center;
       }
       .menu-content h3 {
           border-bottom: 2px solid #ddd;
           padding-bottom: 5px;
           margin-top: 20px;
       }
       .menu-content h4 {
           font-size: 1.1em;
           color: #555;
           margin-top: 0;
       }
      
       /* フォーム入力 */
       .form-group {
           margin-bottom: 25px;
       }
       .form-group label {
           display: block;
           margin-bottom: 5px;
           font-size: 0.9em;
           color: #555;
       }
       .form-group input[type="text"],
       .form-group input[type="password"],
       .form-group input[type="file"] {
           width: 100%;
           padding: 10px;
           border: 1px solid #ccc;
           box-sizing: border-box;
           border-radius: 4px; /* 角を丸める */
       }
       /* 確認画面の表示 */
       .display-label {
           display: block;
           margin-top: 15px;
           font-size: 0.9em;
           color: #888;
       }
       .display-value {
           font-size: 1.1em;
           font-weight: bold;
           border-bottom: 1px dashed #eee;
           padding-bottom: 5px;
           margin-bottom: 15px;
           word-wrap: break-word;
       }
       #display_add_photo_preview {
           max-width: 100%;
           max-height: 120px;
           object-fit: cover;
           border: 1px solid #eee;
           margin-top: 5px;
           display: none;
       }
      
       /* ボタン類 (ターゲットの .action-button をベース) */
       .footer-buttons {
           display: flex;
           justify-content: space-between;
           margin-top: 30px;
       }
       .action-button {
           padding: 10px 15px;
           cursor: pointer;
           color: white;
           border: none;
           border-radius: 4px;
           font-size: 1em;
           width: 120px;
           text-align: center;
           text-decoration: none;
       }
      
       .action-button.back-button,
       .action-button.menu-button {
            background-color: #6c757d; /* ターゲットのグレー */
       }
       .action-button.complete-button {
            background-color: #2196F3; /* ターゲットの青 */
       }
        .action-button.continue-button {
            background-color: #4CAF50; /* ターゲットの緑 */
       }
       /* サイドメニュー内のボタン配置 */
       .side-menu .footer-buttons {
           position: absolute;
           bottom: 20px;
           left: 20px;
           right: 20px;
       }
       /* メインエリアのボタン配置 */
       .schedule-area .footer-buttons {
           padding-top: 20px;
           border-top: 1px solid #eee;
       }
      
       /* メニューコンテンツの表示制御 */
       .menu-content {
           display: none; /* 初期状態は非表示 */
       }
   </style>
</head>
<body>
   <div class="container">
      
       <div id="add-screen" class="schedule-area">
           <h2>アカウント追加</h2>
           <form id="add-form">
           
           		<label>
                   <input type="radio" name="add_target" value="teacher"checked>講師
               </label>
               <label>
                   <input type="radio" name="add_target" value="student">学生
               </label>
               
               <div class="form-group">
                   <label for="add_id">ID・番号</label>
                   <input type="text" id="add_user_id" required>
               </div>
               <div class="form-group">
                   <label for="add_name">名前</label>
                   <input type="text" id="add_name" required>
               </div>
               <div class="form-group">
                   <label for="add_email">メールアドレス</label>
                   <input type="text" id="add_email" required>
               </div>
               <div class="form-group">
                   <label for="add_phone">電話番号</label>
                   <input type="text" id="add_phone" required>
               </div>
               <div class="form-group">
                   <label for="add_photo">写真</label>
                   <input type="file" id="add_photo_path" accept="image/*">
               </div>
               <div class="form-group">
                   <label for="add_pass">パスワード(仮)</label>
                   <input type="password" id="add_password" required>
               </div>
           </form>
           <div class="footer-buttons">
               <button type="button" class="action-button back-button" onclick="goBackToManagement()">戻る</button>
               <button type="submit" form="add-form" class="action-button complete-button">確認へ進む</button>
           </div>
       </div>
       <div id="sideMenu" class="side-menu">
           <div id="closeMenu" class="close-button">&times;</div>
          
           <div id="confirm-screen" class="menu-content">
               <h3>追加確認</h3>
               <h4>これで登録しますか</h4>
               <span class="display-label">ID・番号</span>
               <span id="display_add_id" class="display-value"></span>
               <span class="display-label">名前</span>
               <span id="display_add_name" class="display-value"></span>
               <span class="display-label">メールアドレス</span>
               <span id="display_add_email" class="display-value"></span>
               <span class="display-label">電話番号</span>
               <span id="display_add_phone" class="display-value"></span>
               <span class="display-label">写真</span>
               <span id="display_add_photo_name" class="display-value"></span>
               <img id="display_add_photo_preview" src="" alt="写真プレビュー">
               <span class="display-label">パスワード(仮)</span>
               <span id="display_add_pass" class="display-value"></span>
               <div class="footer-buttons">
                   <button type="button" class="action-button back-button" onclick="closeSideMenu()">戻る</button>
                   <button type="button" class="action-button complete-button" onclick="showMenuContent('complete-screen')">完了</button>
               </div>
           </div>
           <div id="complete-screen" class="menu-content">
               <h2>登録完了</h2>
               <div class="footer-buttons">
                   <div class="menu-item">
			            <form action="Redirect_Account_management_Servlet" method = "post">
			            	<button type = "submit" class = "back-button">戻る</button>
			           	</form>
			        </div>
                   <button type="button" class="action-button continue-button" onclick="continueAdding()">続けて登録</button>
               </div>
           </div>
       </div>
   </div>
   <script>
   (function() {
       // 操作対象のDOM要素を取得
       const radioButtons = document.querySelectorAll('input[name="add_target"]');
       const targetDiv = document.getElementById('targetDiv');

       // 表示/非表示を切り替える関数
       function toggleVisibility() {
           // 現在チェックされているラジオボタンの値を取得
           const selectedValue = document.querySelector('input[name="visibilityToggle"]:checked').value;

           if (selectedValue === 'show') {
               // A (show) が選択された場合 -> 表示
               targetDiv.style.display = 'block';
           } else {
               // B (hide) が選択された場合 -> 非表示
               targetDiv.style.display = 'none';
           }
       }

       // 各ラジオボタンに 'change' イベントリスナーを追加
       radioButtons.forEach(radio => {
           radio.addEventListener('change', toggleVisibility);
       });

       // ページ読み込み時に初期状態を反映 (Aが 'checked' なので表示される)
       // もしBをデフォルト(checked)にする場合は、この呼び出しが非表示の初期設定として機能します。
       toggleVisibility();
   })();
       const sideMenu = document.getElementById('sideMenu');
       const closeMenuButton = document.getElementById('closeMenu');
       const confirmScreen = document.getElementById('confirm-screen');
       const completeScreen = document.getElementById('complete-screen');
      
       // メニュー内のコンテンツを切り替える関数
       function showMenuContent(screenId) {
           confirmScreen.style.display = 'none';
           completeScreen.style.display = 'none';
           document.getElementById(screenId).style.display = 'block';
       }
       // サイドメニューを閉じる関数
       function closeSideMenu() {
           sideMenu.classList.remove('active');
       }
       // クローズボタン「×」のイベント
       closeMenuButton.addEventListener('click', closeSideMenu);
       // フォーム送信（追加画面の「確認へ進む」ボタン）時の処理
       document.getElementById('add-form').addEventListener('submit', function(e) {
           e.preventDefault();
           // 1. フォームから値を取得
           const addId = document.getElementById('add_id').value;
           const addName = document.getElementById('add_name').value;
           const addEmail = document.getElementById('add_email').value;
           const addPhone = document.getElementById('add_phone').value;
           const addPass = document.getElementById('add_pass').value;
           const photoInput = document.getElementById('add_photo');
           const photoFile = photoInput.files[0];
           // 2. 確認画面(サイドメニュー)にデータを反映
           document.getElementById('display_add_id').textContent = addId;
           document.getElementById('display_add_name').textContent = addName;
           document.getElementById('display_add_email').textContent = addEmail;
           document.getElementById('display_add_phone').textContent = addPhone;
           document.getElementById('display_add_pass').textContent = '********';
          
           const photoNameDisplay = document.getElementById('display_add_photo_name');
           const photoPreview = document.getElementById('display_add_photo_preview');
           // --- ★ここから修正 ---
          
           // ★処理開始時に、まずプレビューをリセットする
           photoPreview.src = '';
           photoPreview.style.display = 'none';
           if (photoFile) {
               // ファイルが選択されている場合
               photoNameDisplay.textContent = photoFile.name;
              
               const reader = new FileReader();
               // ★成功時の処理
               reader.onload = function(e) {
                   // 読み込み結果が有効か確認
                   if (e.target.result) {
                       photoPreview.src = e.target.result;
                       photoPreview.style.display = 'block';
                   } else {
                       photoNameDisplay.textContent = 'ファイルの読み込みに失敗';
                   }
               };
               // ★エラーハンドリングを追加
               reader.onerror = function(e) {
                   console.error("FileReader error: ", e);
                   photoNameDisplay.textContent = 'ファイルの読み込みエラー';
               };
               // 読み込み開始
               reader.readAsDataURL(photoFile);
          
           } else {
               // ファイルが選択されていない場合
               photoNameDisplay.textContent = 'なし';
               // (リセットは上で実行済み)
           }
           // --- ★修正ここまで ---
           // 3. メニュー内容を「確認画面」にして表示
           showMenuContent('confirm-screen');
          
           // 4. サイドメニューをスライドイン
           sideMenu.classList.add('active');
       });
       // 登録完了画面の「続けて登録」ボタンの処理
       function continueAdding() {
           // フォームをリセット
           document.getElementById('add-form').reset();
          
           // プレビューをリセット
           document.getElementById('display_add_photo_name').textContent = '';
           document.getElementById('display_add_photo_preview').src = '';
           document.getElementById('display_add_photo_preview').style.display = 'none';
           // サイドメニューを閉じる
           closeSideMenu();
       }
   </script>
</body>
</html>