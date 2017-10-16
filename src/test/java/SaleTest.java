import com.ht.bean.Room;
import com.ht.bean.Sale;
import com.ht.price.BuildingPrice;
import com.ht.service.RoomService;
import com.ht.service.SaleService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import javax.transaction.Transactional;

/**
 * Created by ID.LQF on 2017/9/3.
 * 销售记录测试类
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")
public class SaleTest {

    @Resource
//    private SaleService saleService;
    private RoomService roomService;

    @Test
    @Transactional
    public void room(){
        Room room = roomService.queryById("402880595e27d5c0015e27d627690103");
        System.out.println(room);
        System.out.println(room.getBuilding().getName());
    }

}
