package com.ht.bean;

import com.ht.price.BuildingsPrice;
import com.ht.price.UserPrice;
import org.apache.struts2.json.annotations.JSON;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;
import java.util.Set;

/**
 * Created by CHEN JX on 2017/8/21.
 *
 * 点赞记录表
 */
@Entity
@Table(name = "t_like")
public class Like {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "created_time")
    private Date created_time;//点赞创建时间

    @ManyToOne
    @JoinColumn(name="buildings_id")
    private BuildingsPrice buildingsPrice;//一个赞属于一个楼盘

    @ManyToOne
    @JoinColumn(name="user_id")
    private UserPrice userPrice;//一个赞属于一个用户

    @JSON(serialize = false)
    public UserPrice getUserPrice() {
        return userPrice;
    }

    public void setUserPrice(UserPrice userPrice) {
        this.userPrice = userPrice;
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

    public Date getCreated_time() {
        return created_time;
    }

    public void setCreated_time(Date created_time) {
        this.created_time = created_time;
    }

    @Override
    public String toString() {
        return "Like{" +
                "id='" + id + '\'' +
                ", created_time=" + created_time +
                '}';
    }
}
