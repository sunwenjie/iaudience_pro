package com.iclick.symphony.iapps.domain;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the exchange_rate database table.
 * 
 */
@Entity
@Table(name="exchange_rate")
@NamedQuery(name="ExchangeRate.findAll", query="SELECT e FROM ExchangeRate e")
public class ExchangeRate implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;

	@Column(name="from_unit")
	private Integer fromUnit;

	private BigDecimal rate;

	@Column(name="to_unit")
	private Integer toUnit;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="update_time")
	private Date updateTime;

	public ExchangeRate() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getFromUnit() {
		return this.fromUnit;
	}

	public void setFromUnit(Integer fromUnit) {
		this.fromUnit = fromUnit;
	}

	public BigDecimal getRate() {
		return this.rate;
	}

	public void setRate(BigDecimal rate) {
		this.rate = rate;
	}

	public Integer getToUnit() {
		return this.toUnit;
	}

	public void setToUnit(Integer toUnit) {
		this.toUnit = toUnit;
	}

	public Date getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

}