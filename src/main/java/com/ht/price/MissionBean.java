package com.ht.price;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.math.BigInteger;
import java.util.Date;

/**
 * Created by CHEN JX on 2017/8/21.
 *
 * 绩效表
 */
public class MissionBean {

    private String id;//绩效表id

    private int quantity;//任务量

    private Date start_time;//开始时间

    private Date end_time;//结束时间

    private int status;//状态

    private double bonus_percent;//销售提成百分比

    private double basic_salary; //基本工资

    private String emp_id;//员工id

    private String name;//员工姓名

    private long coun ;//销售量

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getStart_time() {
        return start_time;
    }

    public void setStart_time(Date start_time) {
        this.start_time = start_time;
    }

    public Date getEnd_time() {
        return end_time;
    }

    public void setEnd_time(Date end_time) {
        this.end_time = end_time;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public double getBonus_percent() {
        return bonus_percent;
    }

    public void setBonus_percent(double bonus_percent) {
        this.bonus_percent = bonus_percent;
    }

    public double getBasic_salary() {
        return basic_salary;
    }

    public void setBasic_salary(double basic_salary) {
        this.basic_salary = basic_salary;
    }

    public String getEmp_id() {
        return emp_id;
    }

    public void setEmp_id(String emp_id) {
        this.emp_id = emp_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public long getCoun() {
        return coun;
    }

    public void setCoun(long coun) {
        this.coun = coun;
    }

    @Override
    public String toString() {
        return "MissionBean{" + "id='" + id + '\'' + ", quantity=" + quantity + ", start_time=" + start_time + ", end_time=" + end_time + ", status=" + status + ", bonus_percent=" + bonus_percent + ", basic_salary=" + basic_salary + ", emp_id='" + emp_id + '\'' + ", name='" + name + '\'' + ", coun=" + coun + '}';
    }
}
