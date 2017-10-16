import com.ht.bean.Agency;
import com.ht.bean.Buildings;
import com.ht.bean.BuildingsImg;
import com.ht.bean.User;
import com.ht.common.Pager;
import com.ht.service.BuildingsImgService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")
public class BuildingsImgTest {

    @Resource
    private BuildingsImgService buildingsImgService;

    @Test
    public void  testadd(){//给楼盘添加图片
        BuildingsImg buildingsImg = new BuildingsImg();
        buildingsImg.setImg_path("uploads/fish.jpg");
        buildingsImg.setImg_des("图片描述");
        buildingsImg.setCreated_time(new Date());
        Buildings buildings = new Buildings();
        buildings.setId("4028805a5e4baf0b015e4baf1e9b0000");
        buildingsImg.setBuildings(buildings);
        buildingsImgService.add(buildingsImg);
    }

    @Test//分页查询某个楼盘的图片
    @Transactional//加上事物才能懒加载
    public void  testqueryAllBuildingsImg(){
        Pager<BuildingsImg> agencyPager = new Pager<>();
        agencyPager.setPageNo(1);
        agencyPager.setPageSize(10);
        agencyPager = buildingsImgService.queryAllBuildingsImg(agencyPager,"402880345e28b872015e28b876da0000");
        for (BuildingsImg buildingsImg :agencyPager.getResult()){
            System.out.println(buildingsImg+"属于"+buildingsImg.getBuildings().getName()+"楼盘");
        }
    }

    @Test
    public void  test(){//判断对象属于哪个类
        List<Object>  objects= new ArrayList<Object>();
        User user = new User();
        user.setId("123456");
        objects.add(user);
        Agency agency = new Agency();
        agency.setId("123456");
        objects.add(agency);
       for (Object object:objects){
           if( object instanceof User){
               User user1 = (User) object;
                System.out.println("是User对象"+user1);
           }else if(object instanceof  Agency){
               Agency agency1 = (Agency)object;
               System.out.println("是Agency对象"+agency1);
           }
       }
    }
}
