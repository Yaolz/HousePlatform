package com.ht.bean;

import com.ht.price.BuildingsPrice;
import com.ht.price.UserPrice;
import org.apache.struts2.json.annotations.JSON;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by CHEN JX on 2017/8/21.
 * <p>
 * 留言表
 */
@Entity
@Table(name = "t_message")
public class Message {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "content")
    private String content;//留言内容

    @Column(name = "reply")
    private String reply;//回复内容

    @Column(name = "leave_time")
    private Date leave_time;//留言时间

    @Column(name = "reply_time")
    private Date reply_time;//回复时间

    @Column(name = "status")
    private int status;//状态

    @ManyToOne
    @JoinColumn(name = "user_id")
    private UserPrice userPrice;//一个留言属于一个用户

    @ManyToOne
    @JoinColumn(name = "buildings_id")
    private BuildingsPrice buildingsPrice;//一个留言属于一个楼盘


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

    public String getReply() {
        return reply;
    }

    public void setReply(String reaply) {
        this.reply = reaply;
    }

    public Date getLeave_time() {
        return leave_time;
    }

    public void setLeave_time(Date leave_time) {
        this.leave_time = leave_time;
    }

    public Date getReply_time() {
        return reply_time;
    }

    public void setReply_time(Date reply_time) {
        this.reply_time = reply_time;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Message{" +
                "id='" + id + '\'' +
                ", content='" + content + '\'' +
                ", reaply='" + reply + '\'' +
                ", leave_time=" + leave_time +
                ", reply_time=" + reply_time +
                ", status='" + status + '\'' +
                '}';
    }
}
