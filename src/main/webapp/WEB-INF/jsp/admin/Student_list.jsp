<%@page import="java.util.*,dao.ShiiresakiDAO,model.shiiresakiBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	StudentDAO sdao = new StudentDAO();
	List<studentBean>student_list = sdao.findall();
	session.setAttribute("student_list", student_list);
%>
<c:set var = "student_list" value = "${sessionScope.student_list }"/>
<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>アカウント一覧</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            background-color: #f0f0f0;
        }

        .list-container {
            width: 800px; /* 幅を広げ、一覧表が入るように調整 */
            padding: 20px;
            border: 1px solid #ccc;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            position: relative; /* 「戻る」ボタンのために必要 */
        }

        h1 {
            font-size: 1.2em;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
            margin-top: 0;
            margin-bottom: 20px;
        }
        
        /* 検索エリアのスタイル */
        .search-area {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px dashed #eee;
        }

        .search-area input[type="text"] {
            padding: 8px;
            border: 1px solid #ccc;
            width: 250px;
        }

        .search-area button {
            padding: 8px 15px;
            background-color: #f0f0f0;
            border: 1px solid #ccc;
            cursor: pointer;
        }

        /* 一覧テーブルのスタイル */
        .data-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 50px; /* 戻るボタンのスペースを確保 */
        }

        .data-table th, .data-table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        .data-table th {
            background-color: #f5f5f5;
            text-align: center;
        }

        .data-table td.actions {
            text-align: center;
            width: 120px;
        }

        .data-table button {
            padding: 5px 8px;
            margin: 0 2px;
            cursor: pointer;
        }
        
        /* 戻るボタンのスタイル */
        .back-button {
            position: absolute;
            bottom: 10px;
            left: 20px;
            padding: 8px 15px;
            background-color: #ddd;
            border: 1px solid #ccc;
            text-decoration: none; /* <a>タグの場合 */
            color: #333;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="list-container">
        <h1>一覧</h1>

        <div class="search-area">
        	<form action = "search_by_id_Servlet" method = "post">
	            <input type="text" placeholder="学籍番号" id="search_input" name = "in_text">
	            <button type = "submit" id="search_button">検索</button>
            </form>
         </div>

        <table class="data-table">
            <thead>
                <tr>
                    <th>学籍番号</th>
                    <th>学生名</th>
                    <th class="actions">操作</th>
                </tr>
            </thead>
            
            <tbody id="account_list_body">
            	<c:foreach var = "user" items = "${not empty resultL_list?result_list:student_list }">
	                <tr>
	                    <td>${user. }</td>
	                    <td>佐藤 花子</td>
	                    <td class="actions">
		                    <form action = "" method = "post">
		                    	<button type = "submit">変更</button>
		                    </form>
		                    <form>    
		                        <button type = "submit">削除</button>
	                        </form>
	                    </td>
	                </tr>
                </c:foreach>
            </tbody>
        </table>

        <div class="menu-item">
            <form action="Redirect_Account_management_Servlet" method = "post">
            	<button type = "submit" class = "back-button">戻る</button>
           	</form>
        </div>
    </div>
    
</body>
</html>