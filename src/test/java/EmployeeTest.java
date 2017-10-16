import com.ht.bean.Agency;
import com.ht.bean.Employee;
import com.ht.bean.Role;
import com.ht.common.EncriptUtil;
import com.ht.common.Pager;
import com.ht.price.AgencyPrice;
import com.ht.price.BuildingsPrice;
import com.ht.service.EmployeeService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * Created by ID.LQF on 2017/8/28.
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")
public class EmployeeTest {

    @Resource
    private EmployeeService employeeService;

    @Test
    public void add() {
        for (int i = 0; i <10; i++) {
            Employee employee = new Employee();
            employee.setPhone("137640772");
            employee.setEmail("111@"+i+"qq.com");
            employee.setPwd(EncriptUtil.md5("123456"));
            employee.setName("老张");
            employee.setBasic_salary(1200.0);
            employee.setQq("9987654"+i);
            employee.setWechat("654321"+i);
            employee.setGender("女");
            employee.setExp("6");
            employee.setStatus(1);
            employee.setHeadicon("public/img/a"+i+".jpg");
            BuildingsPrice buildingsPrice = new BuildingsPrice();
            buildingsPrice.setId("4028805c5ea470a0015ea470b1ba0004");
            employee.setBuildingsPrice(buildingsPrice);
            Role role = new Role();
            role.setId("d7227c6487f411e7a5142c56dc7febbc");
            AgencyPrice agencyPrice = new AgencyPrice();
            agencyPrice.setId("4028805c5ea46e71015ea46e7fcc0000");
            employee.setAgencyPrice(agencyPrice);
            employee.setBuildingsPrice(buildingsPrice);
            employee.setRole(role);
            employeeService.add(employee);
        }
    }
    @Test
    @Transactional
    public void id(){
        Employee employee = new Employee();
        employee.setId("402880345e4a8d86015e4a8d8a1b0000");
        employeeService.queryById(employee.getBuildingsPrice().getName());
    }

    @Test
    public void login(){
        Employee employee = new Employee();
        employee.setEmail("123@qq.com");
        employeeService.queryByPwd(employee.getEmail());
    }

    @Test//修改员工信息
    public void testupdateEmployee(){
        Employee employee = new Employee();
        employee.setId("402880345e4a8d86015e4a8d8a1b0000");
        employee.setName("老王");
        employee.setPhone("15333333333");
        employee.setQq("12333");
        employee.setWechat("公众微信号");
        employee.setGender("男");
        employee.setExp("工作五年");
        employee.setDes("123");
        employee.setAddress("123");
        employee.setHeadicon("agsca/123.jpg");
        employee.setIntro("在百度工作过五年");
        employeeService.updateEmployee(employee);
    }

    @Test//分页查询某个楼盘下工作的员工
    @Transactional
    public void testqueryAllEmployee(){
        Pager<Employee> employeePager = new Pager<>();
        employeePager.setPageNo(1);
        employeePager.setPageSize(10);
        employeePager = employeeService.queryAllEmployee(employeePager,"297eaf225e3b0c12015e3b0c175d0000");
        for (Employee employee :employeePager.getResult()){
            //System.out.println(employee+"负责楼盘:"+employee.getBuildingsPrice().getName());
        }
    }

    @Test//分页查询某个楼盘下被冻结或激活的员工
    @Transactional
    public void testqueryAllEmployeeStatus(){
        Pager<Employee> employeePager = new Pager<>();
        employeePager.setPageNo(1);
        employeePager.setPageSize(10);
        employeePager = employeeService.queryAllEmployeeStatus(employeePager,"297eaf225e3b0c12015e3b0c175d0000",0);
        for (Employee employee :employeePager.getResult()){
           // System.out.println(employee+"负责楼盘:"+employee.getBuildingsPrice().getName());
        }
    }

    @Test//批量冻结或激活
    public void testupdateStatus(){
        Pager<Employee> employeePager = new Pager<>();
        employeePager.setPageNo(1);
        employeePager.setPageSize(10);
        String[] id= new String[20];
        int i =0;
        employeePager = employeeService.queryAllEmployeeStatus(employeePager,"297eaf225e3b0c12015e3b0c175d0000",0);
        for (Employee employee :employeePager.getResult()){
            //System.out.println(employee+"负责楼盘:"+employee.getBuildingsPrice().getName());
            if(i<20){
                i++;
            }
            id[i]=employee.getId();
        }
        employeeService.updateStatus(id,1);
    }

}
