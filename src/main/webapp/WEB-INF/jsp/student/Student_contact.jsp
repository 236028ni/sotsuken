<%@ page import = "model.StudentBean,model.UserBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	StudentBean student = (StudentBean)session.getAttribute("student");
	session.setAttribute("student",student);
%>
<c:set var = "student" value = "${sessionScope.student }"/>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>S.連絡</title>
    <style>
        body {
            font-family: sans-serif;
            margin: 0;
            background-color: #f0f0f0;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            padding-top: 20px;
        }

        .container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 95%;
            max-width: 400px;
            box-sizing: border-box;
            position: relative;
        }

        h1 {
            font-size: 20px;
            margin: 0 0 20px 0;
            font-weight: bold;
        }

        .form-group {
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .form-group:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        label {
            display: block;
            font-size: 14px;
            color: #555;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input[type="date"], .calendar-button {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-top: 5px;
            font-size: 16px;
        }

        .calendar-button {
            margin-top: 10px;
            background-color: #f8f9fa;
            cursor: pointer;
        }

        .class-period-selection {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .class-period-selection div {
            display: flex;
            align-items: center;
        }

        .class-period-selection input[type="checkbox"] {
            margin-right: 10px;
            transform: scale(1.2);
        }

        .radio-selection {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .radio-selection .radio-option {
            display: flex;
            align-items: center;
            font-weight: normal;
        }

        .radio-selection input[type="radio"] {
            margin-right: 10px;
            transform: scale(1.2);
        }

        textarea {
            width: 100%;
            height: 100px;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            resize: none;
            border-radius: 4px;
            font-size: 16px;
        }

        .file-upload-button {
            display: block;
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: white;
            text-align: center;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 5px;
            font-size: 16px;
        }

        .file-upload-button input[type="file"] {
            display: none;
        }
        
        /* 理由記述のラベルを調整 */
        .reason-description-label {
            margin-bottom: 10px;
        }

        .footer-buttons {
            display: flex;
            justify-content: space-between;
            padding-top: 20px;
        }

        .footer-buttons button {
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            min-width: 100px;
            border: none;
        }

        .back-button {
            background-color: #6c757d;
            color: white;
        }

        .send-button {
            background-color: #28a745;
            color: white;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>S.連絡</h1>
        
        <form action = "Student_contact_Servlet" method = "POST"  id="contactForm"enctype="multipart/form-data">
            <div class="form-group">
                <label for="request-date">日付</label>
                <input type="date" id="request-date" name="request-date"required>
            </div>

            <div class="form-group">
                <label>欠課・欠席授業選択(複数可)<br></label>
                <div class="class-period-selection">
                    <div>
                        <input type="checkbox" id="period1" name="period" value="1">
                        <label for="period1">1限目</label>
                    </div>
                    <div>
                        <input type="checkbox" id="period2" name="period" value="2">
                        <label for="period2">2限目</label>
                    </div>
                    <div>
                        <input type="checkbox" id="period3" name="period" value="3">
                        <label for="period3">3限目</label>
                    </div>
                    <div>
                        <input type="checkbox" id="period4" name="period" value="4">
                        <label for="period4">4限目 </label>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label>事前・事後選択</label>
                <div class="radio-selection">
                    <div class="radio-option">
                        <input type="radio" id="pre-contact" name="timing" value="before" checked>
                        <label for="pre-contact">事前</label>
                    </div>
                    <div class="radio-option">
                        <input type="radio" id="post-contact" name="timing" value="after">
                        <label for="post-contact">事後</label>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label>理由選択</label>
                <div class="radio-selection">
                	<div class="radio-option">
                        <input type="radio" id="class-absence" name="status" value="late" checked>
                        <label for="class-absence">遅刻（遅延の場合もこれを選択してください）</label>
                    </div>
                    <div class="radio-option">
                        <input type="radio" id="class-absence" name="status" value="class-absent" checked>
                        <label for="class-absence">欠課</label>
                    </div>
                    <div class="radio-option">
                        <input type="radio" id="full-absence" name="status" value="full-absence">
                        <label for="full-absence">欠席</label>
                    </div>
                    <div class="radio-option">
                        <input type="radio" id="early-leave" name="status" value="early-leave">
                        <label for="early-leave">早退</label>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label for="reason-description" class="reason-description-label">理由記述</label>
                <textarea id="reason-description" name="reason-description" placeholder="ここに理由を記入"></textarea>
            </div>

            <div class="form-group">
                <label>証明物</label>
                <label for="evidence-image" class="file-upload-button">画像を添付</label>
                <input type="file" id="evidence-image" name="evidence-image" accept="image/*">
                </div>
			
			<input type = "hidden" name = "student_id"  value = "${student.getUser_id() }"/>
			
            <div class="footer-buttons">
                <button type="submit" class="send-button">送信</button>
            </div>
        </form>
        <form action = "Redirect_Student_menu_Servlet" metod = "post">
        	<button type="submit" class="back-button" >戻る</button>
        </form>
    </div>

</body>
<script>
	//★★★日付選択時にその日のデータをデフォルトで表示するようにする★★★
	//ページの読み込みが完了したら実行
	document.addEventListener('DOMContentLoaded', function() {
	    
	    // 1. 今日の日付データを取得
	    const today = new Date();
	
	    // 2. 'YYYY-MM-DD' 形式にフォーマット
	    const year = today.getFullYear();
	    
	    // getMonth() は 0 (1月) から 11 (12月) で返ってくるため、+1 する
	    // padStart(2, '0') は、数字が1桁の場合に先頭を0で埋める (例: 5 -> 05)
	    const month = String(today.getMonth() + 1).padStart(2, '0');
	    
	    const day = String(today.getDate()).padStart(2, '0');
	
	    // 3. 結合して 'YYYY-MM-DD' 形式の文字列を作成
	    const formattedDate = `${year}-${month}-${day}`;
	
	    // 4. input要素を取得し、valueに設定
	    // HTMLで指定した id="dateInput" を使って要素を特定
	    const dateInput = document.getElementById('request-date');
	    
	    if (dateInput) {
	        dateInput.value = formattedDate;
	    }
	
	});
	// ★★★ 欠席の時は時限を選択しなくてもいいようにする ★★★

	// 1. 関連する要素を取得
	// 理由選択のラジオボタン（"欠課", "欠席", "早退"）
	const statusRadios = document.querySelectorAll('input[name="status"]');

	// 欠席（終日欠席）のラジオボタン
	const fullAbsenceRadio = document.getElementById('full-absence');

	// 時限選択のチェックボックスすべて
	const periodCheckboxes = document.querySelectorAll('input[name="period"]');

	// 2. 時限チェックボックスの有効/無効を切り替える関数を定義
	function updatePeriodCheckboxes() {
	    
	    // 「欠席」が選択されているかどうかを判定
	    const isFullAbsence = fullAbsenceRadio.checked;

	    // すべての時限チェックボックスをループ
	    periodCheckboxes.forEach(function(checkbox) {
	        // 「欠席」が選ばれていたら
	        if (isFullAbsence) {
	            // チェックボックスを無効化
	            checkbox.disabled = true;
	            // 既に付いていたチェックも外す
	            checkbox.checked = false;
	        } else {
	            // 「欠席」以外（欠課、早退）が選ばれていたら
	            // チェックボックスを有効化
	            checkbox.disabled = false;
	        }
	    });
	}

	// 3. 理由選択ラジオボタン（status）のどれかが変更されたら、常に関数を実行
	statusRadios.forEach(function(radio) {
	    radio.addEventListener('change', updatePeriodCheckboxes);
	});

	// 4. ページ読み込み時にも一度、初期状態（"欠課"が選択されている）で実行
//	    （これにより、"欠課"がデフォルトで選択されているため、チェックボックスは有効な状態で開始されます）
	updatePeriodCheckboxes();

	// ★★★ ここまで ★★★
	
	// ★★★ 欠席以外の時は時限のチェックがないと送信できないように ★★★
	// 1. フォーム自体を取得 (ID: contactForm)
	const contactForm = document.getElementById('contactForm');

	// 2. フォームの 'submit' (送信) イベントを監視
	contactForm.addEventListener('submit', function(event) {
	    
	    // 3. 「欠席」が選択されているか確認
	    // (fullAbsenceRadio は既存のコードで既に取得済み)
	    const isFullAbsence = fullAbsenceRadio.checked;

	    // 4. 「欠席」が選択されて *いない* 場合（遅刻、欠課、早退の場合）
	    if (!isFullAbsence) {
	        
	        // 5. 少なくとも1つの時限がチェックされているか調べる
	        // (periodCheckboxes も既存のコードで取得済み)
	        
	        // Array.from()でNodeListを配列に変換し、some()メソッドを使う
	        // some() は、配列のいずれかの要素が条件(checked)を満たせば true を返す
	        const isAtLeastOnePeriodChecked = Array.from(periodCheckboxes).some(checkbox => checkbox.checked);

	        // 6. もし1つもチェックされていなかったら
	        if (!isAtLeastOnePeriodChecked) {
	            // アラートを表示
	            alert('欠席以外の場合は、少なくとも1つの時限を選択してください。');
	            
	            // event.preventDefault() でフォームの送信をキャンセル
	            event.preventDefault(); 
	        }
	    }
	    
	    // 7. 「欠席」が選択されている場合は、if ブロックが実行されず、
	    //    preventDefault() も呼ばれないため、そのままフォームが送信されます。
	});
</script>
</html>