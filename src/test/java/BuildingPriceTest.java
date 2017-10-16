import com.ht.bean.BuildingsImg;
import com.ht.common.Pager;
import com.ht.price.BuildingPrice;
import com.ht.service.BuildingPriceService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")
public class BuildingPriceTest {

    @Resource
    private BuildingPriceService buildingPriceService;

    @Test
    @Transactional//查询所有某个楼盘的所有楼栋信息，主要用于下拉框值，的测试方法
    public void  testqueryAllBuildingPrice(){
        List<BuildingPrice> buildingPrices = new ArrayList<>();

        buildingPrices = buildingPriceService.queryAllBuildingPrice("402880355e59ad56015e59ad5a820000");

        for (BuildingPrice buildingPrice :buildingPrices){
            System.out.println(buildingPrice);
        }
    }
}
