package com.iclick.symphony.iapps.domain;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Date;


/**
 * The persistent class for the app_purchase_records database table.
 * 
 */
@Entity
@Table(name="app_purchase_records")
@NamedQuery(name="AppPurchaseRecord.findAll", query="SELECT a FROM AppPurchaseRecord a")
public class AppPurchaseRecord implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;

	@Column(name="purchase_strategy_id")
	private Integer purchaseStrategyId;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="purchase_time")
	private Date purchaseTime;

	public AppPurchaseRecord() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getPurchaseStrategyId() {
		return this.purchaseStrategyId;
	}

	public void setPurchaseStrategyId(Integer purchaseStrategyId) {
		this.purchaseStrategyId = purchaseStrategyId;
	}

	public Date getPurchaseTime() {
		return this.purchaseTime;
	}

	public void setPurchaseTime(Date purchaseTime) {
		this.purchaseTime = purchaseTime;
	}

}