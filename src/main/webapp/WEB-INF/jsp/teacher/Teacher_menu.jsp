<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>T.HOME</title>
    <style>
        body {
            font-family: sans-serif;
            margin: 0;
            background-color: #f8f8f8;
            display: flex;
            justify-content: center;
            align-items: flex-start; /* Align to top */
            min-height: 100vh;
        }

        .thome-container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 350px; /* Example width, similar to S.HOME */
            min-height: 500px; /* Example height */
            margin-top: 20px; /* Some spacing from the top */
            display: flex;
            flex-direction: column;
            padding: 20px; /* Add some padding inside the container */
            box-sizing: border-box; /* Include padding in width/height */
        }

        .user-info-header {
            display: flex;
            justify-content: flex-start; /* Align to start */
            align-items: center;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
            margin-bottom: 25px; /* Space below the header line */
        }

        .user-info-header span {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            flex: 1; /* Allow them to take equal space */
            text-align: center; /* Center text in their allocated space */
        }

        .user-info-header span:first-child {
            border-right: 1px solid #eee; /* Separator line between ID and 名前 */
            padding-right: 10px; /* Padding for the separator */
            margin-right: 10px; /* Margin for the separator */
        }


        .main-buttons {
            display: flex;
            flex-direction: column;
            align-items: center; /* Center buttons horizontally */
            flex-grow: 1; /* Take up available space */
            justify-content: center; /* Center buttons vertically */
        }

        .main-buttons button {
            background-color: #f0f0f0; /* Light gray button background */
            color: #555; /* Darker gray text color */
            padding: 15px 30px;
            border: 1px solid #ddd; /* Light gray border */
            border-radius: 5px;
            cursor: pointer;
            font-size: 18px;
            width: 80%; /* Make buttons take up most of the container width */
            max-width: 250px; /* Max width to prevent them from becoming too wide */
            margin-bottom: 20px; /* Space between buttons */
            transition: background-color 0.3s ease, border-color 0.3s ease;
        }

        .main-buttons button:last-child {
            margin-bottom: 0; /* No margin after the last button */
        }

        .main-buttons button:hover {
            background-color: #e0e0e0; /* Slightly darker gray on hover */
            border-color: #ccc;
        }
    </style>
</head>
<body>
    <div class="thome-container">
        <header class="user-info-header">
            <span>ID</span>
            <span>名前</span>
        </header>

        <main class="main-buttons">
            <button>マイページ</button>
            <button>出欠記録確認</button>
            <button>事前連絡</button>
        </main>
    </div>
</body>
</html>