//TeacherService.java
package jp.main.service;

import jp.main.dao.TeacherDAO;
import jp.main.model.Teacher;


import java.sql.*;
import java.util.List;


public class TeacherService {
    private TeacherDAO teacherDAO = new TeacherDAO();

    // 教師の情報をIDに基づいて取得するメソッド
//    public Teacher getTeacherById(int tid) throws SQLException {
//        return teacherDAO.getTeacher(tid);
//    }

    // 全ての教師の情報を取得するメソッド
    public List<Teacher> getAllTeachers() throws SQLException {
        return teacherDAO.getAllTeachers();
    }

    // 教師情報をデータベースに追加するメソッド
    public void addTeacher(Teacher teacher) throws SQLException {
        teacherDAO.addTeacher(teacher);
    }

    // 教師情報を更新するメソッド
    public void updateTeacher(Teacher teacher) throws SQLException {
        teacherDAO.updateTeacher(teacher);
    }

    // 教師情報を削除するメソッド
//   public void deleteTeacher(int tid) throws SQLException {
//       teacherDAO.deleteTeacher(tid);
//   }

    // 検索条件に基づいて教師情報を検索するメソッド(検索フォーム用)
    public List<Teacher> searchTeachers(String tid, String name, String course) throws SQLException {
        return teacherDAO.searchTeachers(tid, name, course);
    }

    // 名前による完全一致検索メソッド
    public List<Teacher> searchTeachersByNameExactMatch(String name) throws SQLException {
        return teacherDAO.searchTeachersByNameExactMatch(name);
    }


    public Teacher getTeacherById(int tid) throws SQLException {
        // データベースから教師情報を取得する
        return teacherDAO.getTeacherById(tid);
    }
}
