<!-- teacherUpdateSuccess.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jp.main.model.Teacher" %>
<!DOC TYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>更新成功</title>
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
    <h2>更新が成功しました。</h2>
    <%
        Teacher updatedTeacher = (Teacher)request.getAttribute("updatedTeacher");
        if (updatedTeacher != null) {
    %>
    <p>以下の内容で更新が成功しました。</p>
    <ul>
        <li>教師番号: <%= updatedTeacher.getTid() %></li>
        <li>名前: <%= updatedTeacher.getName() %></li>
        <li>性別: <%= updatedTeacher.getSex() %></li>
        <li>年齢: <%= updatedTeacher.getAge() %></li>
        <li>コース: <%= updatedTeacher.getCourse() %></li>
    </ul>
    <%
        }
    %>
    <a href="teacherList.jsp" class="btn btn-primary">教師情報一覧に戻る</a>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
