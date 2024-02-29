//TeacherDAO.java

package jp.main.dao;

import jp.main.base.JdbcTest;
import jp.main.model.Teacher;
import java.util.List;
import java.util.ArrayList;

import java.sql.*;
public class TeacherDAO {

    //教師の情報を更新するメソッド
    public void updateTeacher(Teacher teacher) throws SQLException {
        boolean rowUpdated;
        String sql = "UPDATE teacher SET name=?, age=?, sex=?, course=? WHERE tid=?";
        try (Connection connection = JdbcTest.getConnection();
             PreparedStatement updateTeacherStmt = connection.prepareStatement(sql)) {
            updateTeacherStmt.setString(1, teacher.getName());
            updateTeacherStmt.setInt(2, teacher.getAge());
            updateTeacherStmt.setString(3, teacher.getSex());
            updateTeacherStmt.setString(4, teacher.getCourse());
            updateTeacherStmt.setInt(5, teacher.getTid());

            rowUpdated = updateTeacherStmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw e;
        }
    }


    // 全教師データを取得するメソッド
    public List<Teacher> getAllTeachers() throws SQLException {
        List<Teacher> teachers = new ArrayList<>();
        String sql = "SELECT * FROM teacher";
        try (Connection connection = JdbcTest.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            while (resultSet.next()) {
                Teacher teacher = new Teacher();
                teacher.setTid(resultSet.getInt("tid"));
                teacher.setName(resultSet.getString("name"));
                teacher.setAge(resultSet.getInt("age"));
                teacher.setSex(resultSet.getString("sex"));
                teacher.setCourse(resultSet.getString("course"));
                teachers.add(teacher);
                }
            }
            return teachers;
    }

    // 新しい教師をデータベースに追加するメソッド
    public void addTeacher(Teacher teacher) throws SQLException {
        String sql = "INSERT INTO teacher (tid, name, age, sex, course) VALUES (?, ?, ?, ?, ?)";
        try (Connection connection = JdbcTest.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, teacher.getTid());
            preparedStatement.setString(2, teacher.getName());
            preparedStatement.setInt(3, teacher.getAge());
            preparedStatement.setString(4, teacher.getSex());
            preparedStatement.setString(5, teacher.getCourse());
            preparedStatement.executeUpdate();
        }
    }


//    // 検索条件に基づいて教師情報を検索するメソッド(検索フォーム用)
//    public List<Teacher> searchTeachers(List<Teacher> filteredByName, String tid, String course) throws SQLException {
//        // 結果を格納する新しいリスト
//        List<Teacher> filteredTeachers = new ArrayList<>();
//
//        // filteredByNameが空またはnullでないことを確認
//        if (filteredByName == null || filteredByName.isEmpty()) {
//            return filteredTeachers; // 空のリストを返す
//        }
//
//        // filteredByNameリストから条件に合致する教師の情報を絞り込む
//        for (Teacher teacher : filteredByName) {
//            boolean matches = true;
//
//            // tid条件が指定されている場合、一致するかチェック
//            if (tid != null && !tid.isEmpty() && teacher.getTid() != Integer.parseInt(tid)) {
//                matches = false;
//            }
//
//            // course条件が指定されている場合、一致するかチェック
//            if (course != null && !course.isEmpty() && !teacher.getCourse().equals(course)) {
//                matches = false;
//            }
//
//            // すべての条件に一致する場合、結果リストに追加
//            if (matches) {
//                filteredTeachers.add(teacher);
//            }
//        }
//
//        return filteredTeachers;
//    }

     public List<Teacher> searchTeachers(String tid, String name, String course) throws SQLException {
        List<Teacher> teachers = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM teacher WHERE 1=1");
        //String sql = "SELECT * FROM teacher WHERE 1=1";
        System.out.println("Received name parameter: " + name);
        if (tid != null && !tid.isEmpty()) {
            sql.append(" AND tid = ?");
        }
        if (name != null && !name.isEmpty()) {
            System.out.println("Before setting name parameter: " + sql.toString()); // 追加
            sql.append(" AND name LIKE ?");
            System.out.println("After setting name parameter: " + sql.toString()); // 追加
        }
        if (course != null && !course.isEmpty()) {
            sql.append(" AND course = ?");
        }

            try (Connection connection = JdbcTest.getConnection();
                 PreparedStatement preparedStatement = connection.prepareStatement(sql.toString())) {

                int index = 1;
                if (tid != null && !tid.isEmpty()) {
                    System.out.println("Setting tid parameter to: " + tid); // パラメータ値のログ出力
                    preparedStatement.setInt(index++, Integer.parseInt(tid));
                }
                if (name != null && !name.isEmpty()) {
                    System.out.println("Setting name parameter to: %" + name + "%"); // パラメータ値のログ出力
                    preparedStatement.setString(index++, "%" + name + "%");
                }
                if (course != null && !course.isEmpty()) {
                    System.out.println("Setting course parameter to: " + course); // パラメータ値のログ出力
                    preparedStatement.setString(index++, course);
                }


                System.out.println("Final SQL Query: " + sql);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    Teacher teacher = new Teacher();
                    teacher.setTid(resultSet.getInt("tid"));
                    teacher.setName(resultSet.getString("name"));
                    teacher.setSex(resultSet.getString("sex"));
                    teacher.setAge(resultSet.getInt("age"));
                    teacher.setCourse(resultSet.getString("course"));
                    teachers.add(teacher);
                }
                System.out.println("Number of teachers found: " + teachers.size());
            }

        }
        return teachers;
    }

    // 名前による完全一致検索メソッド
    public List<Teacher> searchTeachersByNameExactMatch(String name) throws SQLException {
        List<Teacher> teachers = new ArrayList<>();
        String sql = "SELECT * FROM teacher WHERE name = ?";
        System.out.println("Executing search by name exact match: " + name); // ログ出力を追加

        try (Connection connection = JdbcTest.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, name);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    Teacher teacher = new Teacher();
                    teacher.setTid(resultSet.getInt("tid"));
                    teacher.setName(resultSet.getString("name"));
                    teacher.setSex(resultSet.getString("sex"));
                    teacher.setAge(resultSet.getInt("age"));
                    teacher.setCourse(resultSet.getString("course"));
                    teachers.add(teacher);
                }
            }
        }
        return teachers;
    }

    // IDに基づいて教師の情報を取得するメソッド
    public Teacher getTeacherById(int tid) throws SQLException {
        Teacher teacher = null;
        String sql = "SELECT * FROM teacher WHERE tid = ?";
        try (Connection connection = JdbcTest.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, tid);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    teacher = new Teacher();
                    teacher.setTid(resultSet.getInt("tid"));
                    teacher.setName(resultSet.getString("name"));
                    teacher.setAge(resultSet.getInt("age"));
                    teacher.setSex(resultSet.getString("sex"));
                    teacher.setCourse(resultSet.getString("course"));
                }
            }
        }
        return teacher;
    }

}



