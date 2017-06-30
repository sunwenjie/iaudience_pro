package com.iclick.symphony.iaudience.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "iau_audience_record")
public class AudienceRecord {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "audience_id", nullable = false)
    private int audienceId;

    @Column(name = "total", nullable = false)
    private Long total;

    @Column(name = "date", nullable = false)
    private String date;

    @Column(name = "type", nullable = false)
    private Integer type;

    @Column(name = "create_time", nullable = false)
    private Date createTime;

  public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public int getAudienceId() {
    return audienceId;
  }

  public void setAudienceId(int audienceId) {
    this.audienceId = audienceId;
  }

  public Long getTotal() {
    return total;
  }

  public void setTotal(Long total) {
    this.total = total;
  }

  public String getDate() {
    return date;
  }

  public void setDate(String date) {
    this.date = date;
  }

  public Integer getType() {
    return type;
  }

  public void setType(Integer type) {
    this.type = type;
  }

public Date getCreateTime() {
    return createTime;
}

public void setCreateTime(Date createTime) {
    this.createTime = createTime;
}
  
  
}
