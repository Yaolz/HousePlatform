import com.ht.bean.ArticleType;
import com.ht.service.ArticleTypeService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by yao on 2017/8/30.
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring-hibernate.xml")
public class ArticleTypeTest {
    @Resource
    private ArticleTypeService articleTypeService;

    @Test
    public void testAdd() {
        ArticleType articleType = new ArticleType();
        articleType.setName("搞笑4");
        articleType.setDes("搞笑啊啊啊");
        articleTypeService.add(articleType);
        System.out.println(articleType);
    }

    @Test
    @Transactional
    public void testQueryId() {
        ArticleType articleType = articleTypeService.queryById("297ec8855e330955015e330aff4a0001");
        if(articleType != null) {
            System.out.println(articleType);
        } else {
            System.out.println("错误");
        }
    }

    @Test
    public void testRemove() {
        ArticleType articleType = articleTypeService.queryById("297ec8855e331f1d015e331f295c0000");
        articleTypeService.remove(articleType);
    }
    @Test
    public void testUpdate(){
        ArticleType articleType = new ArticleType();
        articleType.setId("297ec8855e33210c015e3321188d0000");
        articleType.setName("111");
        articleType.setDes("1111");
        articleTypeService.update(articleType);
    }

    @Test
    public void testQuery() {
        List<ArticleType> articleTypes = articleTypeService.queryAll();
        for(ArticleType a : articleTypes) {
            System.out.println(a);
        }
    }

}
