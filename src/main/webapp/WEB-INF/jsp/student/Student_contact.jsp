<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
            border-radius: 4px;
            resize: vertical;
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
        
        <form action = "Student_contact_Servlet" method = "POST"  id="contactForm">
            <div class="form-group">
                <label for="contact-date">日付</label>
                <input type="date" id="contact-date" name="contact-date" value="2025-10-21">
                <button type="button" class="calendar-button">カレンダー表示</button>
            </div>

            <div class="form-group">
                <label>欠課・欠席授業選択(複数可)</label>
                <div class="class-period-selection">
                    <div>
                        <input type="checkbox" id="period1" name="periods" value="1">
                        <label for="period1">1限目</label>
                    </div>
                    <div>
                        <input type="checkbox" id="period2" name="periods" value="2">
                        <label for="period2">2限目</label>
                    </div>
                    <div>
                        <input type="checkbox" id="period3" name="periods" value="3">
                        <label for="period3">3限目</label>
                    </div>
                    <div>
                        <input type="checkbox" id="period4" name="periods" value="4">
                        <label for="period4">4限目 <span style="font-size: 0.8em; color: #007bff;">(由貴)</span></label>
                    </div>
                    </div>
            </div>

            <div class="form-group">
                <label>事前・事後選択</label>
                <div class="radio-selection">
                    <div class="radio-option">
                        <input type="radio" id="pre-contact" name="time-type" value="pre" checked>
                        <label for="pre-contact">事前</label>
                    </div>
                    <div class="radio-option">
                        <input type="radio" id="post-contact" name="time-type" value="post">
                        <label for="post-contact">事後</label>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <label>理由選択</label>
                <div class="radio-selection">
                    <div class="radio-option">
                        <input type="radio" id="class-absence" name="reason-type" value="class-absence" checked>
                        <label for="class-absence">欠課</label>
                    </div>
                    <div class="radio-option">
                        <input type="radio" id="full-absence" name="reason-type" value="full-absence">
                        <label for="full-absence">欠席</label>
                    </div>
                    <div class="radio-option">
                        <input type="radio" id="early-leave" name="reason-type" value="early-leave">
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

            <div class="footer-buttons">
                <button type="button" class="back-button" onclick="history.back()">戻る</button>
                <button type="submit" class="send-button">送信</button>
            </div>
        </form>
    </div>

    <script>

        // 画像添付ボタンとファイル選択の連動
        document.querySelector('.file-upload-button').addEventListener('click', function(e) {
            document.getElementById('evidence-image').click();
        });
    </script>
</body>
</html>