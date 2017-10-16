import com.ht.bean.Activity;
import com.ht.bean.Admin;
import com.ht.bean.Article;
import com.ht.bean.ArticleType;
import com.ht.common.Pager;
import com.ht.price.AgencyPrice;
import com.ht.price.BuildingsPrice;
import com.ht.service.ActivityService;
import com.ht.service.ArticleService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;

/**
 * Created by yao on 2017/8/30.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")
public class ActivityTest {
    @Resource
    private ActivityService activityService;

    @Test
    public void testadd(){
        Activity activity = new Activity();
        BuildingsPrice buildingsPrice = new BuildingsPrice();
        buildingsPrice.setId("4028805c5ea470a0015ea470b1ba0004");
        AgencyPrice agencyPrice = new AgencyPrice();
        agencyPrice.setId("4028805c5ea46e71015ea46e7fcc0000");
        activity.setAgencyPrice(agencyPrice);
        activity.setLogo("public/img/6.jpg");
        activity.setBuildingsPrice(buildingsPrice);
        activity.setTitle("大特价");
        activityService.add(activity);
    }

    @Test
    @Transactional
    public void  testQueryById(){
        Activity activity = new Activity();
        activity = activityService.queryByBuildingsId("4028805a5e4baf0b015e4baf1e9b0000");
        System.out.println(activity);
    }

    @Test//分页查询活动
    public void testQueryId() {
        Pager<Activity> pager=new Pager<>();
        pager.setPageNo(1);
        pager.setPageSize(5);
        pager = activityService.queryPagerByStatus(pager,"402880f85e73ccaa015e73ccbc1d0000",1);
        for(Activity activity : pager.getResult()) {
            System.out.println(activity);
        }
    }


}
