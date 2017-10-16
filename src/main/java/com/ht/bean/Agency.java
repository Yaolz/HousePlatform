package com.ht.bean;

import org.apache.struts2.json.annotations.JSON;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;
import java.util.Set;

/**
 * Created by CHEN JX on 2017/8/21.
 * 经销商
 */
@Entity
@Table(name = "t_agency")
public class Agency {

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

    @Column(name = "leader")
    private String leader;  //负责人姓名

    @Column(name = "phone")
    private String phone;//手机号码

    @Column(name = "tel")
    private String tel;

    @Column(name = "address")
    private String address;

    @Column(name = "logo")
    private String logo;

    @Column(name = "intro")
    private String intro;

    @Column(name = "created_time")
    private Date created_time;

    @Column(name = "checked_status")
    private int checked_status;

    @Column(name = "status")
    private int status;

    @ManyToOne
    @JoinColumn(name="role_id")
    private Role role;//用户的这个id字段来源与角色表，用户是多方，角色表是一方，多对1

    @OneToMany
    @JoinColumn(name="agency_id")
    private Set<Buildings> buildingsSet;//一个经销商有多个楼盘

    @JSON(serialize = false)
    public Set<Buildings> getBuildingsSet() {
        return buildingsSet;
    }

    public void setBuildingsSet(Set<Buildings> buildingsSet) {
        this.buildingsSet = buildingsSet;
    }

    @JSON(serialize = false)
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

    public String getLeader() {
        return leader;
    }

    public void setLeader(String leader) {
        this.leader = leader;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
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

    public int getChecked_status() {
        return checked_status;
    }

    public void setChecked_status(int checked_status) {
        this.checked_status = checked_status;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Agency{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", pwd='" + pwd + '\'' +
                ", leader='" + leader + '\'' +
                ", phone='" + phone + '\'' +
                ", tel='" + tel + '\'' +
                ", address='" + address + '\'' +
                ", logo='" + logo + '\'' +
                ", intro='" + intro + '\'' +
                ", create_timed=" + created_time +
                ", checked_status='" + checked_status + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
