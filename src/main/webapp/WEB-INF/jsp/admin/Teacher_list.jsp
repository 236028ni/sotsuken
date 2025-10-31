<%@page import="java.util.*,dao.TeacherDAO,model.UserBean,model.TeacherBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	TeacherDAO tdao = new TeacherDAO();
	List<TeacherBean>teacher_list = tdao.findall();
	session.setAttribute("teacher_list", teacher_list);
%>
<c:set var = "teacher_list" value = "${sessionScope.teacher_list }"/>
<c:set var = "result_list" value = "${sessionScope.result_list }"/>
<c:set var = "in_teacher_name" value = "${sessionScope.in_teacher_name }"/>
<c:set var = "error_msg" value = "${sessionScope.error_msg }"/>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>講師一覧</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            background-color: #f4f4f4;
        }

        /* 全体を囲むコンテナ */
        .list-container {
            width: 700px; /* テーブル全体の幅 */
            max-width: 90%;
            border: 1px solid #ccc;
            background-color: white;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            border-radius: 8px;
        }

        h2 {
            font-size: 1.5em;
            margin-top: 0;
            margin-bottom: 20px;
            color: #333;
            text-align: center;
        }

        /* ★★★ スクロール可能な表のラッパー ★★★ */
        .table-wrapper {
            max-height: 400px; /* ここが重要: 表の最大高さを指定 */
            overflow-y: auto;  /* ここが重要: 縦スクロールバーを有効にする */
            border: 1px solid #ddd;
            border-radius: 4px;
        }

        /* 一覧表のスタイル */
        .data-table {
            width: 100%;
            border-collapse: collapse;
            /* スクロール時にヘッダーを固定しない場合は 'table-layout: fixed;' は不要 */
        }

        .data-table th, .data-table td {
            border: 1px solid #eee;
            padding: 12px 15px;
            text-align: left;
            vertical-align: middle;
        }

        /* ヘッダーのスタイル */
        .data-table th {
            background-color: #eef;
            color: #333;
            font-weight: bold;
            position: sticky; /* スクロールしてもヘッダーを固定 (ただしwrapperとの兼ね合いに注意) */
            top: 0;
            z-index: 1;
        }

        /* データ行のスタイル */
        .data-table tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .data-table tbody tr:hover {
            background-color: #f0f8ff;
        }

        /* 特定のカラム幅の指定 */
        .data-table th:nth-child(1), 
        .data-table td:nth-child(1) {
            width: 15%; /* 教師ID */
        }
        .data-table th:nth-child(2), 
        .data-table td:nth-child(2) {
            width: 35%; /* 名前 */
        }
        .data-table th:nth-child(3), 
        .data-table td:nth-child(3) {
            width: 25%; /* 変更ボタン */
        }
        .data-table th:nth-child(4), 
        .data-table td:nth-child(4) {
            width: 25%; /* 削除ボタン */
        }

        /* ボタンのスタイル */
        .action-button {
            padding: 8px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            width: 100px; /* ボタンの幅を固定 */
            transition: background-color 0.2s;
        }

        .btn-edit {
            background-color: #007bff; /* 青 */
            color: white;
        }
        .btn-edit:hover {
            background-color: #0056b3;
        }

        .btn-delete {
            background-color: #dc3545; /* 赤 */
            color: white;
            margin-left: 10px;
        }
        .btn-delete:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>
    <div class="list-container">
        <h1>学生一覧</h1>
		<div class="table-wrapper">
			<c:if test = "${in_teacher_name != null }">
				<p>氏名に「"${in_teacher_name }"」を含む講師：${result_list.size() }件</p>
			</c:if>
			<c:if test = "${in_teacher_name!=null}">
                <form action = "Redirect_Teacher_list_Servlet" method = "post" class="reset-form">
                    <button type = "submit" class="reset-button">リセット</button> <%-- ★変更: ボタンのクラス変更 --%>
                </form>
            </c:if>
        	<div class="search-area">
        		<form action = "Search_by_name_Servlet" method = "post" >
	       	    	<input type="text" placeholder="講師" id="search_input" name = "in_teacher_name">
	        	    <button type = "submit" id="search_button">検索</button>
            	</form>
         	</div>

			<c:choose>
				<c:when test = "${not empty error_msg }">
					<p>${error_msg }</p>
				</c:when>
				<c:when test = "${empty teacher_list }">
					<p>講師が登録されていません</p>
				</c:when>
				<c:otherwise>
	        	<table class="data-table">
	          	  <thead>
	             	   <tr>
	                    	<th>講師ID</th>
	                    	<th>講師名</th>
	                    	<th colspan = "2" class="actions">操作</th>
	                	</tr>
	            	</thead>
	            
	            	<tbody id="account_list_body">
	            		<c:forEach var = "teacher" items = "${not empty result_list?result_list:teacher_list }">
		         	       <tr>
		                	    <td>${teacher.user_id }</td>
		                 	   <td>${teacher.teacher_name}</td>
		                	    <td class="actions">
			               	     <form action = "" method = "post">
			               	     	<button type = "submit"class = "action-button btn-edit">変更</button>
			               	     </form>
			               	     </td>
			               	     <td>
			                 	   <form action = "Redirect_Account_delete_Servlet" method = "post">
			                 	   	 <input type = "hidden" name = "del_teacher_id" value = "${teacher.user_id }"> 
			                   	     <button type = "submit"class = "action-button btn-delete">削除</button>
		                      	  </form>
		                  	  </td>
		                	</tr>
	               	 </c:forEach>
	           	 </tbody>
	        	</table>
	        	</c:otherwise>
			</c:choose>

        	<div class="menu-item">
          	  <form action="Redirect_Account_management_Servlet" method = "post">
          	  	<button type = "submit" class = "back-button">戻る</button>
          	 	</form>
       	 </div>
   	 </div>
    </div>
</body>
</html>