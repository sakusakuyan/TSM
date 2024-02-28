<!-- teacherUpdate.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jp.main.model.Teacher" %>
<%@ page import="jp.main.service.TeacherService" %>
<%@ page import="java.sql.SQLException" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%
    // リクエストからtidパラメータを取得
    String tidParam = request.getParameter("tid");
    TeacherService service = new TeacherService();
    Teacher teacher = null;

    if (tidParam != null && !tidParam.isEmpty()) {
        int tid = Integer.parseInt(tidParam);
        try {
            // tidに基づいて教師の情報を取得
            teacher = service.getTeacherById(tid);
        } catch (SQLException e) {
            e.printStackTrace();
            // エラーハンドリング
        }
    }

    // セッションに教師オブジェクトを保存
    if (teacher != null) {
        request.getSession().setAttribute("teacher", teacher);
    }
%>

<!DOC TYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>教師情報更新</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        .custom-form-container {
            max-width: 600px;
            margin: auto;
        }
        .form-control {
            width: 150px; /* テキストボックスの幅を調節 */
        }
        .form-group {
            display: flex; /* ラベルとフィールドを横並びにする */
            align-items: center; /* 中央揃えにする */
            margin-bottom: 1rem;
        }
        .form-group label {
            width: 15%; /* ラベルの幅 */
            margin-right: 0.5rem; /* ラベルと入力フィールドの間隔 */
            margin-top: 10px;
        }
        .form-group input,
        .form-group select {
            flex-grow: 0;
        }

        .number-display {
            font-size: 1.5rem; /* この値を調整してサイズを変更 */
        }

        h2 {
            margin-top: 50px;
            margin-bottom: 50px;
        }

        .form-check-label {
             position: relative;
             top: -4px; /* ラベルを上に2ピクセル移動 */
        }

        .form-check-input {
            vertical-align: middle; /* ボタンを垂直方向の中央に配置 */
        }

        /* ボタンのサイズを変更するスタイル */
        .btn-custom {
            padding: 10px 70px; /* ボタンの内側の余白を設定 */
            font-size: 16px; /* フォントサイズを設定 */
            margin-right: 100px; /* 更新ボタンの右のマージンを設定 */
            margin-top: 50px;
        }

        /* リセットボタン専用のスタイル */
        .btn-reset {
            padding: 10px 40px; /* ボタンの内側の余白を設定 */
            font-size: 16px; /* フォントサイズを設定 */
            margin-top: 50px;
        }

    </style>
</head>
<body>

<div class="custom-form-container">
    <h2>教師情報更新</h2>
    <form action="teacherUpdateConfirm.jsp" method="post" id="updateForm" onsubmit="return checkForChanges()">
        <div class="form-group">
            <label>教師番号:</label>
            <div id="tid" class="form-control-static number-display"><%= teacher != null ? teacher.getTid() : "N/A" %></div>
        </div>
        <!-- 教師番号を隠しフィールドとして送信 -->
        <input type="hidden" name="tid" value="<%= teacher != null ? teacher.getTid() : "" %>">

        <div class="form-group">
            <label for="name">名前:</label>
            <input type="text" class="form-control" id="name" name="name" value="<%= teacher != null ? teacher.getName() : "" %>">
        </div>

        <div class="form-group">
            <label>性別:</label>
            <div class="d-flex align-items-center">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="male" name="sex" value="男" <%= teacher != null && "男".equals(teacher.getSex()) ? "checked" : "" %>>
                        <label class="form-check-label" for="male">男</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" id="female" name="sex" value="女" <%= teacher != null && "女".equals(teacher.getSex()) ? "checked" : "" %>>
                        <label class="form-check-label" for="female">女</label>
                    </div>
                </div>
            </div>
        <div class="form-group">
            <label for="age">年齢:</label>
            <input type="number" class="form-control" id="age" name="age" value="<%= teacher != null ? teacher.getAge() : "" %>" required>
        </div>
        <div class="form-group">
            <label for="course">コース:</label>
            <select class="form-control" id="course" name="course">
                <option value="">選択してください</option>
                <option value="英語" <%= teacher != null && "英語".equals(teacher.getCourse()) ? "selected" : "" %>>英語</option>
                <option value="数学" <%= teacher != null && "数学".equals(teacher.getCourse()) ? "selected" : "" %>>数学</option>
                <option value="日本語" <%= teacher != null && "日本語".equals(teacher.getCourse()) ? "selected" : "" %>>日本語</option>
                <option value="中文" <%= teacher != null && "中文".equals(teacher.getCourse()) ? "selected" : "" %>>中文</option>
            </select>
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-success btn-custom">更新</button>
            <button type="reset" class="btn btn-warning btn-reset" form="updateForm">リセット</button>
        </div>
    </form>
</div>

<!-- アラートの設定 -->
<script>
document.getElementById('updateForm').onsubmit = function() {
    var originalName = "<%= teacher.getName() %>";
    var originalSex = "<%= teacher.getSex() %>";
    var originalAge = "<%= teacher.getAge() %>";
    var originalCourse = "<%= teacher.getCourse() %>";

    var currentName = document.getElementById('name').value;
    var currentSex = document.querySelector('input[name="sex"]:checked').value;
    var currentAge = document.getElementById('age').value;
    var currentCourse = document.getElementById('course').value;

    if (originalName == currentName && originalSex == currentSex && originalAge == currentAge && originalCourse == currentCourse) {
        alert("変更がありません。");
        return false; // フォームの送信をキャンセル
    }
    return true; // 変更があれば送信を許可
};
</script>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
