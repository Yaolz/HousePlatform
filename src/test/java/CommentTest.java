import com.ht.bean.Comment;
import com.ht.bean.Customer;
import com.ht.common.Pager;
import com.ht.price.BuildingsPrice;
import com.ht.price.UserPrice;
import com.ht.service.CommentService;
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
public class CommentTest {

    @Resource
    private CommentService commentService;

    @Test
    public void testadd(){
        for(int i = 0; i < 20; i++) {
            Comment comment = new Comment();
            comment.setContent("啊大神");
            comment.setComment_time(new Date());
            BuildingsPrice buildingsPrice = new BuildingsPrice();
            buildingsPrice.setId("402880355e59ad56015e59ad5a820000");
            UserPrice userPrice = new UserPrice();
            userPrice.setId("297ec0ae5ea8a94c015ea8b5e18b0001");
            comment.setStatus(1);
            comment.setBuildingsPrice(buildingsPrice);
            comment.setUserPrice(userPrice);
            commentService.add(comment);
        }
    }

    @Test//分页查询某个楼盘下的评价记录
    public void testqueryAllCommentBuildings(){
        Pager<Comment> commentPager = new Pager<>();
        commentPager.setPageNo(1);
        commentPager.setPageSize(10);
        commentPager = commentService.queryAllCommentBuildings(commentPager,"4028805a5e4baf0b015e4baf1e9b0000",1);
        for (Comment comment :commentPager.getResult()){
            System.out.println(comment+"---"+comment.getUserPrice().getName()+"-----"+comment.getBuildingsPrice().getName());
        }
    }

    @Test//分页查询某个经销商下所有楼盘的评价记录
    @Transactional
    public void testqueryAllCommentAgency(){
        Pager<Comment> commentPager = new Pager<>();
        commentPager.setPageNo(1);
        commentPager.setPageSize(10);
        commentPager = commentService.queryAllCommentAgency(commentPager,"297eaf225e3b0b1c015e3b0b21870000",1);
        for (Comment comment :commentPager.getResult()){
            System.out.println(comment+"---"+comment.getUserPrice().getName()+"-----"+comment.getBuildingsPrice().getName());
        }
    }
    @Test
    public void testDelete(){
        String[] id=new String[2];
        id[0]="402880ce5eb3cc0f015eb3cc252e0001";
        id[1]="402880ce5eb3cc0f015eb3cc26080002";
        commentService.deleteComment(id);
    }
}
