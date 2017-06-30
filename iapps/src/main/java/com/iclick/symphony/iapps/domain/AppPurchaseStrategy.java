package com.iclick.symphony.iapps.domain;

import java.io.Serializable;
import javax.persistence.*;

import org.apache.commons.lang3.StringUtils;

import com.iclick.symphony.iapps.constants.CurrencyUnitEnum;
import com.iclick.symphony.iapps.constants.PurchargeTypeEnum;

import java.math.BigDecimal;


/**
 * The persistent class for the app_purchase_strategy database table.
 * 
 */
@Entity
@Table(name="app_purchase_strategy")
@NamedQuery(name="AppPurchaseStrategy.findAll", query="SELECT a FROM AppPurchaseStrategy a")
public class AppPurchaseStrategy implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;

	@Column(name="currency_unit")
	private Integer currencyUnit;

	private Integer num;

	private BigDecimal price;

	private Integer type;

	//bi-directional many-to-one association to AppInfo
	@ManyToOne
	@JoinColumn(name="app_id")
	private AppInfo appInfo;

	public AppPurchaseStrategy() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getCurrencyUnit() {
		return this.currencyUnit;
	}

	public void setCurrencyUnit(Integer currencyUnit) {
		this.currencyUnit = currencyUnit;
	}

	public Integer getNum() {
		return this.num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public BigDecimal getPrice() {
		return this.price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public Integer getType() {
		return this.type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public AppInfo getAppInfo() {
		return this.appInfo;
	}

	public void setAppInfo(AppInfo appInfo) {
		this.appInfo = appInfo;
	}

	public String getDisplay(){
	    CurrencyUnitEnum cu = CurrencyUnitEnum.findByValue(currencyUnit);
	    PurchargeTypeEnum pt = PurchargeTypeEnum.findByValue(type);
	    if(cu == null || type == 0 || type > 5 || pt == null){
	        return PurchargeTypeEnum.FREE.getCode();
	    }
	    
	    String unit = "";
	    if(StringUtils.isNotBlank(pt.getCode())){
	        unit = " / ";
	        if(num > 1){
	            unit += num + " " + pt.getCode();
	        }else if(num == 1){
	            unit += pt.getCode();
	        }
	    }
	    
	    return cu.getSymbol() + this.price + unit;
	}
}