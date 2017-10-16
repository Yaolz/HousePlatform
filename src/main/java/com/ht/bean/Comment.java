package com.ht.bean;

import com.ht.price.BuildingsPrice;
import com.ht.price.UserPrice;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by CHEN JX on 2017/8/21.
 * 评价表
 */
@Entity
@Table(name = "t_comment")
public class Comment {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "content")
    private String content;//评价内容

    @Column(name = "comment_time")
    private Date comment_time;//评价时间

    @Column(name = "status")
    private int status;//状态

    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserPrice userPrice;//一个评价属于一个用户

    @ManyToOne
    @JoinColumn(name = "buildings_id")
    private BuildingsPrice buildingsPrice;//一个评价属于有一个楼盘

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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getComment_time() {
        return comment_time;
    }

    public void setComment_time(Date comment_time) {
        this.comment_time = comment_time;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Comment{" +
                "id='" + id + '\'' +
                ", content='" + content + '\'' +
                ", comment_time=" + comment_time +
                ", status='" + status + '\'' +
                '}';
    }
}
