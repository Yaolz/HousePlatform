package com.ht.bean;

import com.ht.price.EmployeePrice;
import org.apache.struts2.json.annotations.JSON;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by CHEN JX on 2017/8/21.
 *
 * 绩效表
 */
@Entity
@Table(name = "t_mission")
public class Mission {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "quantity")
    private int quantity;//任务量

    @Column(name = "start_time")
    private Date start_time;//开始时间

    @Column(name = "end_time")
    private Date end_time;//结束时间

    @Column(name = "status")
    private int status;//结束时间

    @Column(name = "bonus_percent")
    private Double bonus_percent;//销售提成百分比


    @ManyToOne
    @JoinColumn(name = "emp_id")
    private EmployeePrice employeePrice;

    public EmployeePrice getEmployeePrice() {
        return employeePrice;
    }

    public void setEmployeePrice(EmployeePrice employeePrice) {
        this.employeePrice = employeePrice;
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

    public Double getBonus_percent() {
        return bonus_percent;
    }

    public void setBonus_percent(Double bonus_percent) {
        this.bonus_percent = bonus_percent;
    }

    @Override
    public String toString() {
        return "Mission{" + "id='" + id + '\'' +
                ", quantity=" + quantity +
                ", start_time=" + start_time +
                ", end_time=" + end_time +
                ", status=" + status +
                ", bonus_percent=" + bonus_percent + '}';
    }
}
