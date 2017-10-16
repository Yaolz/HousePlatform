import com.ht.bean.Customer;
import com.ht.common.Pager;
import com.ht.price.AgencyPrice;
import com.ht.price.EmployeePrice;
import com.ht.service.CustomerService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Calendar;
import java.util.Date;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")
public class CustomerTest {
    @Resource
    private CustomerService customerService;

    @Test
    public void testadd(){
        for(int i = 0;i<10;i++){
            Customer customer = new Customer();
            customer.setName("老王");
            customer.setGender("男");
            customer.setBirthday(Calendar.getInstance().getTime());
            customer.setIdentity_id("3607221996102700"+i);
            customer.setEmail("123456"+i+"@qq.com");
            customer.setPhone("138022664"+i);
            customer.setAddress("北海道");
            customer.setCustomer_type("预约客户");
            customer.setTogether("老王，老李");
            customer.setCreated_time(new Date());
            EmployeePrice employeePrice = new EmployeePrice();
            employeePrice.setId("");
            customer.setEmployeePrice(employeePrice);
            AgencyPrice agency = new AgencyPrice();
            agency.setId("4028805c5e74f76e015e74f77e4a0000");
            customer.setAgencyPrice(agency);
            customerService.add(customer);
        }
    }

    @Test
    @Transactional
    public void testqueryById(){
        Customer customer = customerService.queryById("297ec0ae5ea8a94c015ea8b0c6bf0000");
        System.out.println(customer.getEmployeePrice().getBuildingsPrice().getName());
    }

    @Test//修改客户信息
    public void testupdateCustomer(){
        Customer customer = new Customer();
        customer.setId("402880345e4f6dde015e4f6de2870000");
        customer.setName("女王");
        customer.setGender("女");
        customer.setBirthday(new Date());
        customer.setIdentity_id("123456789");
        customer.setEmail("123000@qq.com");
        customer.setPhone("13802266400");
        customer.setAddress("北海道");
        customer.setCustomer_type("购房客户");
        customer.setTogether("老王，老李");
        customer.setContract("电子合同路径，有就添加，没有就空");
        customer.setArchives("文档路径");
        customerService.updateCustomer(customer);

    }

    @Test//给客户上传电子版购房合同路径
    public void testupdateContract(){
        Customer customer = new Customer();
        customer.setId("402880345e4f8b13015e4f8b17280000");
        customer.setContract("/dasdasd/bbb/文档.docl");
        customerService.updateContract(customer.getId(),customer.getContract());
    }

    @Test//给客户上传zip版电子档案路径
    public void testupdateArchives(){
        Customer customer = new Customer();
        customer.setId("402880345e4f6dde015e4f6de2870000");
        customer.setArchives("/dasdasd/bbb/文档.zip");
        customerService.updateContract(customer.getId(),customer.getArchives());
    }


    @Test//分页查询员工添加的客户
    @Transactional
    public void testqueryCustomer(){
        Pager<Customer> customerPager = new Pager<>();
        customerPager.setPageNo(1);
        customerPager.setPageSize(10);
        customerPager = customerService.queryCustomer(customerPager,"402880345e4a8d86015e4a8d8a1b0000");
        for (Customer customer:customerPager.getResult()){
            System.out.println(customer);
        }
    }

    @Test//分页查询员工添加的被冻结或激活的客户
    @Transactional
    public void testqueryCustomerStatus(){
        Pager<Customer> customerPager = new Pager<>();
        customerPager.setPageNo(1);
        customerPager.setPageSize(10);
        customerPager = customerService.queryCustomerStatus(customerPager,"402880345e4a8d86015e4a8d8a1b0000",1);
        for (Customer customer:customerPager.getResult()){
            System.out.println(customer);
        }
    }

    @Test//批量冻结或激活
    public void testupdateStatus(){
        Pager<Customer> customerPager = new Pager<>();
        customerPager.setPageNo(1);
        customerPager.setPageSize(10);
        String[] id = new String[20];
        int i =0;
        customerPager = customerService.queryCustomerStatus(customerPager,"402880345e4a8d86015e4a8d8a1b0000",0);
        for (Customer customer:customerPager.getResult()){
            System.out.println(customer);
            id[i] = customer.getId();
            if(i<20){
                i++;
            }
        }
        customerService.updateStatus(id,1);
    }

}
