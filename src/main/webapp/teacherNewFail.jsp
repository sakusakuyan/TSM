<!-- teacherNewFail.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>更新失敗</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        .centered-container {
            text-align: center; /* テキストを中央揃えに */
            margin: auto; /* 上下のマージンを自動で調整して中央に配置 */
            width: 50%; /* 幅を50%に設定（必要に応じて調整） */
        }

        ul {
            list-style-type: none; /* リストマーカーを非表示に */
            padding: 0; /* パディングをリセット */
        }

        li {
            margin-bottom: 10px; /* リストアイテム間のマージンを設定 */
        }
    </style>
</head>
<body>
    <div class="container mt-4 centered-container">
        <h1>更新失敗</h1>
        <div class="alert alert-danger" role="alert">
            <!-- エラーメッセージ,内容の表示 -->
            <p><%= request.getAttribute("errorMessage") %></p>
            <p>エラー内容: <%= request.getAttribute("errorCode") %></p>
        </div>
        <!-- 更新試行した教師情報の表示 -->
        <h2>更新試行した内容</h2>
        <div>
            教師番号: <%= request.getAttribute("newTeacherTid") %><br>
            名前: <%= request.getAttribute("newTeacherName") %><br>
            性別: <%= request.getAttribute("newTeacherSex") %><br>
            年齢: <%= request.getAttribute("newTeacherAge") %><br>
            コース: <%= request.getAttribute("newTeacherCourse") %><br>
        </div>
        <a href="index.jsp" class="btn btn-primary">トップページに戻る</a>
    </div>
</body>
</html>