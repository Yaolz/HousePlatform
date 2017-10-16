import com.ht.bean.House;
import com.ht.common.Pager;
import com.ht.price.BuildingsPrice;
import com.ht.service.HouseService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")
public class HouseTest {

    @Resource
    private HouseService houseService;

    private  static String[] id = new String[20];

    @Test//添加户型的测试方法
    public void  testadd(){
        for (int i=0;i<20;i++){
            House house = new House();
            house.setArea(100.5);
            house.setName("A"+i);
            house.setLogo("uploads/蕾姆0.jpg");
            house.setIntro("三室两厅");
            house.setUnit_price(10000.0);
            house.setCreated_time(new Date());
            BuildingsPrice buildingsPrice = new BuildingsPrice();
            buildingsPrice.setId("4028805a5e4baf0b015e4baf1e9b0000");
            house.setBuildingsPrice(buildingsPrice);
            house.setStatus(1);
            houseService.add(house);
        }
    }
    @Test//修改户型的方法
    public void testupdateHouse(){
        House house = new House();
        house.setArea(100.5);
        house.setName("C");
        house.setLogo("户型图片");
        house.setIntro("三室一厅");
        house.setUnit_price(100.0);
        house.setId("297eaf225e3b0cf6015e3b0cfb620000");
        houseService.updateHouse(house);
    }

    @Test//分页查询所有某个楼盘的户型的测试方法
    @Transactional
    public void  testqueryAllHouse(){
        Pager<House> pager = new Pager<>();
        pager.setPageNo(1);
        pager.setPageSize(10);
        pager = houseService.queryAllHouse(pager,"297eaf225e3b0c12015e3b0c175d0000");
        for (House house:pager.getResult()){
            System.out.println(house+"所属楼盘是："+house.getBuildingsPrice().getName()+"\t所属经销商是"+house.getBuildingsPrice().getAgencyPrice().getName());
        }
    }

    @Test//分页查询某个楼盘的被冻结或被激活的户型
    public void testqueryAllHouseStatus(){
        Pager<House> pager = new Pager<>();
        pager.setPageNo(1);
        pager.setPageSize(10);
        pager = houseService.queryAllHouseStatus(pager,"297eaf225e3b0c12015e3b0c175d0000",1);
        for (House house:pager.getResult()){
            System.out.println(house+"所属楼盘是："+house.getBuildingsPrice().getName()+"\t所属经销商是"+house.getBuildingsPrice().getAgencyPrice().getName());
        }
    }

    @Test//批量冻结或激活的测试方法
    public void testupdateStatus(){
        Pager<House> pager = new Pager<>();
        pager.setPageNo(1);
        pager.setPageSize(10);
        pager = houseService.queryAllHouseStatus(pager,"297eaf225e3b0c12015e3b0c175d0000",1);
        int i =0;
        for (House house:pager.getResult()){
            id[i] = house.getId();
            if(i<20){
                i++;
            }
        }
        houseService.updateStatus(id,0);
    }

}
