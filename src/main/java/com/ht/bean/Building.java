package com.ht.bean;

import com.ht.price.BuildingsPrice;
import org.apache.struts2.json.annotations.JSON;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;
import java.util.List;
import java.util.Set;

/**
 * Created by CHEN JX on 2017/8/21.
 *
 * 楼栋表
 */
@Entity
@Table(name = "t_building")
public class Building {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "name")
    private String name;

    @Column(name = "total_floor")
    private int total_floor;//总层数

    @Column(name = "total_lift")
    private int total_lift;//电梯数

    @Column(name = "floor_rooms")
    private int floor_rooms;//每层多少户

    @Column(name = "total_room")
    private int total_room;//总户数

    @Column(name = "created_time")
    private Date created_time;//创建时间

    @Column(name = "status")
    private int status;//状态

    @Transient
    private List<House> houses;

    @ManyToOne
    @JoinColumn(name="buildings_id")
    private BuildingsPrice buildingsPrice;

    public List<House> getHouses() {
        return houses;
    }

    public void setHouses(List<House> houses) {
        this.houses = houses;
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

    public int getTotal_floor() {
        return total_floor;
    }

    public void setTotal_floor(int total_floor) {
        this.total_floor = total_floor;
    }

    public int getTotal_lift() {
        return total_lift;
    }

    public void setTotal_lift(int total_lift) {
        this.total_lift = total_lift;
    }

    public int getFloor_rooms() {
        return floor_rooms;
    }

    public void setFloor_rooms(int floor_rooms) {
        this.floor_rooms = floor_rooms;
    }

    public int getTotal_room() {
        return total_room;
    }

    public void setTotal_room(int total_room) {
        this.total_room = total_room;
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
        return "Building{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", total_floor=" + total_floor +
                ", total_lift=" + total_lift +
                ", floor_rooms=" + floor_rooms +
                ", total_room=" + total_room +
                ", created_time=" + created_time +
                ", status='" + status + '\'' +
                '}';
    }
}
