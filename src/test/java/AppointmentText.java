import com.ht.bean.*;
import com.ht.common.Pager;
import com.ht.price.AgencyPrice;
import com.ht.price.EmployeePrice;
import com.ht.price.UserPrice;
import com.ht.service.AppointmentService;
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
public class AppointmentText {

    @Resource
    private AppointmentService appointmentService;

    @Test
    public void testadd() {
        for (int i = 0; i < 20; i++) {
            Appointment appointment = new Appointment();
            EmployeePrice employee = new EmployeePrice();
            employee.setId("4028805c5e74fb1e015e74fb2d280000");
            AgencyPrice agencyPrice = new AgencyPrice();
            agencyPrice.setId("4028805c5e74f76e015e74f77e4a0000");
            House house = new House();
            house.setId("4028805c5e74fc53015e74fc62ea0001");
            UserPrice user = new UserPrice();
            user.setId("4028805c5e74f706015e74f717270000");
            appointment.setEmployeePrice(employee);
            appointment.setUserPrice(user);
            appointment.setAgencyPrice(agencyPrice);
            appointment.setHouse(house);
            appointment.setApp_arrive_time(new Date());
            appointment.setArrive_time(new Date(new Date().getTime() + 1000000000));
            appointment.setApp_status(1);
            appointment.setCreated_time(Calendar.getInstance().getTime());
            appointment.setStatus(1);
            appointmentService.add(appointment);
        }
    }

    @Test//分页查询某个用户下的预约记录
    @Transactional
    public void testqueryAllAppointment() {
        Pager<Appointment> appointmentPager = new Pager<>();
        appointmentPager.setPageNo(1);
        appointmentPager.setPageSize(3);
        appointmentPager = appointmentService.queryAllAppointment(appointmentPager, "4028805c5e74f706015e74f717270000");
        appointmentPager.setPageSize(10);
        appointmentPager = appointmentService.queryAllAppointment(appointmentPager, "402880355e64ac65015e64ad09550000");
        for (Appointment appointment1 : appointmentPager.getResult()) {
            System.out.println(appointment1.getHouse().getName());
            for (Appointment appointment : appointmentPager.getResult()) {
                System.out.println(appointment.getHouse().getIntro());
            }
            System.out.println(appointment1.getHouse().getIntro());
        }
        System.out.println(appointmentPager);
    }

    @Test
    public void queryAppoint() {
        Pager<Appointment> pager = new Pager<Appointment>();
        pager.setPageSize(5);
        pager.setTotalPageSize(1);
        pager.setTotal(appointmentService.count());
        pager.setPageNo(1);
        pager = appointmentService.queryPager(pager, "402880595e28b110015e28b29ba10000");
        System.out.println(pager.getResult());
    }

    @Test
    @Transactional
    public void queryAppointment(){
        Appointment appointment = appointmentService.queryById("4028805c5e74fe67015e74fe76480000");

        System.out.println(appointment.getEmployeePrice().getName());
    }

    @Test
    public void queryApp(){
        Appointment appointment = appointmentService.queryAppointment("402880355e64ac65015e64ad09550000","402880355e59b2b0015e59b2b4e00000");
        System.out.println(appointment);
    }
}
