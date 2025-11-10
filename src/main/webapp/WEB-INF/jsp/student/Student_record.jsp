<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>出欠記録</title>
    <style>
        body {
            font-family: sans-serif;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            background-color: #f0f0f0;
            margin: 0;
            padding-top: 20px;
        }

        .attendance-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 350px;
            max-height: 90vh; /* Max height to enable scrolling for logs */
            overflow-y: auto; /* Enable vertical scrolling for content */
            box-sizing: border-box;
        }

        h1 {
            font-size: 22px;
            margin-bottom: 25px;
            color: #333;
            text-align: left;
        }

        .input-group {
            margin-bottom: 20px;
        }

        .input-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
            font-size: 15px;
        }

        .input-group input[type="date"] {
            width: calc(100% - 20px);
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            background-color: white;
            appearance: none;
            background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%22292.4%22%20height%3D%22292.4%22%3E%3Cpath%20fill%3D%22%23000000%22%20d%3D%22M287%2C114.7L159.9%2C241.8c-2.4%2C2.4-5.5%2C3.6-8.7%2C3.6s-6.3-1.2-8.7-3.6L5.4%2C114.7c-4.8-4.8-4.8-12.5%2C0-17.3c4.8-4.8%2C12.5-4.8%2C17.3%2C0l130.8%2C130.8l130.8-130.8c4.8-4.8%2C12.5-4.8%2C17.3%2C0C291.8%2C102.2%2C291.8%2C109.9%2C287%2C114.7z%22%2F%3E%3C%2Fsvg%3E');
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 12px;
            padding-right: 30px;
        }

        .calendar-display {
            text-align: center;
            margin-top: 10px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            background-color: #f9f9f9;
            color: #777;
        }

        .log-display {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }

        .log-display h2 {
            font-size: 18px;
            color: #333;
            margin-bottom: 15px;
            text-align: left;
        }

        .log-entry {
            background-color: #fefefe;
            border: 1px solid #eee;
            border-radius: 4px;
            padding: 12px 15px;
            margin-bottom: 10px;
            font-size: 15px;
            color: #444;
            line-height: 1.5;
            text-align: left;
        }

        .log-entry:last-child {
            margin-bottom: 0;
        }

        .back-button {
            background-color: #6c757d;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            max-width: 150px;
            margin-top: 30px;
            transition: background-color 0.3s ease;
        }

        .back-button:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>
    <div class="attendance-container">
        <h1>出欠記録</h1>

        <div class="input-group">
            <label for="recordDate">日付</label>
            <input type="date" id="recordDate" name="recordDate">
            <div class="calendar-display">YYYY/MM/DD</div>
        </div>

        <div class="log-display">
            <h2>入退室ログ</h2>
            <div class="log-entry">
                〇〇時〇〇分〇〇教室退室
            </div>
            <div class="log-entry">
                〇〇時〇〇分〇〇教室入室
            </div>
            <div class="log-entry">
                〇〇時〇〇分〇〇教室退室
            </div>
            <div class="log-entry">
                〇〇時〇〇分〇〇教室入室
            </div>
            </div>

        <button class="back-button" onclick="history.back()">戻る</button>
    </div>

    <script>
        // Example JavaScript to update the displayed date from the date input
        const recordDateInput = document.getElementById('recordDate');
        const calendarDisplay = document.querySelector('.calendar-display');

        recordDateInput.addEventListener('change', (event) => {
            if (event.target.value) {
                const date = new Date(event.target.value);
                const year = date.getFullYear();
                const month = (date.getMonth() + 1).toString().padStart(2, '0');
                const day = date.getDate().toString().padStart(2, '0');
                calendarDisplay.textContent = `${year}/${month}/${day}`;
                // In a real application, you'd trigger an AJAX call here to fetch logs for this date
                // For this example, we're just updating the display.
            } else {
                calendarDisplay.textContent = 'YYYY/MM/DD';
            }
        });

        // Initial set if a default date is provided
        if (recordDateInput.value) {
            recordDateInput.dispatchEvent(new Event('change'));
        }
    </script>
</body>
</html>
