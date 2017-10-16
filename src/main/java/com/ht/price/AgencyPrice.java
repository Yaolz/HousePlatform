package com.ht.price;

import com.ht.bean.*;
import org.apache.struts2.json.annotations.JSON;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Set;

/**
 * Created by CHEN JX on 2017/8/28.
 * 经销商的值对象，主要用于页面的下拉选项
 */
@Entity
@Table(name = "t_agency")
public class AgencyPrice {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "name")
    private String name;

    @OneToMany
    @JoinColumn(name="agency_id")
    private Set<BuildingsPrice> buildingsPrices;

    @OneToMany
    @JoinColumn(name="agency_id")
    private Set<Employee> employees;//一个经销商有多个员工

    @OneToMany
    @JoinColumn(name = "agency_id")
    private Set<Customer> customerSet;

    @OneToMany
    @JoinColumn(name="agency_id")
    private Set<Appointment> appointmentSet;//一个经销商可以查询多个预约

    @OneToMany
    @JoinColumn(name = "agency_id")
    private Set<Sale> sales;

    @OneToMany
    @JoinColumn(name = "agency_id")
    private Set<Activity> activitySet;

    @JSON(serialize = false)
    public Set<Activity> getActivitySet() {
        return activitySet;
    }

    public void setActivitySet(Set<Activity> activitySet) {
        this.activitySet = activitySet;
    }

    @JSON(serialize = false)
    public Set<Sale> getSales() {
        return sales;
    }

    public void setSales(Set<Sale> sales) {
        this.sales = sales;
    }

    @JSON(serialize = false)
    public Set<Appointment> getAppointmentSet() {
        return appointmentSet;
    }

    public void setAppointmentSet(Set<Appointment> appointmentSet) {
        this.appointmentSet = appointmentSet;
    }

    @JSON(serialize = false)
    public Set<Customer> getCustomerSet() {
        return customerSet;
    }

    public void setCustomerSet(Set<Customer> customerSet) {
        this.customerSet = customerSet;
    }

    @JSON(serialize = false)
    public Set<Employee> getEmployees() {
        return employees;
    }

    public void setEmployees(Set<Employee> employees) {
        this.employees = employees;
    }

    @JSON(serialize = false)
    public Set<BuildingsPrice> getBuildingsPrices() {
        return buildingsPrices;
    }

    public void setBuildingsPrices(Set<BuildingsPrice> buildingsPrices) {
        this.buildingsPrices = buildingsPrices;
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

    @Override
    public String toString() {
        return "AgencyPrice{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                '}';
    }
}
