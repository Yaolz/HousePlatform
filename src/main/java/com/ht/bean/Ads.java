package com.ht.bean;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by CHEN JX on 2017/8/21.
 * 广告表
 */
@Entity
@Table(name = "t_ads")
public class Ads {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "title")
    private String title;

    @Column(name = "content")
    private String content;//广告描述

    @Column(name = "logo")
    private String logo;//广告图片路径

    @Column(name = "ad_url")
    private String ad_url;//广告URL路径，可链接到单独的广告页面

    @Column(name = "show_status")
    private int show_status;//是否显示Y或N

    @Column(name = "show_order")
    private int show_order;//显示顺序，按照主页，详情页的从左到右，从上到下的顺序规定广告位置

    @Column(name = "created_time")
    private Date created_time;

    @Column(name = "status")
    private int status;

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

    public String getAd_url() {
        return ad_url;
    }

    public void setAd_url(String ad_url) {
        this.ad_url = ad_url;
    }

    public int getShow_status() {
        return show_status;
    }

    public void setShow_status(int show_status) {
        this.show_status = show_status;
    }

    public int getShow_order() {
        return show_order;
    }

    public void setShow_order(int show_order) {
        this.show_order = show_order;
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
        return "Ads{" +
                "id='" + id + '\'' +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", logo='" + logo + '\'' +
                ", ad_url='" + ad_url + '\'' +
                ", show_status='" + show_status + '\'' +
                ", show_order=" + show_order +
                ", created_time=" + created_time +
                ", status='" + status + '\'' +
                '}';
    }
}
