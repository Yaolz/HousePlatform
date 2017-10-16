import com.ht.bean.Agency;
import com.ht.bean.Building;
import com.ht.bean.House;
import com.ht.bean.Room;
import com.ht.common.Pager;
import com.ht.price.BuildingPrice;
import com.ht.price.BuildingsPrice;
import com.ht.service.BuildingService;
import com.ht.service.RoomService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")
public class BuildingTest {

    @Resource
    private BuildingService buildingService;

    @Resource
    private RoomService roomService;

    @Test//添加楼栋的测试方法,并且和房间类绑定
    public void  testadd(){
        Building  building = new Building();
        building.setName("A栋");
        building.setTotal_floor(10);//层数
        building.setTotal_lift(2);
        building.setFloor_rooms(4);//每层多少户
        building.setTotal_room(50*4);
        BuildingsPrice buildingsPrice = new BuildingsPrice();
        buildingsPrice.setId("402880355e59ad56015e59ad5a820000");
        building.setBuildingsPrice(buildingsPrice);
        buildingService.add(building);
        String[] house = {"402880355e59ae46015e59ae4b110000","402880355e59ae46015e59ae4b800001",
                "402880355e59ae46015e59ae4b840002","402880355e59ae46015e59ae4b880003"};
        for (int i=1;i<=building.getTotal_floor();i++){
            for(int j=1;j<=building.getFloor_rooms();j++){
                Room room = new Room();
                room.setName((i*100+j));
                room.setSale_status("待售");
                House house1 = new House();
                house1.setId(house[j-1]);
                room.setHouse(house1);
                BuildingPrice buildingPrice = new BuildingPrice();
                buildingPrice.setId(building.getId());
                room.setBuilding(buildingPrice);
                roomService.add(room);
            }
        }
    }

    @Test//修改楼栋信息
    public void testupdateBuilding(){
        Building  building = new Building();
        building.setName("C栋");
        building.setId("297eaf225e3c1765015e3c1768cf0000");
        building.setTotal_floor(20);//层数
        building.setTotal_lift(12);
        building.setFloor_rooms(4);//每层多少户
        building.setTotal_room(20*4);
        buildingService.updateBuilding(building);
    }

    @Test//分页查询某个楼盘的楼栋
    @Transactional
    public void queryAllBuilding(){
        Pager<Building> buildingPager = new Pager<>();
        buildingPager.setPageNo(1);
        buildingPager.setPageSize(10);
        buildingPager = buildingService.queryAllBuilding(buildingPager,"297eaf225e3b0c12015e3b0c175d0000");
        for (Building building :buildingPager.getResult()){
            System.out.println(building+"所属楼盘"+building.getBuildingsPrice().getName());
        }
    }

    @Test//分页查询某个楼盘下被冻结或激活的楼栋
    @Transactional
    public void testqueryAllBuildingStatus(){
        Pager<Building> buildingPager = new Pager<>();
        buildingPager.setPageNo(1);
        buildingPager.setPageSize(10);
        buildingPager = buildingService.queryAllBuildingStatus(buildingPager,"297eaf225e3b0c12015e3b0c175d0000",0);
        for (Building building :buildingPager.getResult()){
            System.out.println(building+"所属楼盘"+building.getBuildingsPrice().getName());
        }
    }

    @Test//批量冻结或激活
    public void testupdateBuildingStatus(){
        Pager<Building> buildingPager = new Pager<>();
        buildingPager.setPageNo(1);
        buildingPager.setPageSize(10);
        String[] id = new String[20];
        int i =0;
        buildingPager = buildingService.queryAllBuildingStatus(buildingPager,"297eaf225e3b0c12015e3b0c175d0000",0);
        for (Building building :buildingPager.getResult()){
            System.out.println(building+"所属楼盘"+building.getBuildingsPrice().getName());
            id[i]=building.getId();
            if(i<20){
                i++;
            }
        }
        buildingService.updateBuildingStatus(id,1);
    }
}
