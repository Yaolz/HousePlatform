import com.ht.bean.History;
import com.ht.bean.Like;
import com.ht.common.Pager;
import com.ht.price.BuildingsPrice;
import com.ht.price.UserPrice;
import com.ht.service.HistoryService;
import com.ht.service.impl.HistoryServiceImpl;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Calendar;

/**
 * Created by CHEN JX on 2017/9/8.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")
public class HistoryTest {

    @Resource
    private HistoryService historyService;

    @Test
    public void testqueryById(){
        History like = historyService.queryById("4028805c5e4aa01b015e4aa0b1470000");
        System.out.println(like.getBuildingsPrice().getName()+";"+like.getUserPrice().getName());
    }

    @Test
    public void historyAdd(){
        for(int i = 0;i < 20;i++) {
            History history = new History();
            UserPrice userPrice = new UserPrice();
            userPrice.setId("4028805c5e74f706015e74f717270000");
            BuildingsPrice buildingsPrice = new BuildingsPrice();
            buildingsPrice.setId("4028805c5e74f841015e74f8501b0000");
            history.setBuildingsPrice(buildingsPrice);
            history.setUserPrice(userPrice);
            history.setCreated_time(Calendar.getInstance().getTime());
            historyService.add(history);
        }
    }

    @Test
    public void querHistory() {
        Pager<History> agencyPager = new Pager<>();
        agencyPager.setPageNo(1);
        agencyPager.setPageSize(3);
        System.out.println(123);
        agencyPager = historyService.queryAllHistory(agencyPager, "4028805c5e4aa01b015e4aa0b1470000");
        System.out.println(456);
        for (History like : agencyPager.getResult()) {
            System.out.println(agencyPager.getResult());
            System.out.println("用户于" + like.getCreated_time() + "查看"
                    + like.getBuildingsPrice().getName() + "的历史纪录");
            System.out.println(789);
        }

    }
    @Test
    public void deleteHistroy(){
        History history = new History();
        history.setId("4028805c5e4aa01b015e4aa0b1470000");
        historyService.remove(history);
    }

}
