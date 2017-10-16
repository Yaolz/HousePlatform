package com.ht.bean;

import org.apache.struts2.json.annotations.JSON;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by CHEN JX on 2017/8/21.
 *
 * 楼盘图
 */

@Entity
@Table(name = "t_buildings_img")
public class BuildingsImg {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "img_path")
    private String img_path;//图片路径

    @Column(name = "img_des")
    private String img_des;//图片描述

    @Column(name = "created_time")
    private Date created_time;//图片添加时间

    @ManyToOne
    @JoinColumn(name = "buildings_id")
    private Buildings buildings;

    public Date getCreated_time() {
        return created_time;
    }

    public void setCreated_time(Date created_time) {
        this.created_time = created_time;
    }

    @JSON(serialize = false)
    public Buildings getBuildings() {
        return buildings;
    }

    public void setBuildings(Buildings buildings) {
        this.buildings = buildings;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getImg_path() {
        return img_path;
    }

    public void setImg_path(String img_path) {
        this.img_path = img_path;
    }

    public String getImg_des() {
        return img_des;
    }

    public void setImg_des(String img_des) {
        this.img_des = img_des;
    }



    @Override
    public String toString() {
        return "Buildings_img{" +
                "id='" + id + '\'' +
                ", img_path='" + img_path + '\'' +
                ", img_des='" + img_des + '\'' +
                ", created_time=" + created_time +
                '}';
    }
}
