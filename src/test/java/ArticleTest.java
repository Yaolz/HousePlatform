import com.ht.bean.Admin;
import com.ht.bean.Article;
import com.ht.bean.ArticleType;
import com.ht.common.Pager;
import com.ht.service.ArticleService;
import com.ht.service.ArticleTypeService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;

/**
 * Created by yao on 2017/8/30.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")
public class ArticleTest {
    @Resource
    private ArticleService articleService;



    @Test
    @Transactional
    public void testQueryId() {
        Article article = articleService.queryById("4028abf45e3d509c015e3d50a7910000");
        if(article != null) {
            System.out.println(article);
            System.out.println(article.getArticleType());
            System.out.println(article.getAdmin());
        } else {
            System.out.println("错误");
        }
    }

    @Test
    public void testAdd() {
        Article article = new Article();
        ArticleType articleType = new ArticleType();
        Admin admin = new Admin();
        article.setTitle("来玩啊，客官！");
        article.setAbstracts("文章摘要");
        article.setContent("sssssssssssssssssssssssssssssssssssssssss");
        article.setLogo("uploads/97.jpg");
        article.setCreated_time(new Date());
        article.setStatus(1);
        articleType.setId("297ec8855e33216c015e332179dd0000");
        admin.setId("7850cc60886411e7a5142c56dc7febbc");
        article.setArticleType(articleType);
        article.setAdmin(admin);
        articleService.add(article);
    }

    @Test
    public void testAbc() {
        Pager<Article> pager = new Pager<>();
        pager.setPageNo(1);
        pager.setPageSize(5);
        pager = articleService.queryPager(pager,1);
        for(Article article : pager.getResult()) {
            System.out.println(article);
            System.out.println(article.getArticleType().getName());
        }
    }

    @Test
    @Transactional
    public void testqueryAllindex(){
        Pager<Article> pager = new Pager<>();
        pager.setPageNo(1);
        pager.setPageSize(10);
        pager = articleService.queryAllindex(pager,"4028805a5e4f6fb3015e4f74f55d0004"," ");
        for(Article a : pager.getResult()) {
            System.out.println(a);
        }
    }

}
