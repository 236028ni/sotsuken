<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>送信完了</title>
    <style>
        body {
            font-family: sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f0f0f0;
            margin: 0;
        }

        .complete-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: center;
            box-sizing: border-box;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: center;
            min-height: 300px; /* Adjust height as needed */
        }

        .message-box {
            width: 180px; /* Approximately 60% of 300px width */
            height: 180px; /* Make it square */
            border: 1px solid #ccc; /* Border as shown in image */
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 20px;
            color: #333;
            margin-bottom: 30px; /* Space between message box and button */
        }

        .home-button {
            background-color: #007bff; /* Blue, similar to login/SHOME buttons */
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 18px;
            min-width: 120px;
            transition: background-color 0.3s ease;
        }

        .home-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="complete-container">
        <div class="message-box">
            パスワード変更完了
        </div>
        <form action = "Redirect_Student_menu_Servlet">
        	<button type = "submit" class = "home-button">HOMEへ戻る</button>
        </form>
    </div>
</body>
</html>