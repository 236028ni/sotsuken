<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="errorMsg" value="${sessionScope.error_msg}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>エラー画面</title>
</head>
<body>
	<h1>入力内容に誤りがあります</h1>
	<span style = "color:red" >
		<c:out value = "${error_msg }"/><br>
	</span>
	    <button type="button" onclick="history.back()" class="link-button">登録画面に戻る</button>
	
</body>
</html>