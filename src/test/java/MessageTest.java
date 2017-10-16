import com.ht.bean.Building;
import com.ht.bean.Message;
import com.ht.common.Pager;
import com.ht.price.BuildingsPrice;
import com.ht.price.UserPrice;
import com.ht.service.MessageService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")
public class MessageTest {

    @Resource
    private MessageService messageService;

    @Test
    @Transactional
    public void testqueryById(){
        Message  message= messageService.queryById("402880345e54cbff015e54cc041c0000");
        System.out.println(message.getUserPrice().getName()+"对"+message.getBuildingsPrice().getName()+"楼盘进行了留言，" +
                "并且发送了一句"+message.getContent()+"状态"+message.getStatus());
    }


    @Test
    public void testadd(){
        for (int i=0;i<1;i++) {
            Message message = new Message();
            BuildingsPrice buildingsPrice = new BuildingsPrice();
            buildingsPrice.setId("402880355e59ad56015e59ad5a820000");
            UserPrice userPrice = new UserPrice();
            userPrice.setId("402880355e64ac65015e64ad09550000");
            message.setContent("纳尼");
            message.setLeave_time(new Date());
            message.setStatus(0);
            message.setUserPrice(userPrice);
            message.setBuildingsPrice(buildingsPrice);
            //message.setUserPrice(userPrice);
            messageService.add(message);
        }
    }

    @Test//分页查询某个楼盘下被冻结或激活的留言有多少个
    @Transactional
    public void  testqueryAllMessageBuildings(){
        Pager<Message> messagePager = new Pager<>();
        messagePager.setPageNo(1);
        messagePager.setPageSize(10);
        String status = "1";//如果状态是空就代表查询所有状态
        try {
            int i = Integer.valueOf(status);
        }catch (Exception e){
            status = "";//如果转换异常就直接变成空
        }
        messagePager = messageService.queryAllMessageBuildings(messagePager,"4028805c5ea470a0015ea470b1ba0004",0);
        for (Message message:messagePager.getResult()){
            System.out.println(message.getUserPrice().getName()+"对"+message.getBuildingsPrice().getName()+"楼盘进行了留言，" +
                    "并且发送了一句"+message.getContent()+"状态"+message.getStatus());
        }
    }


    @Test//分页查询经销商下的所有楼盘下被冻结或激活的留言有多少个
    @Transactional
    public void testqueryAllMessageAgency(){
        Pager<Message> messagePager = new Pager<>();
        messagePager.setPageNo(1);
        messagePager.setPageSize(10);
        String status = "";//如果状态是空就代表查询所有状态
        try {
            int i = Integer.valueOf(status);
        }catch (Exception e){
            status = "";//如果转换异常就直接变成空
        }
        messagePager = messageService.queryAllMessageAgency(messagePager,"297eaf225e3b0b1c015e3b0b21870000",0);
        for (Message message:messagePager.getResult()){
            System.out.println(message.getUserPrice().getName()+"对"+message.getBuildingsPrice().getName()+"楼盘进行了留言，" +
                    "并且发送了一句"+message.getContent()+"状态"+message.getStatus());
        }
    }

    @Test//用户修改留言信息
    public void testupdateupdateMessageUser(){
        Message message = new Message();
        message.setId("402880345e54cbff015e54cc041c0000");
        message.setContent("草拟大爷");
        message.setLeave_time(new Date(new Date().getTime()+10000000));
        messageService.updateupdateMessageUser(message);
    }

    @Test//楼盘回复留言内容
    public void updateupdateMessageBuildings(){
        Message message = new Message();
        message.setId("402880345e54cbff015e54cc041c0000");
        message.setReply("丢你老母");
        message.setReply_time(new Date(new Date().getTime()+20000000));
        messageService.updateupdateMessageBuildings(message);
    }

    @Test
    public void testAll() {
        Message message = new Message();
        Pager<Message> messagePager = new Pager<>();
        messagePager.setPageNo(1);
        messagePager.setPageSize(10);
    }
}
