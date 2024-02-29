//Teacher.java
package jp.main.model;

public class Teacher {
    private int tid;
    private String name;

    private int age;

    private String sex;

    private  String course;

    //コンストラクタ
    public Teacher() {}

    //getterとsetter
    public int getTid(){
        return tid;
    }

    public String getName(){
        return name;
    }

    public int getAge(){
        return age;
    }

    public String getSex(){
        return sex;
    }

    public String getCourse(){
        return course;
    }

    public void setTid(int tid){
        this.tid = tid;
    }

    public void setName(String name){
        this.name = name;
    }

    public void setAge(int age){
        this.age = age;
    }

    public void setSex(String sex){
        this.sex = sex;
    }

    public void setCourse(String course){
        this.course = course;
    }
}
