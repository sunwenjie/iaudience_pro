package com.iclick.symphony.iapps.domain;

import java.io.Serializable;
import javax.persistence.*;

import com.iclick.symphony.iapps.constants.CurrencyUnitEnum;

import java.math.BigDecimal;
import java.util.Set;


/**
 * The persistent class for the account_balance database table.
 * 
 */
@Entity
@Table(name="account_balance")
@NamedQuery(name="AccountBalance.findAll", query="SELECT a FROM AccountBalance a")
public class AccountBalance implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;

	private BigDecimal balance;

	private Integer unit;

	@Column(name="user_id")
	private Integer userId;

	//bi-directional many-to-one association to AccountBlanceRecord
	@OneToMany(mappedBy="accountBalance")
	private Set<AccountBlanceRecord> accountBlanceRecords;

	public AccountBalance() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public BigDecimal getBalance() {
		return this.balance;
	}

	public void setBalance(BigDecimal balance) {
		this.balance = balance;
	}

	public Integer getUnit() {
		return this.unit;
	}

	public void setUnit(Integer unit) {
		this.unit = unit;
	}

	public Integer getUserId() {
		return this.userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Set<AccountBlanceRecord> getAccountBlanceRecords() {
		return this.accountBlanceRecords;
	}

	public void setAccountBlanceRecords(Set<AccountBlanceRecord> accountBlanceRecords) {
		this.accountBlanceRecords = accountBlanceRecords;
	}

	public AccountBlanceRecord addAccountBlanceRecord(AccountBlanceRecord accountBlanceRecord) {
		getAccountBlanceRecords().add(accountBlanceRecord);
		accountBlanceRecord.setAccountBalance(this);

		return accountBlanceRecord;
	}

	public AccountBlanceRecord removeAccountBlanceRecord(AccountBlanceRecord accountBlanceRecord) {
		getAccountBlanceRecords().remove(accountBlanceRecord);
		accountBlanceRecord.setAccountBalance(null);

		return accountBlanceRecord;
	}
	
	public String getDisplay(){
	    CurrencyUnitEnum unit = CurrencyUnitEnum.findByValue(this.unit);
	    return unit.getSymbol() + balance;
	}

}