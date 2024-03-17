package com.todoapp.todoapp.TODOUtils;

import java.time.LocalDate;

public class DateFormatUtil {
    
    static LocalDate formatDateString(String date){
        LocalDate parseDate = LocalDate.parse(date);
        System.out.println(parseDate);
        return parseDate;
    }
}
