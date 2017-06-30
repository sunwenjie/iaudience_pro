package com.iclick.symphony.iaudience.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.iclick.symphony.iaudience.model.remote.AudienceAttributes;
import com.iclick.symphony.iaudience.model.remote.BrandKeywordsComparison;
import com.iclick.symphony.iaudience.model.remote.CompoundQuery;
import com.iclick.symphony.iaudience.model.remote.LbsAttributes;
import com.iclick.symphony.iaudience.model.remote.ParamQuery;

public class AudienceRestUtil {
	static String PROVINCE = "province";
	static String CITY = "city";
	static String GENDER = "gender";
	static String AGE = "age";
	static String DEVICE = "device";
	static String KEYWORD = "keyword";
	static String INTEREST = "interest";
	static String RAW_INTEREST = "raw_interest";
	static String AGGS_FIELDS = "aggs_fields";

	static String NODE_BRAND = "brand";
	static String NODE_COMPETITOR = "competitor";

	static public String getIaudienceComparesionParame(final String[] brandKeyword, final String[] otherBrandKeyword) {
		BrandKeywordsComparison brandKeywordsComparison = new BrandKeywordsComparison();

		String[] aggss = { AGE, GENDER, RAW_INTEREST, DEVICE, PROVINCE };
		List<String> aggs_fields = Arrays.asList(aggss);

		brandKeywordsComparison.setAggs_fields(aggs_fields);
		AudienceAttributes brand = new AudienceAttributes();
		brand.setAggs_fields(aggs_fields);
		brand.setKeyword(brandKeyword);
		brandKeywordsComparison.setBrand(brand);

		AudienceAttributes competitor = new AudienceAttributes();
		competitor.setKeyword(otherBrandKeyword);
		competitor.setAggs_fields(aggs_fields);
		brandKeywordsComparison.setCompetitor(competitor);

		return brandKeywordsComparison.toString();
	}

	static public List<String> getIaudienceComparesionParames(final String brandKeyword,
			final List<String> otherBrandKeywords) {

		List<String> parames = new ArrayList<>();
		for (String otherBrandKeyword : otherBrandKeywords) {
			parames.add(getIaudienceComparesionParame(brandKeyword.split(","), otherBrandKeyword.split(",")));
		}

		return parames;
	}

	public static void main(String[] args) {
		String[] brand = { "肯德基" };
		String[] otherB = { "麦当劳", "汉堡王" };
		String brandJSONObject = AudienceRestUtil.getIaudienceComparesionParame(brand, otherB);

		System.out.println(brandJSONObject.toString());
	}

	static public String getAudienceAttributesParame(final String[] keyword, final String[] interest,
			final String[] ageGroup, final String[] gender, final String[] region, final String[] aggss) {
		AudienceAttributes audienceAttributes = new AudienceAttributes();
		audienceAttributes.setAggs_fields(aggss == null ? null : Arrays.asList(aggss));
		audienceAttributes.setKeyword(keyword);
		audienceAttributes.setInterest(interest);
		audienceAttributes.setAge(ageGroup);
		audienceAttributes.setProvince(region);
		audienceAttributes.setGender(gender);
		return audienceAttributes.toString();
	}

	static public String getAudienceParame(final String[] keyword, final String[] interest, final String[] ageGroup,
			final String[] gender, final String[] region) {
		String[] aggss = { INTEREST, AGE, GENDER, RAW_INTEREST, PROVINCE };
		return getAudienceAttributesParame(keyword, interest, ageGroup, gender, region, aggss);
	}

	static public String getAudienceCustomParame(final String[] keyword, final String[] interest,
			final String[] ageGroup, final String[] gender, final String[] region) {
		String[] aggss = { KEYWORD };
		return getAudienceAttributesParame(keyword, interest, ageGroup, gender, region, aggss);
	}

	static public String getInterestParame(final String[] interest, Boolean needAggs) {
		String[] aggss = null;
		if (needAggs)
			aggss = new String[] { INTEREST };
		return getAudienceAttributesParame(null, interest, null, null, null, aggss);
	}


	static public String getAudienceTotalParame(final String[] keyword, final String[] interest, final String[] ageGroup,
			final String[] gender, final String[] region) {
		return getAudienceAttributesParame(keyword, interest, ageGroup, gender, region, null);
	}
	
	
	static public String getAllMarketParame(final String[] keyword, final String[] interest, final String[] ageGroup,
			final String[] gender, final String[] region) {
		AudienceAttributes audienceAttributes = new AudienceAttributes();
		// audienceAttributes.setAggs_fields(aggss == null ? null
		// :Arrays.asList(aggss));
		audienceAttributes.setKeyword(keyword);
		audienceAttributes.setInterest(interest);
		audienceAttributes.setAge(ageGroup);
		audienceAttributes.setProvince(region);
		audienceAttributes.setGender(gender);
		CompoundQuery compoundQuery = new CompoundQuery();
		ParamQuery query = new ParamQuery();
		List<AudienceAttributes> should = new ArrayList<AudienceAttributes>();
		should.add(audienceAttributes);
		query.setShould(should);
		compoundQuery.setQuery(query);
		return compoundQuery.toString();
	}

	static public String getLbsParame(final String[] keyWords, String city) {
		LbsAttributes lbs = new LbsAttributes();
		lbs.setKeyword(keyWords);
		lbs.setCity(city);
		return lbs.toString();
	}
}
