import com.ht.bean.Admin;
import com.ht.bean.Role;
import com.ht.bean.Role_permission;
import com.ht.service.AdminService;
import com.ht.service.impl.AdminServiceImpl;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")
//@Transactional
public class AdminTest {
    @Resource
    private AdminService adminService;

    @Test
    @Transactional
    public void testqueryById(){
        Admin admin = adminService.queryByEmailPwd("shoulouwang@qq.com");
        System.out.println(admin+"我的角色是:"+admin.getRole().getName());
        for (Role_permission role_permission : admin.getRole().getRole_permissions()){
            System.out.println(role_permission);
        }
    }

    @Test
    public void testadd(){
        Admin admin = new Admin();
        admin.setEmail("30008@qq.com");
        admin.setPwd("4QrcOUm6Wau+VuBX8g+IPg==");
        admin.setName("售楼网管理员");
        admin.setPhone("18180240299");
        Role role = new Role();
        role.setId("d702b59b87f411e7a5142c56dc7febbc");
//        admin.setRole(role);
        adminService.add(admin);
    }

    @Test
    public void testUpdate() {
        Admin admin = new Admin();
        admin.setName("2333333");
        admin.setEmail("123@qq.com");
        admin.setPhone("1234123123");
        admin.setId("131281237819731298ajkf112387");
        adminService.update(admin);
        System.out.println(adminService.queryById("131281237819731298ajkf112387"));
    }

}
