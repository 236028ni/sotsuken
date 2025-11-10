<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>授業スケジュール確認画面</title>

<style>
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f4f4;
}

.container {
    width: 100%;
    margin: 0;
    background-color: white;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    box-sizing: border-box; 
}

.schedule-area {
    flex-grow: 1;
    padding: 15px;
}

.table-wrapper {
    overflow-x: auto;
    width: 100%;
    margin-bottom: 20px;
}

#scheduleTable {
    border-collapse: collapse;
    width: 100%;
    table-layout: fixed;
    font-size: 14px;
    min-width: 500px;
}

#scheduleTable th, #scheduleTable td {
    border: 1px solid #ccc;
    padding: 8px;
    text-align: center;
    height: 55px;
    position: relative;
    vertical-align: middle;
    word-wrap: break-word;
}

#scheduleTable th {
    background-color: #e9e9e9;
}

.cell.filled {
    background-color: #f9f9f9;
}

/* 戻るボタンのスタイル */
.action-button {
    /* ▼ 変更：元のスタイルに戻しました ▼ */
    padding: 10px 20px;
    cursor: pointer;
    background-color: #6c757d;
    color: white;
    border: none;
    border-radius: 4px;
    /* width: 100% などを削除 */
}
</style>
</head>

<body>

<div class="container">
    <div class="schedule-area">
        <h2>授業スケジュール</h2>
        
        <div class="table-wrapper">
            <table id="scheduleTable">
                <thead>
                    <tr>
                        <th></th>
                        <th>月曜</th>
                        <th>火曜</th>
                        <th>水曜</th>
                        <th>木曜</th>
                        <th>金曜</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1限目</td>
                        <td class="cell filled">システム開発</td>
                        <td class="cell filled">ゼミ</td>
                        <td class="cell empty"></td>
                        <td class="cell empty"></td>
                        <td class="cell empty"></td>
                    </tr>
                    <tr>
                        <td>2限目</td>
                        <td class="cell filled">セキュリティ</td>
                        <td class="cell filled">卒業研究</td>
                        <td class="cell empty"></td>
                        <td class="cell empty"></td> 
                        <td class="cell empty"></td>
                    </tr>
                    <tr>
                        <td>3限目</td>
                        <td class="cell empty"></td>
                        <td class="cell empty"></td>
                        <td class="cell filled">国試対策</td>
                        <td class="cell empty"></td>
                        <td class="cell empty"></td>
                    </tr>
                    <tr>
                        <td>4限目</td>
                        <td class="cell empty"></td>
                        <td class="cell empty"></td>
                        <td class="cell empty"></td>
                        <td class="cell empty"></td>
                        <td class="cell empty"></td>
                    </tr>
                </tbody>
            </table>
        </div>
        
        <button id="backButton" class="action-button">戻る</button>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', () => {
    // 「戻る」ボタンのイベント
    document.getElementById('backButton').addEventListener('click', () => {
        alert('「戻る」処理を実行します。');
        // 実際の戻る処理（例: history.back(); や location.href = '...';）
    });
});
</script>

</body>
</html>