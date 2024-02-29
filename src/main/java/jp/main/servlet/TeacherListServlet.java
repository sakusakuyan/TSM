//TeacherListServlet.java
package jp.main.servlet;

import com.google.gson.Gson;
import jp.main.model.Teacher;
import jp.main.service.TeacherService;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "TeacherListServlet", urlPatterns = {"/TeacherListServlet"})
public class TeacherListServlet extends HttpServlet {
    private TeacherService teacherService = new TeacherService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");

        String tid = request.getParameter("tid");
        String name = request.getParameter("name");
        String course = request.getParameter("course");

        List<Teacher> teachers = null;

        // tid, name, または course が null の場合、空文字列に置き換える
        tid = tid != null ? tid : "";
        name = name != null ? name : "";
        course = course != null ? course : "";

        // "選択してください"が選択された場合は、courseを空文字として扱う
        if ("選択してください".equals(course)) {
            course = "";
        }

        // リクエストパラメータの値をログ（コンソール）に出力
        System.out.println("Received search parameters:");
        System.out.println("tid: " + tid);
        System.out.println("name: " + name);
        System.out.println("course: " + course);

        try {
//            // 名前の完全一致検索の有効性を確認
//            if (!name.isEmpty()) {
//                // ここで完全一致検索を実装
//                List<Teacher> teachersByName = teacherService.searchTeachersByNameExactMatch(name);
//                teachers = teacherService.searchTeachersByNameExactMatch(name);
//            } else if ((tid == null || tid.isEmpty()) && (course == null || course.isEmpty())) {
//                teachers = teacherService.getAllTeachers();
//            } else {
//                teachers = teacherService.searchTeachers(tid, name, course);
//            }
            // 名前の完全一致検索の有効性を確認
            if (!name.isEmpty()) {
                List<Teacher> teachersByName = teacherService.searchTeachersByNameExactMatch(name);
                // 名前でフィルタリングされたリストをさらにtidとcourseで絞り込む
                teachers = teacherService.filterTeachers(teachersByName, tid, course);
            } else if (tid.isEmpty() && course.isEmpty()) {
                // 全ての教師情報を取得
                teachers = teacherService.getAllTeachers();
            } else {
                // tidやcourseに基づいて検索（名前でのフィルタリングは行わない）
                teachers = teacherService.searchTeachers(tid, "", course);
            }
            // Gsonライブラリのインスタンス化
            Gson gson = new Gson();
            // 検索結果をJSON形式でクライアントに返す
            String json = gson.toJson(teachers);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print(json);
            out.flush();
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "データベースアクセス中にエラーが発生しました。");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "情報の取得中にエラーが発生しました。");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 文字エンコーディングの設定
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        //doPost(request, response);
        try {
            // 全教師情報の取得
            List<Teacher> teachers = teacherService.getAllTeachers();
            // 取得した教師情報をリクエスト属性に設定
            request.setAttribute("teachers", teachers);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "データベースアクセス中にエラーが発生しました。");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "情報の取得中にエラーが発生しました。");
        }
        // teacherList.jspにフォワード
        RequestDispatcher dispatcher = request.getRequestDispatcher("/teacherList.jsp");
        dispatcher.forward(request, response);
    }
}
