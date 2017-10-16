package com.ht.service.impl;

import com.ht.bean.Room;
import com.ht.common.Pager;
import com.ht.dao.RoomDAO;
import com.ht.service.RoomService;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * Created by CHEN JX on 2017/8/24.
 * 房号
 */
@Transactional
public class RoomServiceImpl implements RoomService {

    private RoomDAO roomDAO;

    public void setRoomDAO(RoomDAO roomDAO) {
        this.roomDAO = roomDAO;
    }

    @Override
    public Room queryById(String s) {
        return roomDAO.queryById(s);
    }

    @Override
    public void add(Room room) {
        roomDAO.add(room);
    }

    @Override
    public void remove(Room room) {
        roomDAO.remove(room);
    }

    @Override
    public void update(Room room) {
        roomDAO.update(room);
    }

    @Override
    public Pager<Room> queryPager(Pager<Room> pager) {
        return roomDAO.queryPager(pager);
    }

    @Override
    public List<Room> queryAll() {
        return roomDAO.queryAll();
    }

    @Override
    public int count() {
        return 0;
    }

    @Override
    public Pager<Room> queryPagers(Pager<Room> pager, String building_id) {
        return roomDAO.queryPagers(pager,building_id);
    }

    @Override
    public Pager<Room> queryRoomPagers(Pager<Room> pager, String id) {
        return roomDAO.queryRoomPagers(pager,id);
    }

    @Override
    public long countRoom(String building_id) {
        return roomDAO.countRoom(building_id);
    }

    @Override
    public List<String> queryHouseId(String building_id) {
        return roomDAO.queryHouseId(building_id);
    }

    @Override
    public void deleteBuilding(String building_id) {
        roomDAO.deleteBuilding(building_id);
    }

    @Override
    public Pager<Room> AllAgencyRoom(Pager<Room> pager, String agency_id, int sale_status) {
        pager.setTotal(roomDAO.countAgencyRoom(agency_id,sale_status));
        return roomDAO.AllAgencyRoom(pager,agency_id,sale_status);
    }

    @Override
    public long countAgencyRoom(String agency_id, int sale_status) {
        return roomDAO.countAgencyRoom(agency_id,sale_status);
    }

    @Override
    public Pager<Room> AllBuildingsRoom(Pager<Room> pager, String buildings_id, int sale_status) {
        pager.setTotal(roomDAO.countBuildingsRoom(buildings_id,sale_status));
        return roomDAO.AllBuildingsRoom(pager,buildings_id,sale_status);
    }

    @Override
    public long countBuildingsRoom(String buildings_id, int sale_status) {
        return roomDAO.countBuildingsRoom(buildings_id,sale_status);
    }

    @Override
    public Pager<Room> AllBuildingRoom(Pager<Room> pager, String building_id, int sale_status) {
        pager.setTotal(roomDAO.countBuildingRoom(building_id,sale_status));
        return roomDAO.AllBuildingRoom(pager,building_id,sale_status);
    }

    @Override
    public long countBuildingRoom(String building_id, int sale_status) {
        return roomDAO.countBuildingRoom(building_id,sale_status);
    }

    @Override
    public void updateSaleStatus(String[] id, int sale_status) {
        roomDAO.updateSaleStatus(id,sale_status);
    }
}
