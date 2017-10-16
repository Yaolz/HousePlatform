package com.ht.bean;

import com.ht.price.BuildingsPrice;
import org.apache.struts2.json.annotations.JSON;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.nio.DoubleBuffer;
import java.util.Date;
import java.util.Set;

/**
 * Created by CHEN JX on 2017/8/21.
 *
 * 户型表
 */
@Entity
@Table(name = "t_house")
public class House {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "name")
    private String name;

    @Column(name = "logo")
    private String logo;//户型图片

    @Column(name = "intro")
    private String intro;//简介

    @Column(name = "area")
    private Double area;//面积

    @Column(name = "unit_price")
    private Double unit_price;//参考单价

    @Column(name = "created_time")
    private Date created_time;//创建时间

    @Column(name = "status")
    private int status;

    @ManyToOne
    @JoinColumn(name="buildings_id")
    private BuildingsPrice buildingsPrice;//楼盘值对象

    @OneToMany
    @JoinColumn(name="house_id")
    private Set<Room> roomSet;

    @OneToMany
    @JoinColumn(name="house_id")
    private Set<Appointment> appointmentSet;//一个户型有多个预约

    @JSON(serialize = false)
    public Set<Appointment> getAppointmentSet() {
        return appointmentSet;
    }

    public void setAppointmentSet(Set<Appointment> appointmentSet) {
        this.appointmentSet = appointmentSet;
    }

    @JSON(serialize = false)
    public Set<Room> getRoomSet() {
        return roomSet;
    }

    public void setRoomSet(Set<Room> roomSet) {
        this.roomSet = roomSet;
    }

    public BuildingsPrice getBuildingsPrice() {
        return buildingsPrice;
    }

    public void setBuildingsPrice(BuildingsPrice buildingsPrice) {
        this.buildingsPrice = buildingsPrice;
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

    public Double getArea() {
        return area;
    }

    public void setArea(Double area) {
        this.area = area;
    }

    public Double getUnit_price() {
        return unit_price;
    }

    public void setUnit_price(Double unit_price) {
        this.unit_price = unit_price;
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
        return "Hourse{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", logo='" + logo + '\'' +
                ", intro='" + intro + '\'' +
                ", area=" + area +
                ", unit_price=" + unit_price +
                ", created_time=" + created_time +
                ", status='" + status + '\'' +
                '}';
    }
}
