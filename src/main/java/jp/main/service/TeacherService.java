//TeacherService.java
package jp.main.service;

import jp.main.dao.TeacherDAO;
import jp.main.model.Teacher;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;


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

    // 検索条件に基づいて教師情報を検索するメソッド(検索フォーム用)
    public List<Teacher> searchTeachers(String tid, String name, String course) throws SQLException {
        return teacherDAO.searchTeachers(tid, name, course);
    }

    // 名前の完全一致検索を含む条件で検索する新しいメソッド
    public List<Teacher> searchTeachersWithConditions(String tid, String name, String course) throws SQLException {
        if (!name.isEmpty()) {
            List<Teacher> teachersByName = searchTeachersByNameExactMatch(name);
            if (!tid.isEmpty() || !course.isEmpty()) {
                // 名前での検索結果をさらにtidやcourseでフィルタリング
                return teachersByName.stream()
                        .filter(teacher -> (tid.isEmpty() || String.valueOf(teacher.getTid()).equals(tid)) &&
                                (course.isEmpty() || teacher.getCourse().equals(course)))
                        .collect(Collectors.toList());
            } else {
                return teachersByName; // 名前のみでフィルタリングした結果を返す
            }
        } else {
            // 名前以外の条件で検索
            return searchTeachers(tid, "", course);
        }
    }



    // 名前による完全一致検索メソッド
    public List<Teacher> searchTeachersByNameExactMatch(String name) throws SQLException {
        return teacherDAO.searchTeachersByNameExactMatch(name);
    }


    public Teacher getTeacherById(int tid) throws SQLException {
        // データベースから教師情報を取得する
        return teacherDAO.getTeacherById(tid);
    }

    public List<Teacher> filterTeachers(List<Teacher> filteredByName, String tid, String course) throws SQLException {
        // 空のリストやnullが渡された場合は、空のリストを返す
        if (filteredByName == null || filteredByName.isEmpty()) {
            return new ArrayList<>();
        }

        return filteredByName.stream()
                .filter(teacher -> {
                    // tidでのフィルタリング（tidが空でない場合のみフィルタリングを実行）
                    boolean tidMatch = tid.isEmpty() || String.valueOf(teacher.getTid()).equals(tid);
                    // courseでのフィルタリング（courseが空でない場合のみフィルタリングを実行）
                    boolean courseMatch = course.isEmpty() || teacher.getCourse().equalsIgnoreCase(course);
                    return tidMatch && courseMatch;
                })
                .collect(Collectors.toList());
    }
}
