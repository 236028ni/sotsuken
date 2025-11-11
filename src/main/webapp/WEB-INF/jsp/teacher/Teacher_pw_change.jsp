<%@ page import = "java.util.*,model.UserBean,model.TeacherBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var = "teacher" value = "${sessionScope.teacher }"/>
<c:set var = "error_msg" value = "${sessionScope.error_msg }"/>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>T.パスワード変更</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
<style>
  body {
    font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
    background: #f4f7fa;
    margin: 0;
    padding: 40px 20px;
    display: flex;
    justify-content: center;
  }

  .container {
    background: #fff;
    padding: 30px 20px;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    max-width: 360px;
    width: 90%;
    box-sizing: border-box;
  }

  h2 {
    text-align: center;
    color: #333;
    margin-bottom: 30px;
    font-weight: 700;
  }

  label {
    display: block;
    margin-bottom: 15px;
    color: #555;
    font-weight: 600;
  }

  .input-wrapper {
    position: relative;
    margin-bottom: 20px;
  }

  input[type="password"], input[type="text"] {
    width: 100%;
    padding: 12px 40px 12px 12px;
    font-size: 16px;
    border: 1.8px solid #ccc;
    border-radius: 6px;
    outline-offset: 2px;
    transition: border-color 0.3s;
    box-sizing: border-box;
  }

  input[type="password"]:focus, input[type="text"]:focus {
    border-color: #0078d4;
    outline: none;
  }

  /* ブラウザのデフォルトパスワード表示切替ボタンを非表示に */
  input[type="password"]::-webkit-password-toggle-button {
    display: none;
  }
  input[type="password"] {
    -moz-appearance: textfield; /* Firefox */
  }
  input[type="password"]::-ms-reveal {
    display: none; /* IE */
  }

  .toggle-pw {
    position: absolute;
    right: 12px;
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    color: #888;
    font-size: 18px;
    transition: color 0.3s;
  }

  .toggle-pw:hover {
    color: #0078d4;
  }

  .btn-wrapper {
    margin-top: 30px;
    display: flex;
    justify-content: space-between;
  }

  button {
    padding: 12px 28px;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    cursor: pointer;
    font-weight: 600;
    transition: background-color 0.3s;
  }

  button[type="submit"] {
    background-color: #0078d4;
    color: white;
  }

  button[type="submit"]:hover {
    background-color: #005fa3;
  }

  button#back-button {
    background-color: #ddd;
    color: #444;
  }

  button#back-button:hover {
    background-color: #bbb;
  }

  /* 完了画面のスタイル */
  #completeScreen {
    display: none;
    text-align: center;
    padding: 30px 20px;
  }

  #completeScreen > div {
    border: 1px solid #ccc;
    padding: 40px 20px;
    margin-bottom: 30px;
    border-radius: 6px;
    font-weight: 600;
    color: #333;
    font-size: 18px;
    width: 220px;
    margin-left: auto;
    margin-right: auto;
  }

  #home-button {
    background-color: #0078d4;
    color: white;
    width: 100%;
  }

  #home-button:hover {
    background-color: #005fa3;
  }
  
  /* ▼▼▼ 以下を追加 ▼▼▼ */
  .error-message {
    color: #d93025; /* エラー用の赤色 */
    font-size: 14px;
    font-weight: 600;
    margin-top: 5px; /* 上の要素との余白 */
    display: none; /* デフォルトでは非表示 */
  }
</style>
</head>
<body>

<div class="container" id="formScreen">
  <h2>T.パスワード変更</h2>
  <c:if test = "${not empty error_msg }">
  <span id="password_error" class="error-message" style="display: block;">${error_msg }</span>
</c:if>
	
  <form action = "Teacher_pw_change_Servlet" method = "post" id="password_form" novalidate>
    <label for="current_password">現在のパスワード</label>
    <div class="input-wrapper">
      <input type="password" id="current_password" name = "current_password" required autocomplete="current_password" />
      <i class="fa-solid fa-eye toggle-pw" data-target="current_password"></i>
    </div>

    <label for="new_password">新しいパスワード</label>
    <div class="input-wrapper">
      <input type="password" id="new_password" name = "new_password"   required autocomplete="new_password" />
      <i class="fa-solid fa-eye toggle-pw" data-target="new_password"></i>
    </div>

    <label for="confirm_password">新しいパスワード（確認）</label>
    <div class="input-wrapper">
      <input type="password" id="confirm_password" name  = "confirm_password"  required autocomplete="new_password" />
      <i class="fa-solid fa-eye toggle-pw" data-target="confirm_password"></i>
    </div>
    <span id="password_match_error" class="error-message"></span>
	
	<input type = "hidden" id = "user_id" name = "user_id" value = "${student.getUser_id() }">
	
    <div class="btn-wrapper">
      <button type="submit">確認</button>
    </div>
  </form>
  <form action = "Redirect_Teacher_mypage_Servlet" method = "post">
  	<button type="submit" id="backBtn">戻る</button>
  </form>
</div>

<script>
// ページのHTMLがすべて読み込まれてからスクリプトを実行する
document.addEventListener("DOMContentLoaded", () => {

  // --- 必要な要素を取得 ---
  const form = document.getElementById("password_form");
  const newPasswordInput = document.getElementById("new_password");
  const confirmPasswordInput = document.getElementById("confirm_password");
  const passwordErrorSpan = document.getElementById("password_match_error");
  const submitButton = form.querySelector("button[type='submit']");
  const toggleIcons = document.querySelectorAll(".toggle-pw");
  

  // --- 機能1: パスワード一致確認 ---
  // 「新しいパスワード」と「確認用パスワード」の両方に入力があるたびにチェックする
  
  function validatePasswords() {
  const newPW = newPasswordInput.value;
  const confirmPW = confirmPasswordInput.value;

  // 確認用が入力されていて、かつ新しいパスワードと一致しない場合
  if (confirmPW && newPW !== confirmPW) {
    passwordErrorSpan.textContent = "新しいパスワードが一致しません。";
    passwordErrorSpan.style.display = "block"; // ★ 追加：エラーを表示
    submitButton.disabled = true; // 送信ボタンを無効化
  } else {
    passwordErrorSpan.textContent = ""; // エラーをクリア
    passwordErrorSpan.style.display = "none"; // ★ 追加：エラーを非表示
    submitButton.disabled = false; // 送信ボタンを有効化
  }
}

  // 両方の入力欄に 'input' (入力) イベントリスナーを追加
  newPasswordInput.addEventListener("input", validatePasswords);
  confirmPasswordInput.addEventListener("input", validatePasswords);

  
  // --- 機能2: パスワードの表示/非表示切り替え ---
  toggleIcons.forEach(icon => {
    icon.addEventListener("click", () => {
      // data-target属性に指定されたID（current_passwordなど）を取得
      const targetInputId = icon.dataset.target;
      const targetInput = document.getElementById(targetInputId);

      if (targetInput.type === "password") {
        // パスワード -> テキスト に変更
        targetInput.type = "text";
        icon.classList.remove("fa-eye");
        icon.classList.add("fa-eye-slash"); // アイコンを「閉じた目」に変更
      } else {
        // テキスト -> パスワード に変更
        targetInput.type = "password";
        icon.classList.remove("fa-eye-slash");
        icon.classList.add("fa-eye"); // アイコンを「開いた目」に変更
      }
    });
  });

});
</script>
</body>
</html>