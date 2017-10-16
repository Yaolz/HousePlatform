package com.ht.bean;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Set;

/**
 * Created by CHEN JX on 2017/8/21.
 * 权限表
 */
@Entity
@Table(name = "t_permission")
public class Permission {

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
    private String created_time;

    @Column(name = "status")
    private int status;

    @OneToMany
    @JoinColumn(name="permission_id")
    private Set<Role_permission> role_permissions;


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

    public String getCreated_time() {
        return created_time;
    }

    public void setCreated_time(String created_time) {
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
        return "Permission{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", des='" + des + '\'' +
                ", created_time='" + created_time + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}
