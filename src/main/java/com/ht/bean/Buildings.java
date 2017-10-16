package com.ht.bean;

import org.apache.struts2.json.annotations.JSON;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Date;
import java.util.Set;

/**
 * Created by CHEN JX on 2017/8/21.
 *
 * 楼盘表
 */
@Entity
@Table(name = "t_buildings")
public class Buildings {

    @Id
    @GeneratedValue(generator = "uuid")
    @GenericGenerator(name = "uuid", strategy = "uuid")
    @Column(name = "id")
    private String id;

    @Column(name = "name")
    private String name;

    @Column(name = "area")
    private String area;

    @Column(name = "address")
    private String address;

    @Column(name = "floor_area")
    private Double floor_area;//战地面积

    @Column(name = "building_area")
    private Double building_area;//建筑面积

    @Column(name = "house_type")
    private String house_type;//房源类型

    @Column(name = "building_type")
    private String building_type;//建筑类型

    @Column(name = "longitude")
    private Double longitude;//经度

    @Column(name = "latitude")
    private Double latitude;//维度

    @Column(name = "avg_price")
    private Double avg_price;//楼盘均价

    @Column(name = "company")
    private String company;//开发公司

    @Column(name = "open_date")
    private Date open_date;//开盘时间

    @Column(name = "total_rooms")
    private int total_rooms;//总套数

    @Column(name = "reception_address")
    private String reception_address;//接待地址

    @Column(name = "tel")
    private String tel;//楼盘售楼电话

    @Column(name = "green_ratio")
    private Double green_ratio;//绿化率

    @Column(name = "plot_ratio")
    private Double plot_ratio;//容积率

    @Column(name = "property_company")
    private String property_company;//物业公司

    @Column(name = "property_fee")
    private double property_fee;//物业费

    @Column(name = "car_station")
    private int car_station;//车位数

    @Column(name = "traffic")
    private String traffic;//交通类型

    @Column(name = "equipments")
    private String equipments;//周边配套

    @Column(name = "logo")
    private String logo;//楼盘封面

    @Column(name = "intro")
    private String intro;//简介

    @Column(name = "created_time")
    private Date created_time;//创建时间

    @Column(name = "province")
    private String province;//楼盘所属省份

    @Column(name = "city")
    private String city;//楼盘所属市

    @Column(name = "status")
    private int status;//激活状态

    @Transient
    private int status1 =0;

    @ManyToOne
    @JoinColumn(name="agency_id")
    private Agency agency;

    @OneToMany
    @JoinColumn(name="buildings_id")
    private Set<BuildingsAvgprice> buildingsAvgprice;

    @OneToMany
    @JoinColumn(name = "buildings_id")
    private Set<BuildingsImg> buildingsImgSet;

    public int getStatus1() {
        return status1;
    }

    public void setStatus1(int status1) {
        this.status1 = status1;
    }

    @JSON(serialize = false)
    public Set<BuildingsAvgprice> getBuildingsAvgprice() {
        return buildingsAvgprice;
    }

    public void setBuildingsAvgprice(Set<BuildingsAvgprice> buildingsAvgprice) {
        this.buildingsAvgprice = buildingsAvgprice;
    }

    @JSON(serialize = false)
    public Set<BuildingsImg> getBuildingsImgSet() {
        return buildingsImgSet;
    }

    public void setBuildingsImgSet(Set<BuildingsImg> buildingsImgSet) {
        this.buildingsImgSet = buildingsImgSet;
    }

    @JSON(serialize = false)
    public Agency getAgency() {
        return agency;
    }

    public void setAgency(Agency agency) {
        this.agency = agency;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
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

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Double getFloor_area() {
        return floor_area;
    }

    public void setFloor_area(Double floor_area) {
        this.floor_area = floor_area;
    }

    public Double getBuilding_area() {
        return building_area;
    }

    public void setBuilding_area(Double building_area) {
        this.building_area = building_area;
    }

    public String getHouse_type() {
        return house_type;
    }

    public void setHouse_type(String house_type) {
        this.house_type = house_type;
    }

    public String getBuilding_type() {
        return building_type;
    }

    public void setBuilding_type(String building_type) {
        this.building_type = building_type;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Double getAvg_price() {
        return avg_price;
    }

    public void setAvg_price(Double avg_price) {
        this.avg_price = avg_price;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public Date getOpen_date() {
        return open_date;
    }

    public void setOpen_date(Date open_date) {
        this.open_date = open_date;
    }

    public int getTotal_rooms() {
        return total_rooms;
    }

    public void setTotal_rooms(int total_rooms) {
        this.total_rooms = total_rooms;
    }

    public String getReception_address() {
        return reception_address;
    }

    public void setReception_address(String reception_address) {
        this.reception_address = reception_address;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public Double getGreen_ratio() {
        return green_ratio;
    }

    public void setGreen_ratio(Double green_ratio) {
        this.green_ratio = green_ratio;
    }

    public Double getPlot_ratio() {
        return plot_ratio;
    }

    public void setPlot_ratio(Double plot_ratio) {
        this.plot_ratio = plot_ratio;
    }

    public String getProperty_company() {
        return property_company;
    }

    public void setProperty_company(String property_company) {
        this.property_company = property_company;
    }

    public double getProperty_fee() {
        return property_fee;
    }

    public void setProperty_fee(double property_fee) {
        this.property_fee = property_fee;
    }

    public int getCar_station() {
        return car_station;
    }

    public void setCar_station(int car_station) {
        this.car_station = car_station;
    }

    public String getTraffic() {
        return traffic;
    }

    public void setTraffic(String traffic) {
        this.traffic = traffic;
    }

    public String getEquipments() {
        return equipments;
    }

    public void setEquipments(String equipments) {
        this.equipments = equipments;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getIntro() {
        return intro;
    }

    public void setIntro(String intro) {
        this.intro = intro;
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
        return "Buildings{" +
                ", id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", area='" + area + '\'' +
                ", address='" + address + '\'' +
                ", floor_area=" + floor_area +
                ", building_area=" + building_area +
                ", house_type='" + house_type + '\'' +
                ", building_type='" + building_type + '\'' +
                ", longitude=" + longitude +
                ", latitude=" + latitude +
                ", avg_price=" + avg_price +
                ", company='" + company + '\'' +
                ", open_date=" + open_date +
                ", total_rooms=" + total_rooms +
                ", reception_address='" + reception_address + '\'' +
                ", tel='" + tel + '\'' +
                ", green_ratio=" + green_ratio +
                ", plot_ratio=" + plot_ratio +
                ", property_company='" + property_company + '\'' +
                ", property_fee=" + property_fee +
                ", car_station=" + car_station +
                ", traffic='" + traffic + '\'' +
                ", equipments='" + equipments + '\'' +
                ", logo='" + logo + '\'' +
                ", intro='" + intro + '\'' +
                ", created_time=" + created_time +
                ", status='" + status + '\'' +
                '}';
    }
}
