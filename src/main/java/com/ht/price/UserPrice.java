package com.ht.price;

import com.ht.bean.*;
import org.apache.struts2.json.annotations.JSON;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Set;

/**
 * Created by CHEN JX on 2017/8/21.
 * 用户表值对象
 */
@Entity
@Table(name = "t_user")
public class UserPrice {
    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "name")
    private String name;//真实姓名

    @Column(name = "gender")
    private  String gender;

    @Column(name = "phone")
    private  String phone;

    @Column(name = "headicon")
    private String headicon;//用户头像

    @OneToMany
    @JoinColumn(name="user_id")
    private Set<Like> likeSet;//一个用户有多个点赞


    @OneToMany
    @JoinColumn(name="user_id")
    private Set<Appointment> appointments;//一个用户有多个预约

    @OneToMany
    @JoinColumn(name = "user_id")
    private Set<History> histories;//一个用户有多个历史记录

    @OneToMany
    @JoinColumn(name = "user_id")
    private Set<Message> messages;//一个用户有多个留言

    @OneToMany
    @JoinColumn(name="user_id")
    private Set<Comment> comments;//一个用户可以有多个评论

    @JSON(serialize = false)
    public Set<Like> getLikeSet() {
        return likeSet;
    }

    public void setLikeSet(Set<Like> likeSet) {
        this.likeSet = likeSet;
    }

    public String getHeadicon() {
        return headicon;
    }

    public void setHeadicon(String headicon) {
        this.headicon = headicon;
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
    public Set<Message> getMessages() {
        return messages;
    }

    public void setMessages(Set<Message> messages) {
        this.messages = messages;
    }

    @JSON(serialize = false)
    public Set<Appointment> getAppointments() {
        return appointments;
    }

    public void setAppointments(Set<Appointment> appointments) {
        this.appointments = appointments;
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

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "UserPrice{" + "id='" + id + '\'' +  ", name='" + name + '\'' + '}';
    }
}
