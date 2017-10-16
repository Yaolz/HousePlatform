package com.ht.bean;

import com.ht.price.AgencyPrice;
import com.ht.price.BuildingPrice;
import com.ht.price.BuildingsPrice;
import com.ht.price.MissionBean;
import org.apache.struts2.json.annotations.JSON;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;
import java.util.Set;

/**
 * Created by CHEN JX on 2017/8/21.
 *
 * 员工表
 */
@Entity
@Table(name = "t_employee")
public class Employee {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "name")
    private String name;

    @Column(name = "email")
    private String email;

    @Column(name = "pwd")
    private String pwd;

    @Column(name = "phone")
    private String phone;

    @Column(name = "qq")
    private String qq;

    @Column(name = "wechat")
    private String wechat;

    @Column(name = "gender")
    private String gender;

    @Column(name = "exp")
    private String exp;//工作经验

    @Column(name = "des")
    private String des;//描述

    @Column(name = "address")
    private String address;

    @Column(name = "basic_salary")
    private Double basic_salary;//基本工资

    @Column(name = "headicon")
    private String headicon;//头像

    @Column(name = "intro")
    private String intro;//简介

    @Column(name = "created_time")
    private Date created_time;

    @Column(name = "status")
    private int status;

    @Transient
    private MissionBean missionBean;

    @ManyToOne
    @JoinColumn(name = "role_id")
    private Role role;//属于什么角色

    @ManyToOne
    @JoinColumn(name = "buildings_id")
    private BuildingsPrice buildingsPrice;

    @OneToMany
    @JoinColumn(name = "emp_id")
    private Set<Appointment> appointments;//一个员工有多个预约

    @ManyToOne
    @JoinColumn(name = "agency_id")
    private AgencyPrice agencyPrice;//一个员工属于一个经销商


    public MissionBean getMissionBean() {
        return missionBean;
    }

    public void setMissionBean(MissionBean missionBean) {
        this.missionBean = missionBean;
    }

    public BuildingsPrice getBuildingsPrice() {
        return buildingsPrice;
    }

    public void setBuildingsPrice(BuildingsPrice buildingsPrice) {
        this.buildingsPrice = buildingsPrice;
    }

    @JSON(serialize = false)
    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }


    public AgencyPrice getAgencyPrice() {
        return agencyPrice;
    }

    public void setAgencyPrice(AgencyPrice agencyPrice) {
        this.agencyPrice = agencyPrice;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPwd() {
        return pwd;
    }

    public void setPwd(String pwd) {
        this.pwd = pwd;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
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

    public String getExp() {
        return exp;
    }

    public void setExp(String exp) {
        this.exp = exp;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Double getBasic_salary() {
        return basic_salary;
    }

    public void setBasic_salary(Double basic_salary) {
        this.basic_salary = basic_salary;
    }

    public String getHeadicon() {
        return headicon;
    }

    public void setHeadicon(String headicon) {
        this.headicon = headicon;
    }

    public String getIntro() {
        return intro;
    }

    public void setIntro(String intro) {
        this.intro = intro;
    }

    public Date getCreated_time() {
        return created_time;
    }

    public void setCreated_time(Date created_time) {
        this.created_time = created_time;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", pwd='" + pwd + '\'' +
                ", phone='" + phone + '\'' +
                ", qq='" + qq + '\'' +
                ", wechat='" + wechat + '\'' +
                ", gender='" + gender + '\'' +
                ", exp='" + exp + '\'' +
                ", des='" + des + '\'' +
                ", address='" + address + '\'' +
                ", basic_salary=" + basic_salary +
                ", headicon='" + headicon + '\'' +
                ", intro='" + intro + '\'' +
                ", created_time=" + created_time +
                ", status=" + status +
                '}';
    }

}
