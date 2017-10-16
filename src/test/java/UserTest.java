import com.ht.bean.Role;
import com.ht.bean.User;
import com.ht.common.EncriptUtil;
import com.ht.service.UserService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")

public class UserTest {

    @Resource
    private UserService userService;

    @Test
    @Transactional
    public void  testqueryByEmail(){
        User user = userService.queryEmailPwd("123@qq.com");
        System.out.println(user);
    }

    @Test
    public void testadd(){
        User user = new User();
        user.setPhone("13663077426");
        user.setEmail("333@qq.com");
        user.setPwd(EncriptUtil.md5("123456"));
        user.setQq( "302936105");
        user.setWechat("998865 ");
        user.setGender("��");
        user.setBirthday(new Date());
        user.setNickname("����");
        user.setHeadicon("SSS");
        Role role = new Role();
        role.setId("d737ab4487f411e7a5142c56dc7febbc");
        user.setRole(role);
        userService.add(user);
    }

    @Test
    public void updatePwd(){
        User user = new User();
        userService.updatePwd("123456","4028805c5e7f6f1e015e7f6f3dc00000");
        System.out.println(user);
    }
}
