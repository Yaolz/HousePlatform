package com.ht.bean;

import com.ht.price.AgencyPrice;
import com.ht.price.CustomerPrice;
import com.ht.price.EmployeePrice;
import org.apache.struts2.json.annotations.JSON;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by CHEN JX on 2017/8/21.
 *
 * 销售记录表
 */
@Entity
@Table(name = "t_sale")
public class Sale {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "sale_time")
    private Date sale_time;//销售时间

    @Column(name = "unit_price")
    private Double unit_price;//销售单价

    @Column(name = "discount")
    private Double discount;//销售折扣

    @Column(name = "total_cost")
    private Double total_cost;//销售总价

    @Column(name = "created_time")
    private Date created_time;

    @Column(name = "status")
    private int status;

    @ManyToOne
    @JoinColumn(name = "customer_id")
    private CustomerPrice customer;

    @ManyToOne
    @JoinColumn(name = "emp_id")
    private EmployeePrice employee;

    @ManyToOne
    @JoinColumn(name = "agency_id")
    private AgencyPrice agencyPrice;

    @ManyToOne
    @JoinColumn(name = "room_id")
    private Room room;

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }

    @JSON(serialize = false)
    public AgencyPrice getAgencyPrice() {
        return agencyPrice;
    }

    public void setAgencyPrice(AgencyPrice agencyPrice) {
        this.agencyPrice = agencyPrice;
    }

    public CustomerPrice getCustomer() {
        return customer;
    }

    public void setCustomer(CustomerPrice customer) {
        this.customer = customer;
    }

    public EmployeePrice getEmployee() {
        return employee;
    }

    public void setEmployee(EmployeePrice employee) {
        this.employee = employee;
    }
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getSale_time() {
        return sale_time;
    }

    public void setSale_time(Date sale_time) {
        this.sale_time = sale_time;
    }

    public Double getUnit_price() {
        return unit_price;
    }

    public void setUnit_price(Double unit_price) {
        this.unit_price = unit_price;
    }

    public Double getDiscount() {
        return discount;
    }

    public void setDiscount(Double discount) {
        this.discount = discount;
    }

    public Double getTotal_cost() {
        return total_cost;
    }

    public void setTotal_cost(Double total_cost) {
        this.total_cost = total_cost;
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
        return "Sale{" +
                "id='" + id + '\'' +
                ", sale_time=" + sale_time +
                ", unit_price=" + unit_price +
                ", discount=" + discount +
                ", total_cost=" + total_cost +
                ", created_time=" + created_time +
                ", status='" + status + '\'' +
                '}';
    }
}
