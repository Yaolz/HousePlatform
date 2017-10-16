package com.ht.price;


import com.ht.bean.*;
import org.apache.struts2.json.annotations.JSON;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Set;

/**
 * Created by CHEN JX on 2017/8/28.
 *
 * 楼盘的值对象映射,主要用于页面的下拉选项
 */
@Entity
@Table(name = "t_buildings")
public class BuildingsPrice   {
    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "name")
    private String name;

    @Column(name = "logo")
    private String logo;//楼盘封面

    @Column(name = "status")
    private int status;//激活状态

    @ManyToOne
    @JoinColumn(name="agency_id")
    private AgencyPrice agencyPrice;

    @OneToMany
    @JoinColumn(name="buildings_id")
    private Set<BuildingPrice> buildingPriceSet;

    @OneToMany
    @JoinColumn(name="buildings_id")
    private Set<House> houseSet;

    @OneToMany
    @JoinColumn(name="buildings_id")
    private Set<Building> buildingSet;

    @OneToMany
    @JoinColumn(name="buildings_id")
    private Set<Employee> employeeSet;//一个楼盘下的多个员工

    @OneToMany
    @JoinColumn(name="buildings_id")
    private Set<Like> likes;//一个楼盘的多个点赞记录

    @OneToMany
    @JoinColumn(name = "buildings_id")
    private Set<Comment> comments;//一个楼盘下有多个评论

    @OneToMany
    @JoinColumn(name ="buildings_id")
    private Set<History> histories;//一个楼盘下有多个历史纪录

    @OneToMany
    @JoinColumn(name = "buildings_id")
    private Set<Message> messages;//一个楼盘下有多个留言

    @OneToMany
    @JoinColumn(name = "buildings_id")
    private Set<Activity> activities;

    @JSON(serialize = false)
    public Set<Activity> getActivities() {
        return activities;
    }

    public void setActivities(Set<Activity> activities) {
        this.activities = activities;
    }

    @JSON(serialize = false)
    public Set<Message> getMessages() {
        return messages;
    }

    public void setMessages(Set<Message> messages) {
        this.messages = messages;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    @JSON(serialize = false)
    public Set<History> getHistories() {
        return histories;
    }

    public void setHistories(Set<History> histories) {
        this.histories = histories;
    }

    @JSON(serialize = false)
    public Set<Comment> getComments() {
        return comments;
    }

    public void setComments(Set<Comment> comments) {
        this.comments = comments;
    }

    @JSON(serialize = false)
    public Set<Employee> getEmployeeSet() {
        return employeeSet;
    }

    public void setEmployeeSet(Set<Employee> employeeSet) {
        this.employeeSet = employeeSet;
    }

    @JSON(serialize = false)
    public Set<Like> getLikes() {
        return likes;
    }

    public void setLikes(Set<Like> likes) {
        this.likes = likes;
    }

    @JSON(serialize = false)
    public Set<Building> getBuildingSet() {
        return buildingSet;
    }

    public void setBuildingSet(Set<Building> buildingSet) {
        this.buildingSet = buildingSet;
    }

    @JSON(serialize = false)
    public Set<House> getHouseSet() {
        return houseSet;
    }

    public void setHouseSet(Set<House> houseSet) {
        this.houseSet = houseSet;
    }

    @JSON(serialize = false)
    public Set<BuildingPrice> getBuildingPriceSet() {
        return buildingPriceSet;
    }

    public void setBuildingPriceSet(Set<BuildingPrice> buildingPriceSet) {
        this.buildingPriceSet = buildingPriceSet;
    }

    @JSON(serialize = false)
    public AgencyPrice getAgencyPrice() {
        return agencyPrice;
    }

    public void setAgencyPrice(AgencyPrice agencyPrice) {
        this.agencyPrice = agencyPrice;
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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "BuildingsPrice{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                '}';
    }
}
