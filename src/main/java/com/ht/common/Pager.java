package com.ht.common;

import java.util.List;

/**
 * Created by Master on 2017/8/2.
 */
public class Pager<T> {

    private int pageNo;//当前页数
    private int pageSize;//每页显示多少条记录
    private long total;//一共有多少个结果
    private int totalPageSize;//一共多少页
    private List<T> result;//放结果

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        totalPageSize = ((int)total) % pageSize == 0 ? ((int)total) / pageSize : ((int)total) / pageSize + 1;//计算出一共有多少页
        this.total = total;
    }

    public List<T> getResult() {
        return result;
    }

    public void setResult(List<T> result) {
        this.result = result;
    }

    public int getTotalPageSize() {
        return totalPageSize;
    }

    public void setTotalPageSize(int totalPageSize) {
        this.totalPageSize = totalPageSize;
    }

    public int getIndex() {
        return (pageNo - 1) * pageSize;//(当前显示页-1)*每页显示的个数
    }

}
