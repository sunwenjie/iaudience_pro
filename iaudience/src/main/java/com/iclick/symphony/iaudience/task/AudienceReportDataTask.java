package com.iclick.symphony.iaudience.task;

import com.iclick.symphony.iaudience.service.AudienceReportDataService;

import javax.annotation.Resource;

/**
 * Created by wenjie.sun on 2017/6/20.
 */
public class AudienceReportDataTask {
    @Resource
    private AudienceReportDataService audienceReportDataService;
    public void run(){
        try {
            audienceReportDataService.saveReportData();
        }catch (Exception e){
            e.printStackTrace();
        }

    }
}
