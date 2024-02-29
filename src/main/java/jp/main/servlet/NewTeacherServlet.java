//NewTeacherServlet.java
package jp.main.servlet;

import jp.main.dao.TeacherDAO;
import jp.main.model.Teacher;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class NewTeacherServlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(NewTeacherServlet.class.getName());
    private TeacherDAO teacherDAO;

    @Override
    public void init() {
        teacherDAO = new TeacherDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String tidStr = request.getParameter("tid");
        int tid = 0;
        try {
            tid = Integer.parseInt(tidStr);
            // 教師番号が正常に取得できた場合の処理
            logger.info("Received tid: " + tid);
        } catch (NumberFormatException e) {
            // 教師番号が無効な場合のエラー処理
            logger.warning("Invalid tid: " + tidStr);
        }
        String name = request.getParameter("name");
        String sex = request.getParameter("sex");
        int age = Integer.parseInt(request.getParameter("age"));
        String course = request.getParameter("course");

        Teacher newTeacher = new Teacher();
        newTeacher.setTid(tid);
        newTeacher.setName(name);
        newTeacher.setSex(sex);
        newTeacher.setAge(age);
        newTeacher.setCourse(course);

        try {
            //if (true) throw new Exception("Forced error");  // 例外を強制的に発生させる（テスト用、開発環境のみで使用してください）
            teacherDAO.addTeacher(newTeacher);
            // 登録されたTeacherオブジェクトをリクエストスコープに追加
            request.setAttribute("newTeacher", newTeacher);
            // RequestDispatcherを使用してteacherNewSuccess.jspにフォワード
            RequestDispatcher dispatcher = request.getRequestDispatcher("teacherNewSuccess.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            String errorMessage = e.getMessage() != null ? e.getMessage() : "登録処理中に未知のエラーが発生しました。";
            logger.log(Level.SEVERE, "登録に失敗しました", e);

            request.setAttribute("errorCode", "ERROR_CODE_HERE");
            request.setAttribute("errorMessage", "登録に失敗しました。エラー詳細: " + errorMessage);

            // 失敗時に試行した更新内容をリクエストスコープにセット
            request.setAttribute("newTeacherTid", newTeacher.getTid());
            request.setAttribute("newTeacherName", newTeacher.getName());
            request.setAttribute("newTeacherSex", newTeacher.getSex());
            request.setAttribute("newTeacherAge", newTeacher.getAge());
            request.setAttribute("newTeacherCourse", newTeacher.getCourse());

            RequestDispatcher dispatcher = request.getRequestDispatcher("teacherNewFail.jsp");
            dispatcher.forward(request, response);
        }
    }
}
