<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>更新失敗</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h1>更新失敗</h1>
        <div class="alert alert-danger" role="alert">
            <!-- エラーメッセージ,内容の表示 -->
            <p><%= request.getAttribute("errorMessage") %></p>
            <p>エラー内容: <%= request.getAttribute("errorCode") %></p>
        </div>
        <!-- 更新試行した教師情報の表示 -->
        <h2>更新試行した内容</h2>
        <div>
            教師番号: <%= request.getAttribute("teacherUpdatedTid") %><br>
            名前: <%= request.getAttribute("teacherUpdatedName") %><br>
            性別: <%= request.getAttribute("teacherUpdatedSex") %><br>
            年齢: <%= request.getAttribute("teacherUpdatedAge") %><br>
            コース: <%= request.getAttribute("teacherUpdatedCourse") %><br>
        </div>
        <a href="teacherList.jsp" class="btn btn-primary">戻る</a>
    </div>
</body>
</html>
