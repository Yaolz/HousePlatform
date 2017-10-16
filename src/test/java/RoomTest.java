import com.ht.bean.Room;
import com.ht.common.Pager;
import com.ht.service.RoomService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by yao on 2017/9/20.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")
public class RoomTest {
    @Resource
    private RoomService roomService;

    @Test
    public void testRoom(){
        Pager<Room> pager=new Pager<Room>();
        pager.setPageNo(1);
        pager.setPageSize(6);
        pager=roomService.queryPagers(pager,"402880f85e9c9b75015e9cd6ba000000");
        for(Room r:pager.getResult()){
            System.out.println(r);
        }
    }

    @Test
    public void testqueryByHouse(){
        List<String> list = roomService.queryHouseId("402880355e59b1a4015e59b1a8e40000");
        for (String str:list){
            System.out.println(str);
        }
    }

}
