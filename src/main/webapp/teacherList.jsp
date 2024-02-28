<!-- 現行teacherList.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="jp.main.model.Teacher" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>教師情報</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/styles.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

    <style>
       /* 検索ボタンのスタイルをカスタマイズ */
           #searchButton {
               width: 150px;
           }

           /* テキストフィールドとセレクトボックスのカーソルの色を変更 */
           input[type="text"],
           select.form-control {
               caret-color: red;
           }
    </style>
</head>
<body>
<% request.setCharacterEncoding("UTF-8");%>
<div class="container mt-3">
    <h2>教師情報</h2>
    <form id="searchForm" class="form-inline justify-content-between">
        <label for="teacherNumber" class="mr-2">教師番号：</label>
        <input type="text" class="form-control mb-2 mr-sm-2" name="tid" id="teacherNumber" placeholder="教師番号を入力">

        <label for="teacherName" class="mr-2">名前：</label>
        <input type="text" class="form-control mb-2 mr-sm-2" name="name" id="teacherName" placeholder="名前を入力">

        <label for="course" class="mr-2">コース：</label>
        <select class="form-control mb-2 mr-sm-2" name="course" id="course">
            <option value="">選択してください</option>
            <option value="英語">英語</option>
            <option value="数学">数学</option>
            <option value="日本語">日本語</option>
            <option value="中文">中文</option>
        </select>

        <button type="submit" id="searchButton" class="btn btn-primary mb-2">検索</button>
    </form>



    <!-- 検索結果の表示エリア -->
    <div id="searchResults"></div>
</div>

<script>
$(document).ready(function() {
    // ページ読み込み完了時に空検索を実行
    performSearch();

    $('#searchForm').submit(function(e) {
        e.preventDefault(); // フォームのデフォルト送信を阻止
        performSearch(); // フォーム送信時に検索を実行
    });
});

function performSearch() {
    var tid = $('#teacherNumber').val();
    var name = $('#teacherName').val();

    // 教師番号の検証（最大5桁の整数）
    if (tid && !tid.match(/^\d{1,5}$/)) {
        alert("入力した番号は正しくありません");
        return;
    }
    if (name && !name.match(/^[ぁ-んァ-ン一-龥\d]+$/)) { // 例: 完全一致検索の場合の簡単な正規表現
        alert("入力した名前は正しくありません");
        return;
    }

    // Ajaxリクエストを送信
    $.ajax({
        url: 'TeacherListServlet',
        type: 'POST',
        dataType: 'json',  // 応答をJSONとして扱う
        data: $('#searchForm').serialize(), // フォームのデータをシリアライズ
        success: function(data) {
            // 検索結果を処理
            updateSearchResults(data);
        },
        error: function() {
            alert("検索処理に失敗しました");
        }
    });
}

function updateSearchResults(teachers) {
    var $results = $('#searchResults');
        $results.empty(); // 既存の検索結果をクリア

        console.log(teachers); // 受け取ったデータをコンソールに出力

        if (teachers.length === 0) {
            $results.append('<p>検索結果が見つかりませんでした。</p>');
        } else {
            var table = $('<table class="table table-bordered table-striped"></table>');
            var thead = $('<thead class="thead-dark"><tr><th>教師番号</th><th>名前</th><th>性別</th><th>年齢</th><th>コース</th><th>操作</th></tr></thead>');
            table.append(thead);
            var tbody = $('<tbody></tbody>');

            teachers.forEach(function(teacher) {
                var tr = $('<tr></tr>');
                tr.append('<td>' + teacher.tid + '</td>');
                tr.append('<td>' + teacher.name + '</td>');
                tr.append('<td>' + teacher.sex + '</td>');
                tr.append('<td>' + teacher.age + '</td>');
                tr.append('<td>' + teacher.course + '</td>');
                 tr.append('<td><a href="teacherUpdate.jsp?tid=' + teacher.tid + '" class="btn btn-primary">更新</a></td>');
                tbody.append(tr);
            });

            table.append(tbody);
            $results.append(table);
        }
}
</script>

</body>
</html>
