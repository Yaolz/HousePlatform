import com.ht.price.AgencyPrice;
import com.ht.service.AgencyPriceService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
/**
 * Created by CHEN JX on 2017/8/21.
 * 经销商的值对象
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")
public class AgencyPriceTest {

    @Resource
    private AgencyPriceService agencyPriceService;

    @Test
    public void testqueryById(){
        AgencyPrice agencyPrice = agencyPriceService.queryById("4028805c5e63fe58015e63fe64dd0000");
        System.out.println(agencyPrice);
    }
}
