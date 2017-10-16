package com.ht.dao;

import com.ht.bean.Room;
import com.ht.common.Pager;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/24.
 * 房号
 */
public interface RoomDAO extends BaseDAO<String,Room> {

     Pager<Room> queryPagers(Pager<Room> pager,String building_id);

     Pager<Room> queryRoomPagers(Pager<Room> pager,String id);//分页查所有房间

     long countRoom(String building_id);

     List<String> queryHouseId(String building_id);//查询某个楼栋用的户型有哪些

     void deleteBuilding(String building_id);//删除某个楼栋下的房间

     Pager<Room> AllAgencyRoom(Pager<Room> pager,String agency_id,int sale_status);//分页查询经销商下的所有房间

     long countAgencyRoom(String agency_id,int sale_status);//查询经销商下的房间有多少个

     Pager<Room> AllBuildingsRoom(Pager<Room> pager,String buildings_id,int sale_status);//分页查询某个楼盘下的房间有多少

     long countBuildingsRoom(String buildings_id,int sale_status);//查询楼盘下的房间有多少个

     Pager<Room> AllBuildingRoom(Pager<Room> pager,String building_id,int sale_status);//分页查询楼栋下的房间有多少个

     long countBuildingRoom(String building_id,int sale_status);//查询楼栋下的房间有多少个

     void updateSaleStatus(String[] id,int sale_status);//批量修改房屋状态
}
