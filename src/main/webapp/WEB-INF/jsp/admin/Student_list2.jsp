<%@page import="java.util.*,dao.StudentDAO,model.UserBean,model.StudentBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	StudentDAO sdao = new StudentDAO();
	List<StudentBean>student_list = sdao.findall();
	session.setAttribute("student_list", student_list);
%>
<c:set var = "student_list" value = "${sessionScope.student_list }"/>
<c:set var = "result_list" value = "${sessionScope.result_list }"/>
<c:set var = "in_student_id" value = "${sessionScope.in_student_id }"/>
<c:set var = "error_msg" value = "${sessionScope.error_msg }"/>

<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>学生一覧</title>
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
			<c:if test = "${in_student_id != null }">
				<p>学籍番号に「"${in_student_id }"」を含む学生：${result_list.size() }件</p>
			</c:if>
			<c:if test = "${in_student_id!=null}">
                <form action = "Redirect_Student_list_Servlet" method = "post" class="reset-form">
                    <button type = "submit" class="reset-button">リセット</button> <%-- ★変更: ボタンのクラス変更 --%>
                </form>
            </c:if>
        	<div class="search-area">
        		<form action = "Search_by_id_Servlet" method = "post" onsubmit = "return user_id_Check()">
	       	    	<input type="text" placeholder="学籍番号" id="search_input" name = "in_student_id" >
	        	    <button type = "submit" id="search_button">検索</button>
            	</form>
         	</div>

			<c:choose>
				<c:when test = "${not empty error_msg }">
					<p>${error_msg }</p>
				</c:when>
				<c:when test = "${empty student_list }">
					<p>学生が登録されていません</p>
				</c:when>
				<c:otherwise>
	        	<table class="data-table">
	          	  <thead>
	             	   <tr>
	                    	<th>学籍番号</th>
	                    	<th>学生名</th>
	                    	<th colspan = "2" class="actions">操作</th>
	                	</tr>
	            	</thead>
	            
	            	<tbody id="account_list_body">
	            		<c:forEach var = "student" items = "${not empty result_list?result_list:student_list }">
		         	       <tr>
		                	    <td>${student.user_id }</td>
		                 	   <td>${student.student_name}</td>
		                	    <td class="actions">
			               	     <form action = "" method = "post">
			               	     	<button type = "submit"class = "action-button btn-edit">変更</button>
			               	     </form>
			               	     </td>
			               	     <td>
			                 	   <form>    
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
<script>
	function user_id_Check(){
		let user_id = document.getElementById('search_input');
		let in_user_id = user_id.value;
		let new_user_id = in_user_id.replace(/[０-９]/g, s => String.fromCharCode(s.charCodeAt(0) - 65248));
		if (!/^\d+$/.test(new_user_id)) {
			alert("学籍番号は数字で入力してください。");
			return false;
		}
		user_id.value = new_user_id;
		return true;
	}
	// 1. 対象の要素を取得
	const inputElement = document.getElementById('search_input');

	// 2. IME入力中かどうかを判定するフラグ
	let isComposing = false;

	// 3. IME入力が開始された時のイベント
	inputElement.addEventListener('compositionstart', () => {
	    isComposing = true;
	});

	// 4. IME入力が終了した時のイベント
	inputElement.addEventListener('compositionend', () => {
	    isComposing = false;
	    // IME終了時にフォーマットを実行
	    formatStudent_id();
	});

	// 5. (oninput) 半角入力やペーストなど、IME以外の入力イベント
	inputElement.addEventListener('input', () => {
	    // IME入力中でなければ、フォーマットを実行
	    if (!isComposing) {
	        formatStudent_id();
	    }
	});

	// 6. フォーマット処理を行う関数 (内容は少し最適化)
	function formatStudent_id() {
	    let currentValue = inputElement.value;

	    // 1. 全角数字(０-９)を半角(0-9)に変換
	    // (英字は最終的に削除するので、ここで変換する必要はない)
	    let newValue = currentValue.replace(/[０-９]/g, function(s) {
	        return String.fromCharCode(s.charCodeAt(0) - 65248);
	    });

	    // 2. 半角数字「以外」の文字をすべて削除
	    newValue = newValue.replace(/[^0-9]/g, '');

	    // 3. 変換・整形した値を入力ボックスに書き戻す
	    //    (値が実際に変更された場合のみ書き戻す)
	    if (inputElement.value !== newValue) {
	        inputElement.value = newValue;
	    }
	}
</script>
</html>