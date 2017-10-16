package com.ht.bean;

import com.ht.price.AgencyPrice;
import com.ht.price.BuildingsPrice;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by CHEN JX on 2017/8/21.
 * 活动表
 */
@Entity
@Table(name = "t_activity")
public class Activity {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "title")
    private String title;

    @Column(name = "start_time")
    private Date start_time;//开始时间

    @Column(name = "end_time")
    private Date end_time;//结束时间

    @Column(name = "address")
    private String address;

    @Column(name = "content")
    private String content;//活动内容

    @Column(name = "logo")
    private String logo;//活动图片

    @Column(name="status")
    private int status;//状态

    @ManyToOne
    @JoinColumn(name = "agency_id")
    private AgencyPrice agencyPrice;

    @ManyToOne
    @JoinColumn(name = "buildings_id")
    private BuildingsPrice buildingsPrice;

    public BuildingsPrice getBuildingsPrice() {
        return buildingsPrice;
    }

    public void setBuildingsPrice(BuildingsPrice buildingsPrice) {
        this.buildingsPrice = buildingsPrice;
    }

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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getStart_time() {
        return start_time;
    }

    public void setStart_time(Date start_time) {
        this.start_time = start_time;
    }

    public Date getEnd_time() {
        return end_time;
    }

    public void setEnd_time(Date end_time) {
        this.end_time = end_time;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Activity{" +
                "id='" + id + '\'' +
                ", title='" + title + '\'' +
                ", start_time=" + start_time +
                ", end_time=" + end_time +
                ", address='" + address + '\'' +
                ", content='" + content + '\'' +
                ", logo='" + logo + '\'' +
                ", status=" + status +
                ", agencyPrice=" + agencyPrice +
                ", buildingsPrice=" + buildingsPrice +
                '}';
    }
}
