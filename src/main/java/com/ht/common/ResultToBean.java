package com.ht.common;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

public class ResultToBean {

    public static <T> List<T> resultToBean(Class<T> clazz, List<Object[]> results, String[] columns) {
        List<T> beans = new ArrayList<T>();
        for (int i = 0, size = results.size(); i < size; i++) {
            try {
                T t = clazz.newInstance();

                for (int j = 0, len = columns.length; j < len; j++) {
                    String fieldName = columns[j];
                    Field field = clazz.getDeclaredField(fieldName);
                    field.setAccessible(true);
                    field.set(t, results.get(i)[j]);
                }
                beans.add(t);
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (NoSuchFieldException e) {
                e.printStackTrace();
            } catch (InstantiationException e) {
                e.printStackTrace();
            }
        }
        return beans;
    }

}
