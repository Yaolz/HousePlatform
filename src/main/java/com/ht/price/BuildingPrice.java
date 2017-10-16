package com.ht.price;

import com.ht.bean.Room;
import org.apache.struts2.json.annotations.JSON;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Set;

/**
 * Created by CHEN JX on 2017/8/30.
 *
 * 楼栋表的下拉框值对象,用于房屋查询
 */
@Entity
@Table(name = "t_building")
public class BuildingPrice {
    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "name")
    private String name;

    @ManyToOne
    @JoinColumn(name="buildings_id")
    private BuildingsPrice buildingsPrice;

    @OneToMany
    @JoinColumn(name="building_id")
    private Set<Room> roomSet;

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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "BuildingPrice{" + "id='" + id + '\'' + ", name='" + name + '\'' + '}';
    }
}
