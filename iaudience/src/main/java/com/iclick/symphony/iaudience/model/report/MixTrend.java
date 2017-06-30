package com.iclick.symphony.iaudience.model.report;

import com.alibaba.fastjson.JSON;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class MixTrend {
	private String dataPeriod;
	private Map<String, List<Market>> result;
	private List<TopBrand> topBrands;

	public List<TopBrand> getTopBrands() {
		return topBrands;
	}
	public void setTopBrands(List<TopBrand> topBrands) {
		this.topBrands = topBrands;
	}
	
	public String getDataPeriod() {
		return dataPeriod;
	}

	public void setDataPeriod(String dataPeriod) {
		this.dataPeriod = dataPeriod;
	}

	public Map<String, List<Market>> getResult() {
		return result;
	}

	public void setResult(Map<String, List<Market>> result) {
		this.result = result;
	}


	@Override
	public String toString() {
		return JSON.toJSONString(this);
	}
	
	public static void main(String[] args) {
		MixTrend mix = new MixTrend();
		mix.setDataPeriod("Period: 2017/05/20 - 2017/06/19");
		
	    Map<String, List<Market>> result = new HashMap<String, List<Market>> ();
	    Market  market  = new Market();
	    market.setDate("2017-05-20");
	    market.setName("Market Audience");
	    market.setValue("11");
	    Market  market1  = new Market();
	    market1.setDate("2017-05-21");
	    market1.setName("Market Audience");
	    market1.setValue("21");
	    
	    
	    Market  marketShare  = new Market();
	    marketShare.setDate("2017-05-20");
	    marketShare.setName("Market Share");
	    marketShare.setValue("91");
	    Market  marketShare1  = new Market();
	    marketShare1.setDate("2017-05-20");
	    marketShare1.setName("Market Share");
	    marketShare1.setValue("91");
	    
	    
	    List<Market> marketA = new ArrayList<Market>();
	    marketA.add(market);
	    marketA.add(market1);
	    

	    List<Market> marketS = new ArrayList<Market>();
	    marketS.add(marketShare);
	    marketS.add(marketShare1);
	    result.put("Market Audience", marketA);
	    result.put("Market Share", marketS);
		mix.setResult(result);
		System.out.println(mix.toString());
	}
}
