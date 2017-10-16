import com.ht.bean.Agency;
import com.ht.bean.Role;
import com.ht.common.Pager;
import com.ht.service.AgencyService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")
public class AgencyTest implements BaseTest {

    @Resource
    private AgencyService agencySerivce;


    @Test
    public void testqueryById() {//查询经销商的信息
        Agency agency = agencySerivce.queryById("402880345e27e1b7015e27e1bb870000");
        System.out.println(agency);
    }

    @Test
    public void testadd() {//添加经销商的方法

            Agency agency = new Agency();
            agency.setAddress("北京");
            agency.setName("经销商");
            agency.setPwd("4QrcOUm6Wau+VuBX8g+IPg==");
            agency.setEmail("2000"+"@qq.com");
            agency.setLeader("老王");
            agency.setPhone("138022664");
            agency.setTel("0755814773");
            agency.setCreated_time(new Date());
            agency.setChecked_status(0);
            agency.setStatus(1);
            Role role = new Role();
            role.setId("d715a8c987f411e7a5142c56dc7febbc");
            agency.setRole(role);
            agencySerivce.add(agency);
        }


    @Test
    public void testqueryAllChecked(){//分页查询未审核的经销商或者已审核的经销商
        Pager<Agency> agencyPager = new Pager<>();
        agencyPager.setPageNo(1);
        agencyPager.setPageSize(10);
        agencyPager = agencySerivce .queryAllChecked(agencyPager,1);
        String[] id = new String[20];
        int i =0;
        for (Agency agency :agencyPager.getResult()){
            System.out.println(agency);
            id[i] = agency.getId();
            i++;
        }
        agencySerivce.updateChecked(id,0);
        agencySerivce.updateStatus(id,0);
    }

    @Test
    public void testupdateStatus(){//冻结或激活经销商
//        agencySerivce.updateStatus("402880345e27e1b7015e27e1bb870000",0);
    }

    @Test
    public void testupdateChecked(){//批量审核未审核的经销商
        testqueryAllChecked();
//        agencySerivce.updateChecked("402880345e27e1b7015e27e1bb870000",1);
    }

    @Test
    public void testupdateAgency(){//修改经销商的信息
        Agency agency = new Agency();
        agency.setAddress("北京");
        agency.setName("经销商100");
        agency.setLeader("老王");
        agency.setTel("075581470016");
        agency.setLogo("aaa/bbb");
        agency.setIntro("花园天堂");
        agency.setId("402880345e27e1b7015e27e1bb870000");
        agencySerivce.updateAgency(agency);
    }

    @Test
    public void testAll() {
        Pager<Agency> agencyPager = new Pager<>();
        agencyPager.setPageNo(1);
        agencyPager.setPageSize(10);
        agencyPager = agencySerivce .queryAllRight(agencyPager,1,1);
        System.out.println(agencySerivce.countAll(1,1));
        for (Agency agency :agencyPager.getResult()){
            System.out.println(agency);
        }
    }

}
