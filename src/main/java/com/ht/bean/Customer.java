package com.ht.bean;

import com.ht.price.AgencyPrice;
import com.ht.price.EmployeePrice;
import org.apache.struts2.json.annotations.JSON;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;
import java.util.Set;

/**
 * Created by CHEN JX on 2017/8/21.
 * 客户表
 */
@Entity
@Table(name = "t_customer")
public class Customer {


    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "name")
    private String name;

    @Column(name = "gender")
    private String gender;

    @Column(name = "birthday")
    private Date birthday;

    @Column(name = "identity_id")
    private String identity_id;//身份证号

    @Column(name = "email")
    private String email;

    @Column(name = "phone")
    private String phone;

    @Column(name = "address")
    private String address;

    @Column(name = "customer_type")
    private String customer_type;//客户类型

    @Column(name = "together")
    private String together;//共同购房人姓名

    @Column(name = "contract")
    private String contract;//电子版购房合同路径

    @Column(name = "archives")
    private String archives;//zip版电子档案路径

    @Column(name = "created_time")
    private Date created_time;

    @Column(name = "status")
    private int status;


    @ManyToOne
    @JoinColumn(name = "emp_id")
    private EmployeePrice employeePrice;

    @ManyToOne
    @JoinColumn(name = "agency_id")
    private AgencyPrice agencyPrice;

    @JSON(serialize = false)
    public AgencyPrice getAgencyPrice() {
        return agencyPrice;
    }

    public void setAgencyPrice(AgencyPrice agencyPrice) {
        this.agencyPrice = agencyPrice;
    }

    public EmployeePrice getEmployeePrice() {
        return employeePrice;
    }

    public void setEmployeePrice(EmployeePrice employeePrice) {
        this.employeePrice = employeePrice;
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

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getIdentity_id() {
        return identity_id;
    }

    public void setIdentity_id(String identity_id) {
        this.identity_id = identity_id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCustomer_type() {
        return customer_type;
    }

    public void setCustomer_type(String customer_type) {
        this.customer_type = customer_type;
    }

    public String getTogether() {
        return together;
    }

    public void setTogether(String together) {
        this.together = together;
    }

    public String getContract() {
        return contract;
    }

    public void setContract(String contract) {
        this.contract = contract;
    }

    public String getArchives() {
        return archives;
    }

    public void setArchives(String archives) {
        this.archives = archives;
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
        return "Customer{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", gender='" + gender + '\'' +
                ", birthday=" + birthday +
                ", identity_id='" + identity_id + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", address='" + address + '\'' +
                ", customer_type='" + customer_type + '\'' +
                ", together='" + together + '\'' +
                ", contract='" + contract + '\'' +
                ", archives='" + archives + '\'' +
                ", created_time=" + created_time +
                ", status=" + status +
                '}';
    }
}
