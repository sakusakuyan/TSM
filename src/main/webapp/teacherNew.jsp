<!-- teacherNew.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>教師情報登録</title>
    <!-- Bootstrap CSS の読み込み -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <!-- 独自のCSSスタイル -->
    <style>
        /* フォームコントロールを中央寄せするためのスタイル */
        .form-group {
            display: flex;
            flex-direction: row; /* アイテムを横並びにする */
            justify-content: center; /* アイテムを中央に配置 */
            align-items: center; /* アイテムを垂直方向の中央に揃える */
            margin-bottom: 15px; /* 下のフォームグループとの間隔 */
        }

        /* 入力フィールドのサイズを設定 */
        .form-control {
            width: auto; /* 入力フィールドの幅を内容に応じて変更する */
            flex-grow: 1; /* 利用可能なスペースを埋めるように伸ばす */
        }

        /* 必須フィールドアスタリスクをラベルの隣に表示 */
        .required-field {
            color: red;
            margin-left: 5px;
        }

        /* ラベルを左寄せにする */
        .col-form-label {
            margin-right: 10px; /* ラベルと入力フィールドの間隔を設定 */
            white-space: nowrap; /* ラベルを折り返さないようにする */
        }

        /* 入力フィールドとアスタリスクのコンテナ */
        .input-group {
            display: flex;
            align-items: center;
            justify-content: center; /* コンテナ内のアイテムを中央に配置 */
        }

        /* フォーム自体を中央寄せする */
        .teacher-form {
            width: 100%; /* フォームの幅を指定 */
            max-width: 300px; /* フォームの最大幅を指定 */
            margin: auto; /* フォームをページの中央に配置 */
        }

        h2 {
                    margin-top: 50px;
                    margin-bottom: 50px;
        }

        /* ボタンコンテナのスタイル */
        .btn-container {
            display: flex;
            justify-content: space-between; /* ボタン間に均等なスペースを設定 */
            margin-top: 50px; /* ボタンの上のマージンを設定 */
        }

        /* ボタンのスタイル */
        .btn-custom, .btn-reset {
            padding: 10px 40px; /* ボタンの内側の余白を設定 */
            font-size: 16px; /* フォントサイズを設定 */
        }

        /* 個別のボタン間のマージンを設定 */
        .btn-custom {
            padding: 0px 50px; /* ボタンの内側の余白を設定 */
            margin-right: 20px; /* 登録ボタンの右のマージンを設定 */
        }

        /* 性別ラジオボタンのスタイル */
        .gender-label {
            margin-right: 80px; /* ラベルとラジオボタンの間隔を設定 */
        }
    </style>
</head>
<body>
<div class="teacher-form">
    <h2 class="text-center">教師情報登録</h2>
    <!-- 登録フォーム -->
    <form action="NewTeacherServlet" method="post" id="newTeacherForm">

        <div class="form-group d-flex align-items-center justify-content-center">
            <label for="teacherNumber" class="col-form-label">教師番号</label>
            <div class="input-group">
                <input type="text" class="form-control" id="teacherNumber" name="tid" required>
                <span class="required-field">*</span>
            </div>
        </div>

        <div class="form-group d-flex align-items-center justify-content-center">
            <label for="teacherName" class="col-form-label">名前</label>
            <div class="input-group">
                <input type="text" class="form-control" id="teacherName" name="name" required>
                <span class="required-field">*</span>
            </div>
        </div>

        <div class="form-group d-flex align-items-center justify-content-center">
            <label class="col-form-label">性別</label>
            <div class="input-group">
                <div>
                    <input type="radio" id="male" name="sex" value="男" required>
                    <label for="male" class="gender-label">男</label>
                    <input type="radio" id="female" name="sex" value="女" required>
                    <label for="female">女</label>
                </div>
                <span class="required-field">*</span>
            </div>
        </div>

        <div class="form-group d-flex align-items-center justify-content-center">
            <label for="teacherAge" class="col-form-label">年齢</label>
            <div class="input-group">
                <input type="text" class="form-control" id="teacherAge" name="age" required>
                <span class="required-field">*</span>
            </div>
        </div>

        <div class="form-group d-flex align-items-center justify-content-center">
            <label for="teacherCourse" class="col-form-label">コース</label>
            <div class="input-group">
                <select class="form-control" id="teacherCourse" name="course" required>
                    <option value="">選択してください</option>
                    <option value="英語">英語</option>
                    <option value="数学">数学</option>
                    <option value="日本語">日本語</option>
                    <option value="中文">中文</option>
                </select>
                <span class="required-field">*</span>
            </div>
        </div>

        <p>* が付いている項目は必須項目です。</p>
        <div class="btn-container">
            <button type="submit" id="registerButton" class="btn btn-primary btn-custom">登録</button>
            <button type="reset" id="resetButton" class="btn btn-secondary btn-reset" >リセット</button>
        </div>
    </form>
</div>

<script>
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

    // リセットボタンがクリックされた時の処理を追加
    $('#resetButton').click(function() {
        $('#registerButton').prop('disabled', false); // 登録ボタンのロックを解除
    });
});
</script>

<!-- Bootstrap の JavaScript プラグインと依存関係の jQuery -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
