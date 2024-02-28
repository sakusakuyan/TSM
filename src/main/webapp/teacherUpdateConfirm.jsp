<!-- teacherUpdateConfirm.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jp.main.model.Teacher" %>
<%@ page import="jp.main.service.TeacherService" %>
<%@ page import="java.sql.SQLException" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    // セッションから更新前の教師オブジェクトを取得
    Teacher teacher = (Teacher) request.getSession().getAttribute("teacher");

    // POSTされたデータから変更後の教師オブジェクトを作成
    Teacher teacherUpdated = new Teacher();
    teacherUpdated.setTid(Integer.parseInt(request.getParameter("tid")));
    teacherUpdated.setName(request.getParameter("name"));
    teacherUpdated.setSex(request.getParameter("sex"));
    teacherUpdated.setAge(Integer.parseInt(request.getParameter("age")));
    teacherUpdated.setCourse(request.getParameter("course"));
%>

<!DOC TYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>教師情報更新確認</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
　　 <style>
      .center-div {
          margin: auto;
          width: 50%; /* 幅を指定 */
          padding: 10px;
          text-align: center; /* テキストを中央揃えに */
      }
      .form-container {
          display: flex;
          justify-content: center; /* コンテナ内のアイテムを中央揃えに */
          flex-direction: column; /* アイテムを縦に並べる */
      }
      .form-group {
          margin-bottom: 15px; /* フォームグループの間隔 */
      }

      h2 {
          margin-left: 400px;
      }

      /* ボタンのサイズを変更するスタイル */
      .btn-custom {
          padding: 10px 70px; /* ボタンの内側の余白を設定 */
          font-size: 16px; /* フォントサイズを設定 */
          margin-right: 100px; /* 更新ボタンの右のマージンを設定 */
      }

      /* リセットボタン専用のスタイル */
      .btn-cancel {
          padding: 10px 40px; /* ボタンの内側の余白を設定 */
          font-size: 16px; /* フォントサイズを設定 */
      }
  　　</style>
</head>
<body>

<h2>以下は変更する内容です。よろしいですか？</h2>
<div class="container">
    <div class="center-div">
        <div class="form-container">
            <form action="UpdateTeacherServlet" method="post">
            　　<!-- フォームの内容 -->
                <div class="form-group">
                <%
                    Teacher originalTeacher = (Teacher) request.getSession().getAttribute("teacher");
                    String newName = request.getParameter("name");
                    String newSex = request.getParameter("sex");
                    String newAge = request.getParameter("age");
                    String newCourse = request.getParameter("course");

                    if (!originalTeacher.getName().equals(newName)) {
                %>
                        <p>名前: <%= originalTeacher.getName() %> → <%= newName %></p>
                <%
                    }
                    if (!originalTeacher.getSex().equals(newSex)) {
                %>
                        <p>性別: <%= originalTeacher.getSex() %> → <%= newSex %></p>
                <%
                    }
                    if (!String.valueOf(originalTeacher.getAge()).equals(newAge)) {
                %>
                        <p>年齢: <%= originalTeacher.getAge() %> → <%= newAge %></p>
                <%
                    }
                    if (!originalTeacher.getCourse().equals(newCourse)) {
                %>
                        <p>コース: <%= originalTeacher.getCourse() %> → <%= newCourse %></p>
                <%
                    }
                %>
                </div>
                <!-- その他の入力フィールド -->
                    <input type="hidden" name="tid" value="<%= teacher.getTid() %>">
                    <input type="hidden" name="name" value="<%= teacherUpdated.getName() %>">
                    <input type="hidden" name="sex" value="<%= teacherUpdated.getSex() %>">
                    <input type="hidden" name="age" value="<%= teacherUpdated.getAge() %>">
                    <input type="hidden" name="course" value="<%= teacherUpdated.getCourse() %>">
                    <button type="submit" class="btn-custom">登録</button>
                    <button type="button" onclick="history.back()" class="btn-cancel">キャンセル</button>
            </form>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
