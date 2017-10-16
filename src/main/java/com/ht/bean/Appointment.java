package com.ht.bean;

import com.ht.price.AgencyPrice;
import com.ht.price.EmployeePrice;
import com.ht.price.UserPrice;
import org.apache.struts2.json.annotations.JSON;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by CHEN JX on 2017/8/21.
 * 购房预约表
 */
@Entity
@Table(name = "t_appointment")
public class Appointment {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "app_arrive_time")
    private Date app_arrive_time;//预约看房时间

    @Column(name = "arrive_time")
    private Date arrive_time;//真实看房时间

    @Column(name = "app_status")
    private int app_status;//预约状态

    @Column(name = "created_time")
    private Date created_time;//创建时间

    @Column(name = "status")
    private int status;//状态

    @ManyToOne
    @JoinColumn(name="user_id")
    private UserPrice userPrice;//一个预约属于一个用户

    @ManyToOne
    @JoinColumn(name="emp_id")
    private EmployeePrice employeePrice;//一个预约属于一个员工

    @ManyToOne
    @JoinColumn(name="agency_id")
    private AgencyPrice agencyPrice;//一个预约属于一个经销商

    @ManyToOne
    @JoinColumn(name="house_id")
    private House house;//一个预约有属于一个户型


    public House getHouse() {
        return house;
    }

    public void setHouse(House house) {
        this.house = house;
    }

    public UserPrice getUserPrice() {
        return userPrice;
    }

    public void setUserPrice(UserPrice userPrice) {
        this.userPrice = userPrice;
    }

    public EmployeePrice getEmployeePrice() {
        return employeePrice;
    }

    public void setEmployeePrice(EmployeePrice employeePrice) {
        this.employeePrice = employeePrice;
    }

    @JSON(serialize = false)
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

    public Date getApp_arrive_time() {
        return app_arrive_time;
    }

    public void setApp_arrive_time(Date app_arrive_time) {
        this.app_arrive_time = app_arrive_time;
    }

    public Date getArrive_time() {
        return arrive_time;
    }

    public void setArrive_time(Date arrive_time) {
        this.arrive_time = arrive_time;
    }

    public int getApp_status() {
        return app_status;
    }

    public void setApp_status(int app_status) {
        this.app_status = app_status;
    }

    public int getStatus() {
        return status;
    }

    public Date getCreated_time() {
        return created_time;
    }

    public void setCreated_time(Date created_time) {
        this.created_time = created_time;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Appointment{" +
                "id='" + id + '\'' +
                ", app_arrive_time=" + app_arrive_time +
                ", arrive_time=" + arrive_time +
                ", app_status='" + app_status + '\'' +
                ", created_time=" + created_time +
                ", status=" + status +
                '}';
    }
}
