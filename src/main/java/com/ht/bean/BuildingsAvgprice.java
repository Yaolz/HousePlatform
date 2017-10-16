package com.ht.bean;

import com.ht.price.BuildingsPrice;
import org.apache.struts2.json.annotations.JSON;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by CHEN JX on 2017/8/21.
 *
 * 楼盘历史价格表
 */
@Entity
@Table(name = "t_buildings_avgprice")
public class BuildingsAvgprice {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "avg_price")
    private double avg_price;

    @Column(name ="recording_time")
    private Date recording_time;

    @ManyToOne
    @JoinColumn(name="buildings_id")
    private Buildings buildings;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public double getAvg_price() {
        return avg_price;
    }

    public void setAvg_price(double avg_price) {
        this.avg_price = avg_price;
    }

    public Date getRecording_time() {
        return recording_time;
    }

    public void setRecording_time(Date recording_time) {
        this.recording_time = recording_time;
    }

    @JSON(serialize = false)
    public Buildings getBuildings() {
        return buildings;
    }

    public void setBuildings(Buildings buildings) {
        this.buildings = buildings;
    }

    @Override
    public String toString() {
        return "BuildingsAvgprice{" +
                "id='" + id + '\'' +
                ", avg_price=" + avg_price +
                ", recording_time=" + recording_time +
                '}';
    }
}
