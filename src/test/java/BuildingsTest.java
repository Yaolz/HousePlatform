import com.ht.bean.Agency;
import com.ht.bean.Buildings;
import com.ht.common.Content;
import com.ht.common.Pager;
import com.ht.price.AgencyPrice;
import com.ht.service.BuildingsService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")
public class BuildingsTest {

    @Resource
    private BuildingsService buildingsService;

    @Test
    public void testadd(){//添加楼盘的测试方法
        for (int i =0;i<20;i++){
            Buildings buildings = new Buildings();
            buildings.setName("地下城"+i);
            buildings.setArea("章贡区"+i);
            buildings.setAddress("江西省");
            buildings.setFloor_area(1000000.0);
            buildings.setBuilding_area(100000000.0);
            buildings.setHouse_type("地下楼");
            buildings.setBuilding_type("高层");
            buildings.setLongitude(100.5);
            buildings.setLatitude(20.5);
            buildings.setAvg_price(13000.5);
            buildings.setCompany("蓝翔建筑公司");
            buildings.setOpen_date(new Date());
            buildings.setTotal_rooms(1005);
            buildings.setReception_address("赣州章贡区58号大道");
            buildings.setTel("0797884374"+i);
            buildings.setGreen_ratio(50.5);
            buildings.setPlot_ratio(30.5);
            buildings.setProperty_company("暂不公开");
            buildings.setProperty_fee(0);
            buildings.setCar_station(1000);
            buildings.setTraffic("流畅");
            buildings.setEquipments("无");
            buildings.setLogo("public/img/noimage.png");
            buildings.setIntro("黑色天堂");
            buildings.setCreated_time(new Date());
            Agency agency = new Agency();
            agency.setId("402880355e59ac4d015e59ac51560000");//添加时把关联的经销商id添加到经销商类里
            buildings.setAgency(agency);
            buildings.setStatus(1);
            buildingsService.add(buildings);
        }
    }

   
    @Test
    @Transactional
    public void  testqueryById(){//查询楼盘信息
      Buildings buildings = buildingsService.queryById("4028805c5e4aa01b015e4aa0b2470000");
      System.out.println(buildings.getAgency());//把楼盘所属经销商也查询出来
        System.out.println(buildings);
    }

    @Test
    public void testupdateBuildings(){//修改楼盘信息的测试类
        Buildings buildings = new Buildings();
        /*AgencyPrice agencyPrice = new AgencyPrice();
        agencyPrice.setId("4028805c5e742957015e742963070000");*/
        buildings.setId("402880345e28b872015e28b876da0000");
        buildings.setName("天空之城");
        buildings.setArea("章贡区1");
        buildings.setAddress("深圳");
        buildings.setFloor_area(1000000.0);
        buildings.setBuilding_area(100000000.0);
        buildings.setHouse_type("商业楼");
        buildings.setBuilding_type("超高层");
        buildings.setLongitude(100.5);
        buildings.setLatitude(2000.5);
        buildings.setAvg_price(13000.5);
        buildings.setCompany("深圳建筑公司");
        buildings.setOpen_date(new Date());
        buildings.setTotal_rooms(1005);
        buildings.setReception_address("深圳章贡区58号大道");
        buildings.setTel("07978843741");
        buildings.setGreen_ratio(50.5);
        buildings.setPlot_ratio(30.5);
        buildings.setProperty_company("暂不公开");
        buildings.setProperty_fee(0);
        buildings.setCar_station(1000);
        buildings.setTraffic("流畅");
        buildings.setEquipments("无");
        buildings.setIntro("绿色天堂");
        buildingsService.updateBuildings(buildings);
    }

    @Test
    public void testupdateStatus(){//冻结或激活楼盘的测试方法
        Buildings buildings = new Buildings();
        buildings.setId("402880345e28b872015e28b876da0000");
        buildings.setStatus(1);
//        buildingsService.updateStatus(buildings.getId(),buildings.getStatus());
    }

    @Test//分页查询某个经销商下的楼盘
    public void testqueryAllBuildings(){
        Pager<Buildings> agencyPager = new Pager<>();
        agencyPager.setPageNo(1);
        agencyPager.setPageSize(10);
        agencyPager =  buildingsService.queryAllBuildings(agencyPager,"4028805a5e27f627015e27f638650001",0);
        for (Buildings buildings :agencyPager.getResult()){
            System.out.println(buildings);
            System.out.println(buildings.getAgency());
        }
    }

    @Test
    @Transactional
    public void testAll() {
        Pager<Buildings> pager = new Pager<>();
        pager.setPageNo(1);
        pager.setPageSize(6);
        pager = buildingsService.queryStatusAll(pager, Content.StatusYes,"DNF");
        for(Buildings buildings : pager.getResult()) {
            System.out.println(buildings);
        }
    }

    @Test
    public void testRemove() {
        Buildings buildings = new Buildings();
        buildings.setId("5028885a5e27f627015e27f6372a1000");
        buildingsService.remove(buildings);
    }

    @Test
    @Transactional
    public void testqueryAllindex(){
        Pager<Buildings> pager = new Pager<>();
        pager.setPageNo(1);
        pager.setPageSize(10);
        pager = buildingsService.queryAllindex(pager,"赣州市",1,20000,"普通住宅","地下城");
        for(Buildings buildings : pager.getResult()) {
            System.out.println(buildings);
            System.out.println(pager.getTotal());
        }
    }

}
