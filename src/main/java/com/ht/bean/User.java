package com.ht.bean;

import org.apache.struts2.json.annotations.JSON;
import org.hibernate.annotations.GenericGenerator;

import javax.naming.Name;
import javax.persistence.*;
import java.util.Date;
import java.util.Set;

/**
 * Created by CHEN JX on 2017/8/21.
 * 用户表
 */
@Entity
@Table(name = "t_user")
public class User {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "email")
    private String email;

    @Column(name = "phone")
    private String phone;

    @Column(name = "pwd")
    private String pwd;//MD5加密

    @Column(name = "qq")
    private String qq;

    @Column(name = "wechat")
    private String wechat;//微信号

    @Column(name = "gender")
    private String gender;//性别

    @Column(name = "birthday")
    private Date birthday;//生日

    @Column(name = "nickname")
    private String nickname;//昵称

    @Column(name = "name")
    private String name;//真实姓名

    @Column(name = "headicon")
    private String headicon;//用户头像

   @Column(name="status")
    private int status;//状态

    @ManyToOne
    @JoinColumn(name="role_id")
    private Role role;//用户的这个id字段来源与角色表，用户是多方，角色表是一方，多对1

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public String getWechat() {
        return wechat;
    }

    public void setWechat(String wechat) {
        this.wechat = wechat;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getHeadicon() {
        return headicon;
    }

    public void setHeadicon(String headicon) {
        this.headicon = headicon;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "User{" +
                "id='" + id + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", pwd='" + pwd + '\'' +
                ", qq='" + qq + '\'' +
                ", wechat='" + wechat + '\'' +
                ", gender='" + gender + '\'' +
                ", birthday=" + birthday +
                ", nickname='" + nickname + '\'' +
                ", name='" + name + '\'' +
                ", headicon='" + headicon + '\'' +
                ", role=" + role +
                ", status=" + status +
                '}';
    }
}
