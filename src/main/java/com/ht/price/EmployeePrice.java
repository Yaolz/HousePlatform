package com.ht.price;

import javax.persistence.Id;

import com.ht.bean.Appointment;
import com.ht.bean.Customer;
import com.ht.bean.Mission;
import com.ht.bean.Sale;
import org.apache.struts2.json.annotations.JSON;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Set;


/**
 * Created by CHEN JX on 2017/8/21.
 *
 * 员工值对象
 */

@Entity
@Table(name = "t_employee")
public class EmployeePrice {
    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "name")
    private String name;

    @OneToMany
    @JoinColumn(name = "emp_id")
    private Set<Customer> customerSet;

    @ManyToOne
    @JoinColumn(name = "buildings_id")
    private BuildingsPrice buildingsPrice;

    @OneToMany
    @JoinColumn(name = "emp_id")
    private Set<Appointment> appointments;//一个员工有多个预约

    @OneToMany
    @JoinColumn(name = "emp_id")//销售记录表的外键
    private Set<Sale> sales;

    @OneToMany
    @JoinColumn(name = "emp_id")
    private Set<Mission> missionSet;

    @ManyToOne
    @JoinColumn(name = "agency_id")
    private AgencyPrice agencyPrice;

    public AgencyPrice getAgencyPrice() {
        return agencyPrice;
    }

    public void setAgencyPrice(AgencyPrice agencyPrice) {
        this.agencyPrice = agencyPrice;
    }

    @JSON(serialize = false)
    public Set<Mission> getMissionSet() {
        return missionSet;
    }

    public void setMissionSet(Set<Mission> missionSet) {
        this.missionSet = missionSet;
    }

    public BuildingsPrice getBuildingsPrice() {
        return buildingsPrice;
    }

    public void setBuildingsPrice(BuildingsPrice buildingsPrice) {
        this.buildingsPrice = buildingsPrice;
    }

    @JSON(serialize = false)
    public Set<Sale> getSales() {
        return sales;
    }

    public void setSales(Set<Sale> sales) {
        this.sales = sales;
    }

    @JSON(serialize = false)
    public Set<Appointment> getAppointments() {
        return appointments;
    }

    public void setAppointments(Set<Appointment> appointments) {
        this.appointments = appointments;
    }

    @JSON(serialize = false)
    public Set<Customer> getCustomerSet() {
        return customerSet;
    }

    public void setCustomerSet(Set<Customer> customerSet) {
        this.customerSet = customerSet;
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
}

