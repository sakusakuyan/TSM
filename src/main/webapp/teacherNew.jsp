<!-- teacherNew.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOC TYPE html>
<html>
<head>
    <title>教師情報登録</title>
    <!-- Bootstrap CSS の読み込み -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <!-- 独自のCSSスタイル -->
    <style>
        /* 教師情報登録フォームのスタイル */
        .teacher-form {
            max-width: 600px;
            margin: 30px auto;
        }
        .teacher-form label {
            width: 90px;
        }
        .teacher-form input[type="text"],
        .teacher-form select {
            width: calc(100% - 100px);
        }
        .teacher-form button {
            margin-top: 20px;
        }
        /* 必須フィールドのアスタリスクの色を変更 */
        .required-field::after {
            content: "*";
            color: red;
        }
    </style>
</head>
<body>
<div class="teacher-form">
    <h2 class="text-center">教師情報登録</h2>
    <!-- 登録フォーム -->
    <form id="newTeacherForm">
        <div class="form-group">
            <label for="teacherNumber" class="required-field">教師番号</label>
            <input type="text" class="form-control" id="teacherNumber" name="tid" required>
        </div>
        <div class="form-group">
            <label for="teacherNameKanji" class="required-field">名前（漢字）</label>
            <input type="text" class="form-control" id="teacherNameKanji" name="nameKanji" required>
        </div>
        <div class="form-group">
            <label for="teacherNameKana">名前（かな）</label>
            <input type="text" class="form-control" id="teacherNameKana" name="nameKana">
        </div>
        <div class="form-group">
            <label class="required-field">性別</label>
            <div>
                <input type="radio" id="male" name="sex" value="男" required>
                <label for="male">男</label>
                <input type="radio" id="female" name="sex" value="女" required>
                <label for="female">女</label>
            </div>
        </div>
        <div class="form-group">
            <label for="teacherAge" class="required-field">生年</label>
            <input type="text" class="form-control" id="teacherAge" name="age" required>
        </div>
        <div class="form-group">
            <label for="teacherCourse" class="required-field">コース</label>
            <select class="form-control" id="teacherCourse" name="course" required>
                <option value="">選択してください</option>
                <option value="英語">英語</option>
                <!-- 他のコースのオプション -->
            </select>
        </div>
        <button type="submit" class="btn btn-primary">登録</button>
        <button type="reset" class="btn btn-secondary">リセット</button>
    </form>
</div>

$(document).ready(function() {
    // 教師番号の入力フィールドからフォーカスが外れたらチェックを行う
    $('#teacherNumber').on('blur', function() {
        var tid = $(this).val(); // 入力された教師番号を取得
        // 教師番号が入力されていればチェックを行う
        if (tid) {
            $.ajax({
                url: 'CheckTeacherServlet', // 存在チェックを行うサーブレットのURL
                type: 'POST',
                dataType: 'json',
                data: {tid: tid},
                success: function(response) {
                    if (response.exists) { // 教師番号が存在する場合
                        alert('この教師番号は既に存在します。');
                        // 登録ボタンを無効にする
                        $('#registerButton').prop('disabled', true);
                    } else {
                        // 登録ボタンを有効にする
                        $('#registerButton').prop('disabled', false);
                    }
                },
                error: function() {
                    // エラー処理
                    alert('チェック中にエラーが発生しました。');
                }
            });
        }
    });
});

<!-- Bootstrap の JavaScript プラグインと依存関係の jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
