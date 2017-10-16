import com.ht.common.ResultToBean;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

public class ResultToBeanTest {

    @Test
    public void testResultToBean() {
        List<Object[]> results = new ArrayList<Object[]>();
        for (int i = 0; i < 2; i++) {
            Object[] objects = new Object[2];
            objects[0] = "aa";
            objects[1] = 10;
            results.add(objects);
        }
        List<MyBean> myBeans = ResultToBean.resultToBean(MyBean.class, results, new String[]{"a", "b"});
        System.out.println(myBeans.size());
        for (Object myBean : myBeans) {
            System.out.println( myBean);
        }
    }
}


