package jp.main.servlet;

import jp.main.model.Teacher;
import jp.main.service.TeacherService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/UpdateTeacherServlet")
public class UpdateTeacherServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // POSTリクエストからパラメータを取得
        int tid = Integer.parseInt(request.getParameter("tid"));
        String name = request.getParameter("name");
        String sex = request.getParameter("sex");
        int age = Integer.parseInt(request.getParameter("age"));
        String course = request.getParameter("course");

        // Teacherオブジェクトを作成し、取得した更新情報を設定
        Teacher teacherUpdated = new Teacher();
        teacherUpdated.setTid(tid);
        teacherUpdated.setName(name);
        teacherUpdated.setSex(sex);
        teacherUpdated.setAge(age);
        teacherUpdated.setCourse(course);

        try {
            // 例外を強制的に発生させる（テスト用、開発環境のみで使用してください）
            //if (true) throw new Exception("Forced error");
            // TeacherServiceを使用して教師情報を更新
            TeacherService service = new TeacherService();
            service.updateTeacher(teacherUpdated);

            // 更新情報をリクエストスコープにセット
            request.setAttribute("updatedTeacher", teacherUpdated);

            // 更新成功時の処理:teacherUpdateSuccess.jspにリダイレクトし、teacherUpdateSuccess.jspにフォワード
            request.getRequestDispatcher("/teacherUpdateSuccess.jsp").forward(request, response);
        } catch (Exception e) {
            // 更新失敗時の処理
            // エラーメッセージとエラーコードをリクエストスコープにセット
            String errorMessage = "教師情報の更新に失敗しました。エラー: " + e.getMessage();
            String errorCode = e.getClass().getSimpleName(); // 例外のクラス名をエラーコードとして使用

            request.setAttribute("errorMessage", errorMessage);
            request.setAttribute("errorCode", errorCode);

            // コンソールにエラーメッセージとスタックトレースを出力
            System.err.println("エラーが発生しました: " + errorMessage);
            e.printStackTrace(); // スタックトレースを出力

            // 失敗時に試行した更新内容をリクエストスコープにセット
            request.setAttribute("teacherUpdatedTid", teacherUpdated.getTid());
            request.setAttribute("teacherUpdatedName", teacherUpdated.getName());
            request.setAttribute("teacherUpdatedSex", teacherUpdated.getSex());
            request.setAttribute("teacherUpdatedAge", teacherUpdated.getAge());
            request.setAttribute("teacherUpdatedCourse", teacherUpdated.getCourse());

            // teacherUpdateFail.jspにリダイレクト&フォワード
            request.getRequestDispatcher("/teacherUpdateFail.jsp").forward(request, response);
        }
    }
}
