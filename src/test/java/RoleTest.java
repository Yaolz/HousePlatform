import com.ht.bean.Admin;
import com.ht.bean.Role;
import com.ht.bean.User;
import com.ht.service.RoleService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")
@Transactional
public class RoleTest {

    @Resource
    private RoleService roleService;

    @Test
    public void testqueryByIdAdmin(){//一个角色可以被多个管理员添加，查询指定角色时会把添加了此角色的管理员查询出来
        Role role = this.roleService.queryById("d702b59b87f411e7a5142c56dc7febbc");
        System.out.println(role);
        for (Admin admin : role.getAdminSet()){
            System.out.println(admin);
        }
    }

    @Test
    public void testqueryByIdUser(){//一个角色可以被多个管理员添加，查询指定角色时会把添加了此角色的管理员查询出来
        Role role = this.roleService.queryById("d737ab4487f411e7a5142c56dc7febbc");
        System.out.println(role);
        for (User user : role.getUserSet()){
            System.out.println(user);
        }
    }
}
