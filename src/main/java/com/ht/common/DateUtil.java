package com.ht.common;

/**
 * Created by Master on 2017/6/30.
 */
public class DateUtil {

    public static java.sql.Date convertor(java.util.Date date) {
        return new java.sql.Date(date.getTime());
    }
}
