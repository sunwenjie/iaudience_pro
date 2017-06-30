package com.iclick.symphony.iaudience.model.view;

import com.alibaba.fastjson.JSON;

/**
 * Created by wenjie.sun on 2017/4/20.
 */
public class RetargetEventModel {
  private String logic;
  private int eventId;
  private String recency;
  private int frequencyMin;
  private int frequencyMax;

  public String getLogic() {
    return logic;
  }

  public void setLogic(String logic) {
    this.logic = logic;
  }

  public int getEventId() {
    return eventId;
  }

  public void setEventId(int eventId) {
    this.eventId = eventId;
  }

  public String getRecency() {
    return recency;
  }

  public void setRecency(String recency) {
    this.recency = recency;
  }

  public int getFrequencyMin() {
    return frequencyMin;
  }

  public void setFrequencyMin(int frequencyMin) {
    this.frequencyMin = frequencyMin;
  }

  public int getFrequencyMax() {
    return frequencyMax;
  }

  public void setFrequencyMax(int frequencyMax) {
    this.frequencyMax = frequencyMax;
  }

  @Override
  public String toString() {
    return JSON.toJSONString(this);
  }
}
