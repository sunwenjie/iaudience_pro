package com.iclick.symphony.iaudience.model.remote;

/**
 * Created by wenjie.sun on 2017/4/17.
 */
public class RetargetingComposition {
  private int clientId;
  private int audienceId;
  private int eventId;
  private int eventSize;
  private int convSize;

  public RetargetingComposition(int clientId, int audienceId, int eventId, int eventSize, int convSize) {
    this.clientId = clientId;
    this.audienceId = audienceId;
    this.eventId = eventId;
    this.eventSize = eventSize;
    this.convSize = convSize;
  }

  public int getClientId() {
    return clientId;
  }

  public void setClientId(int clientId) {
    this.clientId = clientId;
  }

  public int getAudienceId() {
    return audienceId;
  }

  public void setAudienceId(int audienceId) {
    this.audienceId = audienceId;
  }

  public int getEventId() {
    return eventId;
  }

  public void setEventId(int eventId) {
    this.eventId = eventId;
  }

  public int getEventSize() {
    return eventSize;
  }

  public void setEventSize(int eventSize) {
    this.eventSize = eventSize;
  }

  public int getConvSize() {
    return convSize;
  }

  public void setConvSize(int convSize) {
    this.convSize = convSize;
  }
}
