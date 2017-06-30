package com.iclick.symphony.iapps.domain;

import java.io.Serializable;
import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;


/**
 * The persistent class for the account_blance_record database table.
 * 
 */
@Entity
@Table(name="account_blance_record")
@NamedQuery(name="AccountBlanceRecord.findAll", query="SELECT a FROM AccountBlanceRecord a")
public class AccountBlanceRecord implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;

	private BigDecimal amount;

	@Column(name="amount_unit")
	private BigDecimal amountUnit;

	private String remark;

	private Integer type;

	private Integer unit;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="update_time")
	private Date updateTime;

	//bi-directional many-to-one association to AccountBalance
	@ManyToOne
	@JoinColumn(name="balance_id")
	private AccountBalance accountBalance;

	public AccountBlanceRecord() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public BigDecimal getAmount() {
		return this.amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public BigDecimal getAmountUnit() {
		return this.amountUnit;
	}

	public void setAmountUnit(BigDecimal amountUnit) {
		this.amountUnit = amountUnit;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getUnit() {
		return this.unit;
	}

	public void setUnit(Integer unit) {
		this.unit = unit;
	}

	public Date getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public AccountBalance getAccountBalance() {
		return this.accountBalance;
	}

	public void setAccountBalance(AccountBalance accountBalance) {
		this.accountBalance = accountBalance;
	}

}