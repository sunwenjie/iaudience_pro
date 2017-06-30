package com.iclick.symphony.iaudience.model.view;

public class EventModel {
  private int eventId;
  private String parameter;
  private String recency;
  private int frequencyMin;
  private int frequencyMax;

  public int getEventId() {
    return eventId;
  }

  public void setEventId(int eventId) {
    this.eventId = eventId;
  }

  public String getParameter() {
    return parameter;
  }

  public void setParameter(String parameter) {
    this.parameter = parameter;
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
}
