// CheckTeacherServlet.java
package jp.main.servlet;

import com.google.gson.JsonObject;
import jp.main.dao.TeacherDAO;
import jp.main.model.Teacher;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

@WebServlet("/CheckTeacherServlet")
public class CheckTeacherServlet extends HttpServlet {
    private TeacherDAO teacherDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        teacherDAO = new TeacherDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        int tid = 0;
        try {
            tid = Integer.parseInt(request.getParameter("tid"));
        } catch (NumberFormatException e) {
            // tidが有効な整数でない場合の処理を行う
        }

        boolean exists = false;
        try {
            Teacher teacher = teacherDAO.getTeacherById(tid);
            exists = teacher != null;
        } catch (SQLException e) {
            //データベースのエラーを適切に処理する
            e.printStackTrace();
        }

        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("exists", exists);

        out.print(jsonResponse.toString());
        out.flush();
    }
}

