import com.ht.bean.Like;
import com.ht.common.Pager;
import com.ht.price.BuildingsPrice;
import com.ht.price.UserPrice;
import com.ht.service.LikeService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by CHEN JX on 2017/9/1.
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")
public class LikeTest {

    @Resource
    private LikeService likeService;

    @Test
    public void likeAdd(){
        for (int i=0;i<2;i++) {
            Like like = new Like();
            UserPrice userPrice = new UserPrice();
            userPrice.setId("4028805c5e74f706015e74f717270000");
            BuildingsPrice buildingsPrice = new BuildingsPrice();
            buildingsPrice.setId("4028805c5e74f841015e74f8501b0000");
            like.setCreated_time(new Date());
            like.setUserPrice(userPrice);
            like.setBuildingsPrice(buildingsPrice);
            likeService.add(like);
        }
    }

    @Test
    public void testqueryById(){
        Like like = likeService.queryById("4028805c5e4aa01b015e4aa0b1471000");
        System.out.println(like.getBuildingsPrice().getName()+";"+like.getUserPrice().getName());
    }

    @Test//分页查询某个用户下的点赞记录
    @Transactional
    public void testqueryAllLike(){
        Pager<Like> agencyPager = new Pager<>();
        agencyPager.setPageNo(1);
        agencyPager.setPageSize(3);
        System.out.println(123);
        agencyPager = likeService.queryAllLike(agencyPager,"4028805c5e4aa01b015e4aa0b1470000");
        System.out.println(456);
        for (Like like:agencyPager.getResult()){
            System.out.println(agencyPager.getResult());
            System.out.println("用户于"+like.getCreated_time()+"点赞"
            +like.getBuildingsPrice().getName()+"楼盘");
            System.out.println(789);
        }

    }
}
