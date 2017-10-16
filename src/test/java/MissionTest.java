import com.ht.bean.Agency;
import com.ht.bean.Employee;
import com.ht.bean.Mission;
import com.ht.common.ControllerResult;
import com.ht.common.EncriptUtil;
import com.ht.common.Pager;
import com.ht.dao.MissionDAO;
import com.ht.price.EmployeePrice;
import com.ht.price.MissionBean;
import com.ht.service.MissionService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import javax.naming.ldap.Control;
import java.math.BigInteger;
import java.util.Date;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")
public class MissionTest {

    @Resource
    private MissionService missionService;

    @Resource
    private MissionDAO missionDAO;

    @Test//添加绩效表的信息
    public void testadd(){
        for (int i=0;i<1;i++){
            Mission mission = new Mission();

            mission.setStart_time(new Date());
            mission.setEnd_time(new Date(new Date().getTime()+86400000));
            mission.setQuantity(65+i);
            mission.setStatus(1);
            mission.setBonus_percent(10.0);
            EmployeePrice employeePrice = new EmployeePrice();
            employeePrice.setId("402880355e59bca2015e59bca6a10000");
            mission.setEmployeePrice(employeePrice);
            missionService.add(mission);
            System.out.println(mission);
        }

    }

    @Test
    @Transactional
    public void queryById(){
//        Mission mission = missionService.queryById("402880355e59b4d4015e59b4d9260000");
//        System.out.println(mission.getEmployeePrice().getAgencyPrice().getName());
        Object object =missionDAO.countSale("402880355e59b4d4015e59b4d9260000");//查询每个员工绩效表内的任务完成量
        if(object!=null){
//                ((BigInteger) object).longValue()
            System.out.println(((BigInteger) object).longValue());
        }
    }

    @Test//查询员工最新的绩效表
    public void  testqueryByIdeMax(){
        MissionBean mission = missionService.queryByMissionMaxEnd("402880355e59b2b0015e59b2b4e00000");
        System.out.println(mission);
    }

    @Test//分页查询经销商的所有绩效表
    @Transactional
    public void testqueryAllMissionBeanAgency(){
        Pager<MissionBean> missionBeanPager = new Pager<>();
        missionBeanPager.setPageNo(1);
        missionBeanPager.setPageSize(10);
        missionBeanPager = missionService.queryAllMissionBeanAgency(missionBeanPager,"402880355e59ac4d015e59ac51560000",3);
        for (MissionBean missionBean :missionBeanPager.getResult()){
            System.out.println(missionBean);
        }

    }

    @Test//分页查询一个员工的所有绩效
    @Transactional
    public void testqueryAllMissionBeanEmployee(){
        Pager<MissionBean> missionBeanPager = new Pager<>();
        missionBeanPager.setPageNo(1);
        missionBeanPager.setPageSize(10);
        missionBeanPager = missionService.queryAllMissionBeanEmployee(missionBeanPager,"402880355e59bca2015e59bca6a10000",3);
        for (MissionBean missionBean :missionBeanPager.getResult()){
            System.out.println(missionBean);
        }
    }

    @Test
    public void queryPager(){
        Pager<Mission> pager = new Pager<>();
        pager.setPageSize(5);
        pager.setPageNo(1);
        pager.setTotal(2);
        pager.setTotalPageSize(1);
        pager = missionService.queryPager(pager,"402880595e28b110015e28b29ba10000");
        System.out.println(pager.getResult());
        System.out.println(EncriptUtil.md5("111111"));
    }
}
