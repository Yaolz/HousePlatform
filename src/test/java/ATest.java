import com.ht.bean.Ads;
import com.ht.dao.AdsDAO;
import com.ht.dao.impl.AdsDAOImpl;
import com.ht.service.AdsService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * Created by yao on 2017/8/26.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")
public class ATest {

    @Resource
    private AdsService adsService;

    @Test
    public void testAdmin() {
        String str = "123@qq.com";
        if (str.indexOf(".com") != -1) {
            System.out.println("是邮箱!");
        } else {
            System.out.println("不是邮箱!");
        }
    }

    @Test
    public void testAddAds() {
        for (int i = 1; i < 30; i++) {
            Ads ads = new Ads();
            if(i <= 9 &&i > 1) {
                ads.setShow_status(1);
                ads.setStatus(1);
                ads.setTitle("云广告" + i);
                ads.setLogo("images/ads.webp");
                ads.setContent("云广告，你值得拥有！");
                ads.setAd_url("http://www.baidu.com");
                ads.setShow_order(i);
                ads.setCreated_time(new Date());
                adsService.add(ads);
            } else if (i == 10) {
                ads.setShow_status(1);
                ads.setStatus(1);
                ads.setTitle("云广告" + i);
                ads.setLogo("images/imgad.jpg");
                ads.setContent("云广告，你值得拥有！");
                ads.setAd_url("http://www.baidu.com");
                ads.setShow_order(i);
                ads.setCreated_time(new Date());
                adsService.add(ads);
            } else if(i <= 13 && i >= 11) {
                ads.setShow_status(1);
                ads.setStatus(1);
                ads.setTitle("云广告" + i);
                ads.setLogo("images/ads.webp");
                ads.setContent("云广告，你值得拥有！");
                ads.setAd_url("http://www.baidu.com");
                ads.setShow_order(i);
                ads.setCreated_time(new Date());
                adsService.add(ads);
            } else if(i <= 14 && i >= 17) {
                ads.setShow_status(1);
                ads.setStatus(1);
                ads.setTitle("云广告" + i);
                ads.setLogo("images/ads.gif");
                ads.setContent("云广告，你值得拥有！");
                ads.setAd_url("http://www.baidu.com");
                ads.setShow_order(i);
                ads.setCreated_time(new Date());
                adsService.add(ads);
            } else if(i >= 18) {
                ads.setShow_status(1);
                ads.setStatus(1);
                ads.setTitle("云广告" + i);
                ads.setLogo("public/admin/buildings1.jpg");
                ads.setContent("云广告，你值得拥有！");
                ads.setAd_url("http://www.baidu.com");
                ads.setShow_order(i);
                ads.setCreated_time(new Date());
                adsService.add(ads);
            }
        }
    }

    @Test
    public void testAdsShow() {
        List<Ads> adsList = adsService.queryShow(1, 5);
        for (Ads a : adsList) {
            System.out.println(a);
        }
    }
}
