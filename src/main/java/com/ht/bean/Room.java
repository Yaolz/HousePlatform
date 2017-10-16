package com.ht.bean;

import com.ht.price.BuildingPrice;
import org.apache.struts2.json.annotations.JSON;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Set;

/**
 * Created by CHEN JX on 2017/8/21.
 * 房号表
 */
@Entity
@Table(name = "t_room")
public class Room {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "name")
    private int name;

    @Column(name = "sale_status")
    private String sale_status;//销售状态

    @ManyToOne
    @JoinColumn(name="building_id")
    private BuildingPrice building;//栋对象

    @ManyToOne
    @JoinColumn(name="house_id")
    private House house;//房间户型

    @Transient
    private int count =0;

    @OneToMany
    @JoinColumn(name = "room_id")
    private Set<Sale> sale;

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    @JSON(serialize = false)
    public Set<Sale> getSale() {
        return sale;
    }

    public void setSale(Set<Sale> sale) {
        this.sale = sale;
    }

    public House getHouse() {
        return house;
    }

    public void setHouse(House house) {
        this.house = house;
    }

    public BuildingPrice getBuilding() {
        return building;
    }

    public void setBuilding(BuildingPrice building) {
        this.building = building;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getName() {
        return name;
    }

    public void setName(int name) {
        this.name = name;
    }

    public String getSale_status() {
        return sale_status;
    }

    public void setSale_status(String sale_status) {
        this.sale_status = sale_status;
    }

    @Override
    public String toString() {
        return "Room{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", sale_status='" + sale_status + '\'' +
                '}';
    }
}
