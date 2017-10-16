package com.ht.bean;

import org.apache.struts2.json.annotations.JSON;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;
import java.util.Set;

/**
 * Created by CHEN JX on 2017/8/21.
 * 角色表
 */
@Entity
@Table(name = "t_role")
public class Role {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "name")
    private String name;

    @Column(name = "des")
    private String des;

    @Column(name = "created_time")
    private Date created_time;

    @Column(name = "status")
    private int status;

    @OneToMany
    @JoinColumn(name="role_id")
    private Set<Role_permission> role_permissions;//一个角色可以有多个权限

    @OneToMany
    @JoinColumn(name="role_id")
    private Set<User> userSet;//一个角色表可以被多个用户使用

    @OneToMany
    @JoinColumn(name="role_id")
    private Set<Activity> activitySet;//一个角色表可以被多个经销商使用

    @OneToMany
    @JoinColumn(name="role_id")
    private Set<Admin>  adminSet;//一个角色表可以被多个管理员使用

    @OneToMany
    @JoinColumn(name="role_id")
    private Set<Employee> employeeSet;//一个角色表可以被多个经销商员工使用

    @JSON(serialize = false)
    public Set<Employee> getEmployeeSet() {
        return employeeSet;
    }

    public void setEmployeeSet(Set<Employee> employeeSet) {
        this.employeeSet = employeeSet;
    }

    @JSON(serialize = false)
    public Set<User> getUserSet() {
        return userSet;
    }

    public void setUserSet(Set<User> userSet) {
        this.userSet = userSet;
    }

    @JSON(serialize = false)
    public Set<Activity> getActivitySet() {
        return activitySet;
    }

    public void setActivitySet(Set<Activity> activitySet) {
        this.activitySet = activitySet;
    }

    @JSON(serialize = false)
    public Set<Admin> getAdminSet() {
        return adminSet;
    }

    public void setAdminSet(Set<Admin> adminSet) {
        this.adminSet = adminSet;
    }


    public Date getCreated_time() {
        return created_time;
    }

    public void setCreated_time(Date created_time) {
        this.created_time = created_time;
    }

    @JSON(serialize = false)
    public Set<Role_permission> getRole_permissions() {
        return role_permissions;
    }

    public void setRole_permissions(Set<Role_permission> role_permissions) {
        this.role_permissions = role_permissions;
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

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Role{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", des='" + des + '\'' +
                ", created_time=" + created_time +
                ", status=" + status +
                '}';
    }
}
