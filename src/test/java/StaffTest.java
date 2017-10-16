import com.ht.bean.Room;
import com.ht.bean.Sale;
import com.ht.common.Pager;
import com.ht.price.AgencyPrice;
import com.ht.price.CustomerPrice;
import com.ht.price.EmployeePrice;
import com.ht.service.EmployeeService;
import com.ht.service.SaleService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;

/**
 * Created by ID.LQF on 2017/9/3.
 * 销售记录测试类
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")
public class StaffTest {

    @Resource
    private SaleService saleService;
    private List<Sale> sales;
    private Long total;
    private Sale sale;
    private int totalPage;
    private int pageSize = 5;
    private int pageNo = 1;

    @Test
    public void queryPage(){//根据id来分页查看
        Pager<Sale> pager = new Pager<Sale>();
        pager.setPageSize(pageSize);
        pager.setTotalPageSize(totalPage);
        pager.setTotal(saleService.count());
        total = pager.getTotal();
        totalPage = pager.getTotalPageSize();
        pager.setPageNo(pageNo);
        pager = saleService.queryPager(pager,"402880595e28b110015e28b29ba10100");
        sales = pager.getResult();
        System.out.println(sales);

    }

    @Test
    public void testqueryById(){

    }

    @Test//添加销售记录表
    public void testadd(){
        Sale sale = new Sale();
        CustomerPrice customerPrice = new CustomerPrice();
        customerPrice.setId("402880355e59bd15015e59bd19f50000");
        EmployeePrice employeePrice = new EmployeePrice();
        employeePrice.setId("402880355e59bca2015e59bca6a10000");
        AgencyPrice agencyPrice = new AgencyPrice();
        agencyPrice.setId("402880355e59ac4d015e59ac51560000");
        Room room = new Room();
        room.setId("402880355e59b1a4015e59b1a9590002");
        sale.setRoom(room);
        sale.setAgencyPrice(agencyPrice);
        sale.setEmployee(employeePrice);
        sale.setCustomer(customerPrice);
        sale.setSale_time(new Date());
        sale.setUnit_price(5000.0);
        sale.setDiscount(5.0);
        sale.setTotal_cost(2000000.0);
        sale.setCreated_time(new Date());
        sale.setStatus(1);
        saleService.add(sale);
    }

}
