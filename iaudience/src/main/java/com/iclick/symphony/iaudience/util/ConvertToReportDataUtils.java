package com.iclick.symphony.iaudience.util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeMap;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.iclick.symphony.iaudience.model.remote.AttributeBase;
import com.iclick.symphony.iaudience.model.remote.AudienceComposition;
import com.iclick.symphony.iaudience.model.remote.ComparisonComposition;
import com.iclick.symphony.iaudience.model.remote.Interest;
import com.iclick.symphony.iaudience.model.report.AudienceChart;
import com.iclick.symphony.iaudience.model.report.AudienceChartData;
import com.iclick.symphony.iaudience.model.report.BaseCell;
import com.iclick.symphony.iaudience.model.report.BubbleChart;
import com.iclick.symphony.iaudience.model.report.CityChart;
import com.iclick.symphony.iaudience.model.report.CityChartRow;
import com.iclick.symphony.iaudience.model.report.InterestCell;
import com.iclick.symphony.iaudience.model.report.InterestSummary;

public class ConvertToReportDataUtils {

    static private String DATE_TYPE_MAIN_BRAND = "mainBrand";

    static private String DATE_TYPE_OTHER_BRAND = "otherBrand";

    static private String DATE_TYPE_INNER_BRAND = "innerBrand";

    // static private String LANUAGE_ZH = "zh";
    //
    // static private String LANUAGE_EN = "en";

    static private String UNKNOWN = "UNKNOWN";

    static private int CITY_TOP = 8;

    static private int INTERSET_TOP = 5;

    static public BubbleChart comparisonToBubble(ComparisonComposition comparisonComposition, String brand,
            String otherBrand) {
        BubbleChart bubbleChartRow = null;
        if (comparisonComposition == null) {
            return bubbleChartRow;
        }
        bubbleChartRow = new BubbleChart();
        bubbleChartRow.setLabel(brand);
        bubbleChartRow.setSize(comparisonComposition.getBrand().getTotal());
        return bubbleChartRow;

    }

    static public List<BubbleChart> getBubbleChart(List<ComparisonComposition> comparisonCompositions, String brand,
            List<String> otherBrandList) {
        List<BubbleChart> bubbleChartRowList = new ArrayList<>();
        ComparisonComposition compareson = null;
        BubbleChart bubbleChartRow = null;
        if (comparisonCompositions == null || otherBrandList == null
                || comparisonCompositions.size() != otherBrandList.size()) {
            return bubbleChartRowList;
        }
        for (int i = 0; i < comparisonCompositions.size(); i++) {
            compareson = comparisonCompositions.get(i);
            int j = i + 1;
            if (compareson == null || StringUtils.isBlank(otherBrandList.get(i))) {
                continue;
            }
            // 处理主brand
            if (i == 0) {
                bubbleChartRow = new BubbleChart();
                int[] setsA = { 0 };
                bubbleChartRow.setSets(setsA);
                bubbleChartRow.setLabel(brand);
                bubbleChartRow.setSize(compareson.getBrand().getTotal());
                bubbleChartRow.setRanking(0);
                bubbleChartRowList.add(bubbleChartRow);
            }
            // other brand
            bubbleChartRow = new BubbleChart();
            int[] setsB = { j };
            bubbleChartRow.setSets(setsB);
            bubbleChartRow.setLabel(otherBrandList.get(i));
            bubbleChartRow.setSize(compareson.getCompetitor().getTotal());
            bubbleChartRow.setRanking(j);
            bubbleChartRowList.add(bubbleChartRow);
            // 交集
            bubbleChartRow = new BubbleChart();
            int[] setsC = { 0, j };
            bubbleChartRow.setSets(setsC);
            bubbleChartRow.setSize(compareson.getBrand_competitor().getTotal());
            int overlap = Math
                    .round(compareson.getBrand_competitor().getTotal() * 100 / compareson.getBrand().getTotal());
            bubbleChartRow.setOverlap(overlap + "");
            bubbleChartRowList.add(bubbleChartRow);
        }
        return bubbleChartRowList;

    }


    static public List<CityChart> sortCitys(List<CityChart> cityList, String lanuage, Map<String, String> cityMap) {

        cityMap = new HashMap<String, String>();
        cityMap.put("CN_IN_AR", "辽宁");

        // CityChart cityChart = null;

        for (CityChart cityChart : cityList) {
            Collections.sort(cityChart.getCityChartRow());
            for (CityChartRow cityChartRow : cityChart.getCityChartRow()) {
                if (cityMap.containsKey(cityChartRow.getName())) {
                    cityChartRow.setName(cityMap.get(cityChartRow.getName()));
                }
            }
        }
        return cityList;

    }

    static private Map<String, Long> getMapFromAttributeBase(List objectList) {
        return getMapFromAttributeBase(objectList, null);
    }

    static private Map<String, InterestCell> getMapFromInterest(List<Interest> objectList, Locale locale) {

        Map<String, InterestCell> hashMap = new HashMap<>();
        if (objectList == null) {
            return hashMap;
        }
        String key = null;
        InterestCell cell = null;
        boolean isEnglish = Locale.ENGLISH.equals(locale);

        for (Interest objc : objectList) {
            cell = new InterestCell();
            if (isEnglish) {
                key = objc.getEn_name();
            } else {
                key = objc.getZh_cn_name();
            }
            cell.setName(key);
            cell.setId(objc.getKey());
            cell.setValue(objc.getDoc_count());
            hashMap.put(key, cell);
        }

        return hashMap;
    }

    static private Map<String, Long> getMapFromAttributeBase(List objectList, Map<String, String> mapping) {

        Map<String, Long> treeMap = new TreeMap<>();
        if (objectList == null) {
            return treeMap;
        }
        AttributeBase base = null;
        String key = null;
        for (Object objc : objectList) {
            base = (AttributeBase) objc;

            key = base.getKey();
            if (UNKNOWN.equals(key)) {
                continue;
            }
            if (mapping != null && mapping.containsKey(key)) {
                key = mapping.get(key);
            }
            treeMap.put(base.getKey(), base.getDoc_count());
        }

        return treeMap;
    }

    static private List<BaseCell> getListFromAttributeBase(List objectList, Map<String, String> mapping) {

        List<BaseCell> list = new ArrayList<>();
        if (objectList == null) {
            return list;
        }
        AttributeBase base = null;
        String key = null;
        BaseCell cell = null;
        for (Object objc : objectList) {
            base = (AttributeBase) objc;
            cell = new BaseCell();
            key = base.getKey();
            if (UNKNOWN.equals(key)) {
                continue;
            }
            if (mapping != null && mapping.containsKey(key)) {
                key = mapping.get(key);
            }
            cell.setName(key);
            cell.setValue(base.getDoc_count());
            list.add(cell);
        }
        return list;
    }

    static public AudienceChartData getAudienceChartData(AudienceComposition audienceComposition,
            Map<String, String> intersetMaping, Map<String, String> cityMaping, Map<String, String> commonMaping,
            Locale locale,Long allMarket) {
        AudienceChartData data = new AudienceChartData();

        if (audienceComposition == null) {
            return data;
        }
        data.setAudience(audienceComposition.getTotal());

        data.setAge_group(getMapFromAttributeBase(audienceComposition.getAge()));

        // 需要国际化
        data.setDevice(getMapFromAttributeBase(audienceComposition.getDevice()));

        data.setGender(getMapFromAttributeBase(audienceComposition.getGender()));
        List<BaseCell> cityListEn = getListFromAttributeBase(audienceComposition.getProvince(), MappingUtils.getProvinceMapping(Locale.ENGLISH));
        List<BaseCell> cityListZh = getListFromAttributeBase(audienceComposition.getProvince(), MappingUtils.getProvinceMapping(Locale.CHINESE));

        //data.setRegionAll(cityList);
        
        // 取top 8 剩余合计为其他
        data.setRegionsEN(cityTop(cityListEn, CITY_TOP, Locale.ENGLISH));
        data.setRegionsZH(cityTop(cityListZh, CITY_TOP, Locale.CHINESE));
        
		Map<String, Long> marketShare = new HashMap<String, Long>();
		marketShare.put("market", allMarket);
		marketShare.put("market_show", audienceComposition.getTotal());
        data.setMarket_share(marketShare);
        data.setAllMarket(allMarket);
        // 需要国际化
        Map<String, InterestCell> intersetMapEn = getMapFromInterest(audienceComposition.getRaw_interest(), Locale.ENGLISH);
        Map<String, InterestCell> intersetMapZh = getMapFromInterest(audienceComposition.getRaw_interest(), Locale.CHINESE);

        // 取top 5
        data.setInterestEN(interestTop(intersetMapEn,INTERSET_TOP));
        data.setInterestZH(interestTop(intersetMapZh,INTERSET_TOP));
        return data;

    }

    static public List<AudienceChart> getAudienceChartList(List<ComparisonComposition> comparisonCompositions,
            String brand, List<String> otherBrandList, Map<String, String> intersetMaping,
            Map<String, String> cityMaping, Map<String, String> commonMaping, Locale locale,Long allMarket) {
    	
    	List<AudienceChart> result = new ArrayList<>();
        ComparisonComposition compareson = null;
        AudienceChart audienceChart = null;
        AudienceChartData data = null;
        if (comparisonCompositions == null || otherBrandList == null
                || comparisonCompositions.size() != otherBrandList.size()) {
            return result;
        }
        for (int i = 0; i < comparisonCompositions.size(); i++) {
            compareson = comparisonCompositions.get(i);
            if (compareson == null || StringUtils.isBlank(otherBrandList.get(i))) {
                continue;
            }
            // 处理主brand
            if (i == 0) {
                audienceChart = new AudienceChart();
                audienceChart.setId(String.valueOf(i));
                audienceChart.setName(brand);
                audienceChart.setType(DATE_TYPE_MAIN_BRAND);
                data = ConvertToReportDataUtils.getAudienceChartData(compareson.getBrand(), intersetMaping, cityMaping,
                        commonMaping, locale,allMarket);
                audienceChart.setData(data);
                result.add(audienceChart);
            }
            // other brand
            audienceChart = new AudienceChart();
            audienceChart.setId(String.valueOf(i + 1));
            audienceChart.setName(otherBrandList.get(i));
            audienceChart.setType(DATE_TYPE_OTHER_BRAND);
            data = ConvertToReportDataUtils.getAudienceChartData(compareson.getCompetitor(), intersetMaping, cityMaping,
                    commonMaping, locale,allMarket);
            audienceChart.setData(data);
            result.add(audienceChart);
            // 交集
            audienceChart = new AudienceChart();
            audienceChart.setId("0_" + String.valueOf(i + 1));
            audienceChart.setName(brand + "VS" + otherBrandList.get(i));
            audienceChart.setType(DATE_TYPE_INNER_BRAND);
            data = ConvertToReportDataUtils.getAudienceChartData(compareson.getBrand_competitor(), intersetMaping,
                    cityMaping, commonMaping, locale,allMarket);
            audienceChart.setData(data);
            result.add(audienceChart);
        }
        return result;

    }

    static private List<BaseCell> cityTop(List<BaseCell> cityList, int top, Locale locale) {

        Collections.sort(cityList);
        if (cityList == null) {
            return cityList;
        }
        if (top > cityList.size()) {
            return cityList;
        }
        List<BaseCell> topList = new ArrayList<>(top + 2);
        BaseCell otherCell = new BaseCell();
        otherCell.setId("0");
        if (Locale.ENGLISH.equals(locale)) {
            otherCell.setName("Other City");
        } else {
            otherCell.setName("其他城市");
        }
        long total = 0;
        for (int i = 0; i < cityList.size(); i++) {
            if (i < top) {
                BaseCell cell = new BaseCell();
                BeanUtils.copyProperties(cityList.get(i), cell);
                topList.add(cell);
            } else {
                total += cityList.get(i).getValue();
            }
        }
        otherCell.setValue(total);
        topList.add(otherCell);
        return topList;
    }

    static private Map<String, InterestCell> interestTop(Map<String, InterestCell> interestMap, int top) {
        if (interestMap == null) {
            return interestMap;
        }
        if (top > interestMap.size()) {
            return interestMap;
        }
        // 排序
        List<Map.Entry<String, InterestCell>> list = new ArrayList<Map.Entry<String, InterestCell>>(
                interestMap.entrySet());
        // 然后通过比较器来实现排序

        Collections.sort(list, new Comparator<Map.Entry<String, InterestCell>>() {
            // 降序排序
            public int compare(Entry<String, InterestCell> o1, Entry<String, InterestCell> o2) {
                // 先比较id 长度， 两位为顶级 标签。顶级标签排着在前面
                if (o1.getValue().getId().length() > o2.getValue().getId().length()) {
                    return 1;
                }

                if (o1.getValue().getId().length() < o2.getValue().getId().length()) {
                    return -1;
                }

                return o2.getValue().getValue().compareTo(o1.getValue().getValue());
            }
        });
        List<Map.Entry<String, InterestCell>> topList = list.subList(0, top);
        Map<String, InterestCell> topMap = new HashMap<>();
        String idString = "";
        String subIdString = "";
        Long total=0l;
        for (Map.Entry<String, InterestCell> mapping : topList) {
        	total+=mapping.getValue().getValue();
        }
        for (Map.Entry<String, InterestCell> mapping : topList) {
        	InterestCell cell = mapping.getValue();
        	Long rate = cell.getValue()*100/total;
        	cell.setValue(rate);
            topMap.put(mapping.getKey(), cell);
            // 组合每个顶级节点拼装子节点 ，子节点按照多少排序，多的排在前，不区分 是否是 二级节点，但根据数据性质，排着前面的肯定是二级节点。
            idString = mapping.getValue().getId();
            for (Map.Entry<String, InterestCell> subMapping : list) {
                subIdString = subMapping.getValue().getId();
                if (subIdString.startsWith(idString) && (subIdString.length() > idString.length())) {
                    mapping.getValue().addSub(subMapping.getValue().getName());
                    if(mapping.getValue().getSub().size()>=top){
                        break;
                    }
                }
            }
        }
        return topMap;
    }

    static public AudienceChart getAudienceChart(AudienceComposition composition, final String type,
            final String interest, Map<String, String> intersetMaping, Map<String, String> cityMaping,
            Map<String, String> commonMaping, Locale locale) {
        AudienceChart audienceChart = new AudienceChart();
        AudienceChartData data = null;
        if (composition == null) {
            return audienceChart;
        }
        // share or market
        if (StringUtils.isNotBlank(type)) {
            audienceChart.setName(type);
        } else {
            return audienceChart;
        }

        //audienceChart.setType(DATE_TYPE_MAIN_BRAND);
        data = ConvertToReportDataUtils.getAudienceChartData(composition, intersetMaping, cityMaping, commonMaping,
                locale,null);
        audienceChart.setData(data);
        return audienceChart;
    }
    
    static public AudienceChart getShareChart(AudienceComposition composition, final String type,
            final String interest, Map<String, String> intersetMaping, Map<String, String> cityMaping,
            Map<String, String> commonMaping, Locale locale) {
        AudienceChart audienceChart = new AudienceChart();
        AudienceChartData data = null;
        if (composition == null) {
            return audienceChart;
        }
        // share or market
        if (StringUtils.isNotBlank(type)) {
            audienceChart.setName(type);
        } else {
            return audienceChart;
        }

        //audienceChart.setType(DATE_TYPE_MAIN_BRAND);
//        data = ConvertToReportDataUtils.getAudienceChartData(composition, intersetMaping, cityMaping, commonMaping,
//                locale);
        data.setAudience(composition.getTotal());
        audienceChart.setData(data);
        return audienceChart;
    }


    static public JSONArray getJsonInterestSummary(Map<Integer, InterestSummary> interestSummaryMap) {
        // 构造无序的多叉树
        List<InterestSummary> rootList = new ArrayList<InterestSummary>();
        for (Integer key : interestSummaryMap.keySet()) {
            InterestSummary interestSummary = interestSummaryMap.get(key);
            if (interestSummary.getParentAudienceId() == 0) {
                rootList.add(interestSummary);
            } else {
                InterestSummary parentInterestSummary = (InterestSummary) interestSummaryMap
                        .get(interestSummary.getParentAudienceId());
                if (parentInterestSummary == null)
                    continue;
                parentInterestSummary.addChildInterestSummary(interestSummary);
            }

        }
        StringBuffer jsonString = new StringBuffer("[");
        for (int i = 0; i < rootList.size(); i++) {
            // 对多叉树进行横向排序
            rootList.get(i).sortChildrenInterestSummary();
            // 输出有序的树形菜单的JSON字符串
            jsonString.append(rootList.get(i).toString()).append(",");
        }
        if (rootList.size() > 0)
            jsonString.deleteCharAt(jsonString.length() - 1);
        jsonString.append("]");
        System.out.println("---------ConvertToReportDataUtils.getJsonInterestSummary---------jsonString111 值= "
                + jsonString.toString());
        return JSONArray.parseArray(jsonString.toString());
    }

    static public void main(String[] arg) {
        // String jsonStr =
        // "{\"brand\":{\"age\":[{\"doc_count\":22808,\"doc_percent\":0.28867963,\"key\":\"25-34\"},{\"doc_count\":17115,\"doc_percent\":0.21662363,\"key\":\"35-44\"},{\"doc_count\":14054,\"doc_percent\":0.17788072,\"key\":\"0-17\"},{\"doc_count\":12173,\"doc_percent\":0.154073,\"key\":\"45-54\"},{\"doc_count\":5680,\"doc_percent\":0.07189146,\"key\":\"18-24\"},{\"doc_count\":4503,\"doc_percent\":0.05699423,\"key\":\"UNKNOWN\"},{\"doc_count\":2675,\"doc_percent\":0.03385733,\"key\":\"55-64\"}],\"city\":[{\"doc_count\":13194,\"doc_percent\":0.16699575,\"key\":\"BJ\"},{\"doc_count\":5154,\"doc_percent\":0.0652339,\"key\":\"FZ21\"},{\"doc_count\":4267,\"doc_percent\":0.054007187,\"key\":\"XM\"},{\"doc_count\":4217,\"doc_percent\":0.053374343,\"key\":\"SH\"},{\"doc_count\":2880,\"doc_percent\":0.036452007,\"key\":\"\"},{\"doc_count\":2224,\"doc_percent\":0.028149048,\"key\":\"SZ14\"},{\"doc_count\":1679,\"doc_percent\":0.021251012,\"key\":\"QZ212\"},{\"doc_count\":1624,\"doc_percent\":0.02055488,\"key\":\"GZ31\"},{\"doc_count\":1465,\"doc_percent\":0.018542426,\"key\":\"SM121\"},{\"doc_count\":1434,\"doc_percent\":0.018150061,\"key\":\"HZ211\"},{\"doc_count\":1212,\"doc_percent\":0.015340218,\"key\":\"NJ21\"},{\"doc_count\":1023,\"doc_percent\":0.012948056,\"key\":\"SZ21\"},{\"doc_count\":1021,\"doc_percent\":0.012922742,\"key\":\"TZ41\"},{\"doc_count\":908,\"doc_percent\":0.0114925075,\"key\":\"TJ\"},{\"doc_count\":894,\"doc_percent\":0.011315309,\"key\":\"ZZ111\"},{\"doc_count\":865,\"doc_percent\":0.010948258,\"key\":\"HEB\"},{\"doc_count\":857,\"doc_percent\":0.010847003,\"key\":\"SZ11\"},{\"doc_count\":848,\"doc_percent\":0.01073309,\"key\":\"WH34\"},{\"doc_count\":731,\"doc_percent\":0.009252228,\"key\":\"CS\"},{\"doc_count\":721,\"doc_percent\":0.009125658,\"key\":\"LZ211\"},{\"doc_count\":685,\"doc_percent\":0.008670008,\"key\":\"LY222\"},{\"doc_count\":684,\"doc_percent\":0.008657351,\"key\":\"ND\"},{\"doc_count\":671,\"doc_percent\":0.008492811,\"key\":\"ZZ41\"},{\"doc_count\":661,\"doc_percent\":0.008366241,\"key\":\"CD1\"},{\"doc_count\":653,\"doc_percent\":0.008264986,\"key\":\"CQ\"},{\"doc_count\":619,\"doc_percent\":0.00783465,\"key\":\"NP\"},{\"doc_count\":596,\"doc_percent\":0.00754354,\"key\":\"HF\"},{\"doc_count\":589,\"doc_percent\":0.007454941,\"key\":\"PT\"},{\"doc_count\":584,\"doc_percent\":0.0073916567,\"key\":\"NC212\"},{\"doc_count\":559,\"doc_percent\":0.007075233,\"key\":\"JN321\"},{\"doc_count\":559,\"doc_percent\":0.007075233,\"key\":\"NB\"},{\"doc_count\":534,\"doc_percent\":0.006758809,\"key\":\"QD\"},{\"doc_count\":531,\"doc_percent\":0.0067208386,\"key\":\"DG\"},{\"doc_count\":520,\"doc_percent\":0.006581612,\"key\":\"SJZ\"},{\"doc_count\":489,\"doc_percent\":0.0061892467,\"key\":\"XA\"},{\"doc_count\":465,\"doc_percent\":0.00588548,\"key\":\"FS21\"},{\"doc_count\":465,\"doc_percent\":0.00588548,\"key\":\"SZ412\"},{\"doc_count\":465,\"doc_percent\":0.00588548,\"key\":\"WX\"},{\"doc_count\":462,\"doc_percent\":0.005847509,\"key\":\"SY32\"},{\"doc_count\":460,\"doc_percent\":0.005822195,\"key\":\"SX312\"},{\"doc_count\":390,\"doc_percent\":0.004936209,\"key\":\"JX112\"},{\"doc_count\":372,\"doc_percent\":0.004708384,\"key\":\"WZ11\"},{\"doc_count\":356,\"doc_percent\":0.0045058727,\"key\":\"LA\"},{\"doc_count\":338,\"doc_percent\":0.004278048,\"key\":\"TZ\"},{\"doc_count\":330,\"doc_percent\":0.004176792,\"key\":\"HN232\"},{\"doc_count\":317,\"doc_percent\":0.0040122517,\"key\":\"NN\"},{\"doc_count\":305,\"doc_percent\":0.0038603686,\"key\":\"GA31\"},{\"doc_count\":291,\"doc_percent\":0.0036831712,\"key\":\"CC\"},{\"doc_count\":291,\"doc_percent\":0.0036831712,\"key\":\"TY\"},{\"doc_count\":276,\"doc_percent\":0.0034933172,\"key\":\"DL\"},{\"doc_count\":267,\"doc_percent\":0.0033794045,\"key\":\"JH\"},{\"doc_count\":258,\"doc_percent\":0.0032654922,\"key\":\"FZ3\"},{\"doc_count\":244,\"doc_percent\":0.0030882948,\"key\":\"CZ211\"},{\"doc_count\":243,\"doc_percent\":0.0030756379,\"key\":\"YT122\"},{\"doc_count\":236,\"doc_percent\":0.0029870393,\"key\":\"TS21\"},{\"doc_count\":235,\"doc_percent\":0.0029743824,\"key\":\"GZ41\"},{\"doc_count\":234,\"doc_percent\":0.0029617255,\"key\":\"WF\"},{\"doc_count\":231,\"doc_percent\":0.0029237545,\"key\":\"NT\"},{\"doc_count\":223,\"doc_percent\":0.002822499,\"key\":\"XZ21\"},{\"doc_count\":221,\"doc_percent\":0.0027971852,\"key\":\"BD\"},{\"doc_count\":215,\"doc_percent\":0.0027212433,\"key\":\"KM\"},{\"doc_count\":215,\"doc_percent\":0.0027212433,\"key\":\"LF23\"},{\"doc_count\":213,\"doc_percent\":0.0026959295,\"key\":\"ZS112\"},{\"doc_count\":211,\"doc_percent\":0.0026706157,\"key\":\"HY221\"},{\"doc_count\":200,\"doc_percent\":0.0025313892,\"key\":\"CZ1\"},{\"doc_count\":195,\"doc_percent\":0.0024681045,\"key\":\"HZ411\"},{\"doc_count\":192,\"doc_percent\":0.0024301338,\"key\":\"YZ21\"},{\"doc_count\":191,\"doc_percent\":0.0024174766,\"key\":\"LZ213\"},{\"doc_count\":187,\"doc_percent\":0.002366849,\"key\":\"ZJ411\"},{\"doc_count\":186,\"doc_percent\":0.002354192,\"key\":\"HHHT\"},{\"doc_count\":182,\"doc_percent\":0.0023035642,\"key\":\"JL22\"},{\"doc_count\":179,\"doc_percent\":0.0022655933,\"key\":\"AS11\"},{\"doc_count\":178,\"doc_percent\":0.0022529364,\"key\":\"LY224\"},{\"doc_count\":170,\"doc_percent\":0.0021516809,\"key\":\"JN322\"},{\"doc_count\":170,\"doc_percent\":0.0021516809,\"key\":\"SQ41\"},{\"doc_count\":164,\"doc_percent\":0.0020757392,\"key\":\"YBCX\"},{\"doc_count\":159,\"doc_percent\":0.0020124544,\"key\":\"GY421\"},{\"doc_count\":154,\"doc_percent\":0.0019491697,\"key\":\"WH22\"},{\"doc_count\":152,\"doc_percent\":0.0019238559,\"key\":\"HK33\"},{\"doc_count\":150,\"doc_percent\":0.0018985419,\"key\":\"ST\"},{\"doc_count\":148,\"doc_percent\":0.001873228,\"key\":\"HD21\"},{\"doc_count\":141,\"doc_percent\":0.0017846294,\"key\":\"LY42\"},{\"doc_count\":139,\"doc_percent\":0.0017593155,\"key\":\"WH132\"},{\"doc_count\":135,\"doc_percent\":0.0017086877,\"key\":\"QHD\"},{\"doc_count\":134,\"doc_percent\":0.0016960307,\"key\":\"HA223\"},{\"doc_count\":134,\"doc_percent\":0.0016960307,\"key\":\"JM122\"},{\"doc_count\":133,\"doc_percent\":0.0016833738,\"key\":\"GL\"},{\"doc_count\":132,\"doc_percent\":0.0016707169,\"key\":\"ZH\"},{\"doc_count\":125,\"doc_percent\":0.0015821182,\"key\":\"DY12\"},{\"doc_count\":122,\"doc_percent\":0.0015441474,\"key\":\"WLMQ\"},{\"doc_count\":122,\"doc_percent\":0.0015441474,\"key\":\"XX\"},{\"doc_count\":121,\"doc_percent\":0.0015314905,\"key\":\"SG\"},{\"doc_count\":121,\"doc_percent\":0.0015314905,\"key\":\"ZB\"},{\"doc_count\":119,\"doc_percent\":0.0015061765,\"key\":\"YC22\"},{\"doc_count\":118,\"doc_percent\":0.0014935196,\"key\":\"XY122\"},{\"doc_count\":116,\"doc_percent\":0.0014682057,\"key\":\"MAS\"},{\"doc_count\":115,\"doc_percent\":0.0014555488,\"key\":\"XT22\"},{\"doc_count\":109,\"doc_percent\":0.0013796071,\"key\":\"YL4\"},{\"doc_count\":108,\"doc_percent\":0.0013669502,\"key\":\"ZQ\"},{\"doc_count\":104,\"doc_percent\":0.0013163224,\"key\":\"DQ\"}],\"createtime\":0,\"device\":[{\"doc_count\":58525,\"doc_percent\":0.74074775,\"key\":\"PC\"},{\"doc_count\":17631,\"doc_percent\":0.22315462,\"key\":\"Mobile\"},{\"doc_count\":2066,\"doc_percent\":0.02614925,\"key\":\"Tablet\"},{\"doc_count\":786,\"doc_percent\":0.00994836,\"key\":\"UNKNOWN\"}],\"gender\":[{\"doc_count\":47354,\"doc_percent\":0.599357,\"key\":\"m\"},{\"doc_count\":18212,\"doc_percent\":0.2305083,\"key\":\"UNKNOWN\"},{\"doc_count\":13442,\"doc_percent\":0.17013466,\"key\":\"f\"}],\"interest\":[{\"doc_count\":73362,\"doc_percent\":0.92853886,\"en_name\":\"Health
        // &
        // Wellness\",\"key\":\"15\",\"zh_cn_name\":\"健康医疗\"},{\"doc_count\":73362,\"doc_percent\":0.92853886,\"en_name\":\"Home
        // &
        // Lifestyle\",\"key\":\"27\",\"zh_cn_name\":\"家居生活\"},{\"doc_count\":72600,\"doc_percent\":0.9188943,\"en_name\":\"Arts
        // &
        // Entertainment\",\"key\":\"31\",\"zh_cn_name\":\"娱乐\"},{\"doc_count\":72108,\"doc_percent\":0.9126671,\"en_name\":\"Food
        // &
        // Drink\",\"key\":\"26\",\"zh_cn_name\":\"食品美食\"},{\"doc_count\":67821,\"doc_percent\":0.8584067,\"en_name\":\"Culture\",\"key\":\"11\",\"zh_cn_name\":\"文化艺术\"},{\"doc_count\":67063,\"doc_percent\":0.84881276,\"en_name\":\"Pets\",\"key\":\"2703\",\"zh_cn_name\":\"宠物\"},{\"doc_count\":65325,\"doc_percent\":0.826815,\"en_name\":\"Psychology\",\"key\":\"1501\",\"zh_cn_name\":\"情感心理\"},{\"doc_count\":61415,\"doc_percent\":0.77732635,\"en_name\":\"Restaurants\",\"key\":\"2603\",\"zh_cn_name\":\"餐馆美食\"},{\"doc_count\":58695,\"doc_percent\":0.7428995,\"en_name\":\"Humanities
        // &
        // Arts\",\"key\":\"1104\",\"zh_cn_name\":\"人文艺术\"},{\"doc_count\":57616,\"doc_percent\":0.7292426,\"en_name\":\"Comics
        // &
        // Animation\",\"key\":\"3104\",\"zh_cn_name\":\"动画漫画\"},{\"doc_count\":54057,\"doc_percent\":0.68419653,\"en_name\":\"Jobs
        // &
        // Education\",\"key\":\"12\",\"zh_cn_name\":\"教育培训\"},{\"doc_count\":44940,\"doc_percent\":0.56880313,\"en_name\":\"Leisure
        // Travel & Business
        // Travel\",\"key\":\"25\",\"zh_cn_name\":\"旅游商旅\"},{\"doc_count\":41662,\"doc_percent\":0.5273137,\"en_name\":\"Private
        // School\",\"key\":\"1208\",\"zh_cn_name\":\"私立学校\"},{\"doc_count\":38553,\"doc_percent\":0.48796323,\"en_name\":\"Travel
        // Destination\",\"key\":\"2502\",\"zh_cn_name\":\"旅游目的地\"},{\"doc_count\":37637,\"doc_percent\":0.47636947,\"en_name\":\"Automobiles\",\"key\":\"17\",\"zh_cn_name\":\"汽车\"},{\"doc_count\":36986,\"doc_percent\":0.4681298,\"en_name\":\"Consulting
        // &
        // Services\",\"key\":\"22\",\"zh_cn_name\":\"咨询及服务\"},{\"doc_count\":36835,\"doc_percent\":0.46621862,\"en_name\":\"Overseas
        // Education\",\"key\":\"1202\",\"zh_cn_name\":\"留学移民\"},{\"doc_count\":35562,\"doc_percent\":0.45010632,\"en_name\":\"Furniture
        // Decoration\",\"key\":\"2701\",\"zh_cn_name\":\"家居家装\"},{\"doc_count\":35197,\"doc_percent\":0.44548655,\"en_name\":\"Personal
        // Finance\",\"key\":\"21\",\"zh_cn_name\":\"金融财经\"},{\"doc_count\":34040,\"doc_percent\":0.43084246,\"en_name\":\"Domestic
        // Appliance\",\"key\":\"2702\",\"zh_cn_name\":\"家用电器\"},{\"doc_count\":32160,\"doc_percent\":0.4070474,\"en_name\":\"Wedding
        // Services\",\"key\":\"2201\",\"zh_cn_name\":\"婚庆\"},{\"doc_count\":31140,\"doc_percent\":0.3941373,\"en_name\":\"Healthcare\",\"key\":\"1503\",\"zh_cn_name\":\"保健养生\"},{\"doc_count\":30691,\"doc_percent\":0.38845435,\"en_name\":\"Cosmetic
        // Procedures\",\"key\":\"1502\",\"zh_cn_name\":\"整形整容\"},{\"doc_count\":29753,\"doc_percent\":0.37658212,\"en_name\":\"Variety
        // &
        // Entertainment\",\"key\":\"3101\",\"zh_cn_name\":\"娱乐综艺\"},{\"doc_count\":28776,\"doc_percent\":0.36421627,\"en_name\":\"Overseas
        // Education
        // Application\",\"key\":\"120202\",\"zh_cn_name\":\"留学申请\"},{\"doc_count\":28742,\"doc_percent\":0.36378595,\"en_name\":\"Sports
        // &
        // Fitness\",\"key\":\"18\",\"zh_cn_name\":\"运动健身\"},{\"doc_count\":28283,\"doc_percent\":0.3579764,\"en_name\":\"Primary
        // Middle & High
        // School\",\"key\":\"120803\",\"zh_cn_name\":\"私立中学\"},{\"doc_count\":28095,\"doc_percent\":0.3555969,\"en_name\":\"Pop
        // Music\",\"key\":\"3106\",\"zh_cn_name\":\"流行音乐\"},{\"doc_count\":27810,\"doc_percent\":0.3519897,\"en_name\":\"Car
        // Manufacturer
        // Country\",\"key\":\"1711\",\"zh_cn_name\":\"生产国家\"},{\"doc_count\":27696,\"doc_percent\":0.35054678,\"en_name\":\"Car
        // Type\",\"key\":\"1712\",\"zh_cn_name\":\"车型\"},{\"doc_count\":27408,\"doc_percent\":0.34690157,\"en_name\":\"Beauty
        // &
        // Cosmetics\",\"key\":\"16\",\"zh_cn_name\":\"美容及化妆品\"},{\"doc_count\":27245,\"doc_percent\":0.3448385,\"en_name\":\"Cooking
        // &
        // Recipes\",\"key\":\"2601\",\"zh_cn_name\":\"烹饪和菜谱\"},{\"doc_count\":27102,\"doc_percent\":0.34302855,\"en_name\":\"Japan
        // / Korea (Travel)\",\"key\":\"250203\",\"zh_cn_name\":\"日本 /
        // 韩国旅游\"},{\"doc_count\":27070,\"doc_percent\":0.34262353,\"en_name\":\"Sexual
        // Health\",\"key\":\"1504\",\"zh_cn_name\":\"两性健康\"},{\"doc_count\":25788,\"doc_percent\":0.32639733,\"en_name\":\"Insurance\",\"key\":\"2101\",\"zh_cn_name\":\"保险\"},{\"doc_count\":25590,\"doc_percent\":0.32389125,\"en_name\":\"Baby
        // &
        // Maternity\",\"key\":\"20\",\"zh_cn_name\":\"母婴育儿\"},{\"doc_count\":25483,\"doc_percent\":0.32253695,\"en_name\":\"Maternity
        // &
        // Parenting\",\"key\":\"2001\",\"zh_cn_name\":\"母婴用品\"},{\"doc_count\":25469,\"doc_percent\":0.32235977,\"en_name\":\"Skin
        // Care\",\"key\":\"1601\",\"zh_cn_name\":\"护肤\"},{\"doc_count\":25256,\"doc_percent\":0.31966382,\"en_name\":\"Japan
        // & Korea
        // (Car)\",\"key\":\"171101\",\"zh_cn_name\":\"日本韩国车\"},{\"doc_count\":24970,\"doc_percent\":0.31604394,\"en_name\":\"Private
        // Primary
        // School\",\"key\":\"120802\",\"zh_cn_name\":\"私立小学\"},{\"doc_count\":24723,\"doc_percent\":0.31291768,\"en_name\":\"TV
        // Dramas\",\"key\":\"3103\",\"zh_cn_name\":\"网络影视剧\"},{\"doc_count\":22296,\"doc_percent\":0.28219926,\"en_name\":\"Movies\",\"key\":\"3102\",\"zh_cn_name\":\"院线电影\"},{\"doc_count\":21366,\"doc_percent\":0.2704283,\"en_name\":\"Make-Up/Cosmetics\",\"key\":\"1603\",\"zh_cn_name\":\"彩妆\"},{\"doc_count\":20916,\"doc_percent\":0.2647327,\"en_name\":\"Alcohol\",\"key\":\"30\",\"zh_cn_name\":\"酒类\"},{\"doc_count\":20856,\"doc_percent\":0.26397327,\"en_name\":\"Hotels
        // &
        // Accommodations\",\"key\":\"2501\",\"zh_cn_name\":\"酒店\"},{\"doc_count\":20498,\"doc_percent\":0.2594421,\"en_name\":\"Germany
        // (Car)\",\"key\":\"171102\",\"zh_cn_name\":\"德国车\"},{\"doc_count\":19666,\"doc_percent\":0.2489115,\"en_name\":\"Real
        // Estate &
        // Construction\",\"key\":\"2103\",\"zh_cn_name\":\"房地产及建筑\"},{\"doc_count\":19446,\"doc_percent\":0.24612698,\"en_name\":\"Fresh
        // Food\",\"key\":\"2605\",\"zh_cn_name\":\"生鲜食品\"},{\"doc_count\":19128,\"doc_percent\":0.24210207,\"en_name\":\"Female
        // Fashion\",\"key\":\"24\",\"zh_cn_name\":\"时尚\"},{\"doc_count\":19013,\"doc_percent\":0.24064651,\"en_name\":\"Healthy
        // Food\",\"key\":\"2604\",\"zh_cn_name\":\"保健食品\"},{\"doc_count\":18387,\"doc_percent\":0.23272327,\"en_name\":\"Culture/Literature\",\"key\":\"1102\",\"zh_cn_name\":\"文化文学\"},{\"doc_count\":16587,\"doc_percent\":0.20994076,\"en_name\":\"Investing\",\"key\":\"2102\",\"zh_cn_name\":\"投资理财\"},{\"doc_count\":16109,\"doc_percent\":0.20389074,\"en_name\":\"Sports
        // Events\",\"key\":\"1803\",\"zh_cn_name\":\"体育赛事\"},{\"doc_count\":15385,\"doc_percent\":0.19472712,\"en_name\":\"Wine\",\"key\":\"3002\",\"zh_cn_name\":\"葡萄酒\"},{\"doc_count\":14532,\"doc_percent\":0.18393074,\"en_name\":\"Clothing\",\"key\":\"2401\",\"zh_cn_name\":\"服装\"},{\"doc_count\":14398,\"doc_percent\":0.1822347,\"en_name\":\"Australia
        // & New Zealand (Travel)\",\"key\":\"250206\",\"zh_cn_name\":\"大洋洲旅游
        // （澳洲 &
        // 新西兰）\"},{\"doc_count\":14388,\"doc_percent\":0.18210813,\"en_name\":\"Fitness\",\"key\":\"1801\",\"zh_cn_name\":\"健身\"},{\"doc_count\":14225,\"doc_percent\":0.18004505,\"en_name\":\"MPV\",\"key\":\"171208\",\"zh_cn_name\":\"多功能车\"},{\"doc_count\":14047,\"doc_percent\":0.17779212,\"en_name\":\"Overseas
        // Education
        // Destination\",\"key\":\"120203\",\"zh_cn_name\":\"留学移民国家\"},{\"doc_count\":13717,\"doc_percent\":0.17361534,\"en_name\":\"Hydration\",\"key\":\"160102\",\"zh_cn_name\":\"补水保湿\"},{\"doc_count\":12939,\"doc_percent\":0.16376823,\"en_name\":\"Baby
        // Feeding\",\"key\":\"200102\",\"zh_cn_name\":\"喂养用品\"},{\"doc_count\":12811,\"doc_percent\":0.16214813,\"en_name\":\"Mother's
        // Goods\",\"key\":\"200105\",\"zh_cn_name\":\"妈妈用品\"},{\"doc_count\":12702,\"doc_percent\":0.16076852,\"en_name\":\"Outdoor
        // Sports\",\"key\":\"1802\",\"zh_cn_name\":\"户外\"},{\"doc_count\":12125,\"doc_percent\":0.15346546,\"en_name\":\"SUV\",\"key\":\"171204\",\"zh_cn_name\":\"越野车\"},{\"doc_count\":11838,\"doc_percent\":0.14983293,\"en_name\":\"Luxury
        // Hotel\",\"key\":\"250101\",\"zh_cn_name\":\"奢华酒店\"},{\"doc_count\":11773,\"doc_percent\":0.14901023,\"en_name\":\"Bodycare\",\"key\":\"160110\",\"zh_cn_name\":\"身体护肤\"},{\"doc_count\":11643,\"doc_percent\":0.14736483,\"en_name\":\"Private
        // Kindergarten\",\"key\":\"120801\",\"zh_cn_name\":\"私立幼儿园\"},{\"doc_count\":11628,\"doc_percent\":0.14717497,\"en_name\":\"Real
        // Estate\",\"key\":\"210304\",\"zh_cn_name\":\"楼盘\"},{\"doc_count\":11618,\"doc_percent\":0.1470484,\"en_name\":\"Nail
        // Color &
        // Handcare\",\"key\":\"160304\",\"zh_cn_name\":\"指甲/手部\"},{\"doc_count\":11417,\"doc_percent\":0.14450435,\"en_name\":\"Hong
        // Kong,Macau and Singapore
        // (Travel)\",\"key\":\"250207\",\"zh_cn_name\":\"港澳游\"},{\"doc_count\":11407,\"doc_percent\":0.14437778,\"en_name\":\"Baby
        // Care\",\"key\":\"200106\",\"zh_cn_name\":\"婴幼护理\"},{\"doc_count\":11290,\"doc_percent\":0.14289692,\"en_name\":\"Country
        // of
        // Origin\",\"key\":\"300207\",\"zh_cn_name\":\"产地\"},{\"doc_count\":11118,\"doc_percent\":0.14071992,\"en_name\":\"Baby
        // Food\",\"key\":\"200104\",\"zh_cn_name\":\"幼儿食品\"},{\"doc_count\":11053,\"doc_percent\":0.13989723,\"en_name\":\"North
        // America
        // (Travel)\",\"key\":\"250201\",\"zh_cn_name\":\"北美旅游\"},{\"doc_count\":11007,\"doc_percent\":0.13931501,\"en_name\":\"Books/Magazines\",\"key\":\"1103\",\"zh_cn_name\":\"书刊杂志\"},{\"doc_count\":10950,\"doc_percent\":0.13859355,\"en_name\":\"Snacks\",\"key\":\"2602\",\"zh_cn_name\":\"休闲食品\"},{\"doc_count\":10936,\"doc_percent\":0.13841636,\"en_name\":\"Eye
        // Makeup\",\"key\":\"160302\",\"zh_cn_name\":\"眼部彩妆\"},{\"doc_count\":10910,\"doc_percent\":0.13808729,\"en_name\":\"Van\",\"key\":\"171206\",\"zh_cn_name\":\"面包车\"},{\"doc_count\":10909,\"doc_percent\":0.13807462,\"en_name\":\"Baby
        // Bedding\",\"key\":\"200109\",\"zh_cn_name\":\"婴儿寝具\"},{\"doc_count\":10585,\"doc_percent\":0.13397378,\"en_name\":\"Asset
        // Management\",\"key\":\"210202\",\"zh_cn_name\":\"投资和资产管理\"},{\"doc_count\":10423,\"doc_percent\":0.13192335,\"en_name\":\"Mid-End
        // Cars\",\"key\":\"1702\",\"zh_cn_name\":\"中档汽车\"},{\"doc_count\":10381,\"doc_percent\":0.13139176,\"en_name\":\"SEA
        // (Travel)\",\"key\":\"250202\",\"zh_cn_name\":\"东南亚旅游\"},{\"doc_count\":10244,\"doc_percent\":0.12965776,\"en_name\":\"China
        // (Car)\",\"key\":\"171104\",\"zh_cn_name\":\"国产车\"},{\"doc_count\":9782,\"doc_percent\":0.12381025,\"en_name\":\"Local
        // Food\",\"key\":\"2606\",\"zh_cn_name\":\"地方特产\"},{\"doc_count\":9707,\"doc_percent\":0.122860976,\"en_name\":\"United
        // States
        // (Car)\",\"key\":\"171103\",\"zh_cn_name\":\"美国车\"},{\"doc_count\":9616,\"doc_percent\":0.12170919,\"en_name\":\"Luxury
        // Cars\",\"key\":\"1710\",\"zh_cn_name\":\"豪华汽车\"},{\"doc_count\":9418,\"doc_percent\":0.11920312,\"en_name\":\"High-End
        // Cars\",\"key\":\"1701\",\"zh_cn_name\":\"高档汽车\"},{\"doc_count\":9249,\"doc_percent\":0.117064096,\"en_name\":\"Property
        // Insurance\",\"key\":\"210103\",\"zh_cn_name\":\"财产保险\"},{\"doc_count\":9134,\"doc_percent\":0.11560854,\"en_name\":\"Europe
        // (Travel)\",\"key\":\"250204\",\"zh_cn_name\":\"欧洲旅游\"},{\"doc_count\":8900,\"doc_percent\":0.11264682,\"en_name\":\"Sedan\",\"key\":\"171201\",\"zh_cn_name\":\"三厢车\"},{\"doc_count\":8732,\"doc_percent\":0.11052045,\"en_name\":\"Coupe\",\"key\":\"171202\",\"zh_cn_name\":\"轿跑车\"},{\"doc_count\":8697,\"doc_percent\":0.11007746,\"en_name\":\"Makeup
        // Tools\",\"key\":\"160305\",\"zh_cn_name\":\"美发护发\"},{\"doc_count\":8641,\"doc_percent\":0.109368674,\"en_name\":\"Real
        // Estate
        // Agencies\",\"key\":\"210302\",\"zh_cn_name\":\"中介代理\"},{\"doc_count\":8595,\"doc_percent\":0.10878645,\"en_name\":\"Hatchback\",\"key\":\"171203\",\"zh_cn_name\":\"两厢车\"},{\"doc_count\":8565,\"doc_percent\":0.108406745,\"en_name\":\"Early
        // Childhood
        // Education\",\"key\":\"1205\",\"zh_cn_name\":\"早教幼教\"},{\"doc_count\":8554,\"doc_percent\":0.108267516,\"en_name\":\"Auto
        // Insurance\",\"key\":\"1708\",\"zh_cn_name\":\"汽车保险\"},{\"doc_count\":8513,\"doc_percent\":0.10774858,\"en_name\":\"Health
        // & Medical
        // Insurance\",\"key\":\"210102\",\"zh_cn_name\":\"健康保险\"},{\"doc_count\":8297,\"doc_percent\":0.10501468,\"en_name\":\"Station
        // Wagon\",\"key\":\"171205\",\"zh_cn_name\":\"旅行车\"},{\"doc_count\":8275,\"doc_percent\":0.10473623,\"en_name\":\"Sports
        // Car\",\"key\":\"171209\",\"zh_cn_name\":\"跑车\"},{\"doc_count\":8007,\"doc_percent\":0.10134417,\"en_name\":\"Baby
        // Formula\",\"key\":\"200103\",\"zh_cn_name\":\"婴幼奶粉\"}],\"province\":[{\"doc_count\":16039,\"doc_percent\":0.20300476,\"key\":\"CN_FJ\"},{\"doc_count\":13194,\"doc_percent\":0.16699575,\"key\":\"CN_BJ\"},{\"doc_count\":6568,\"doc_percent\":0.08313082,\"key\":\"CN_GD\"},{\"doc_count\":5198,\"doc_percent\":0.06579081,\"key\":\"CN_JS\"},{\"doc_count\":4217,\"doc_percent\":0.053374343,\"key\":\"CN_SH\"},{\"doc_count\":4086,\"doc_percent\":0.051716283,\"key\":\"CN_ZJ\"},{\"doc_count\":2958,\"doc_percent\":0.037439246,\"key\":\"CN_SD\"},{\"doc_count\":2593,\"doc_percent\":0.03281946,\"key\":\"CN_AH\"},{\"doc_count\":2466,\"doc_percent\":0.03121203,\"key\":\"CN_HU\"},{\"doc_count\":2136,\"doc_percent\":0.027035236,\"key\":\"CN_SC\"},{\"doc_count\":1993,\"doc_percent\":0.025225293,\"key\":\"CN_HB\"},{\"doc_count\":1801,\"doc_percent\":0.02279516,\"key\":\"CN_HE\"},{\"doc_count\":1537,\"doc_percent\":0.019453727,\"key\":\"CN_LN\"},{\"doc_count\":1482,\"doc_percent\":0.018757595,\"key\":\"CN_HN\"},{\"doc_count\":1479,\"doc_percent\":0.018719623,\"key\":\"CN_JX\"},{\"doc_count\":1407,\"doc_percent\":0.017808324,\"key\":\"CN_HL\"},{\"doc_count\":1006,\"doc_percent\":0.012732888,\"key\":\"CN_GX\"},{\"doc_count\":908,\"doc_percent\":0.0114925075,\"key\":\"CN_TJ\"},{\"doc_count\":827,\"doc_percent\":0.010467295,\"key\":\"CN_JL\"},{\"doc_count\":824,\"doc_percent\":0.010429324,\"key\":\"CN_SA\"},{\"doc_count\":788,\"doc_percent\":0.009973673,\"key\":\"CN_SX\"},{\"doc_count\":653,\"doc_percent\":0.008264986,\"key\":\"CN_CQ\"},{\"doc_count\":597,\"doc_percent\":0.007556197,\"key\":\"CN_NM\"},{\"doc_count\":529,\"doc_percent\":0.0066955243,\"key\":\"CN_YN\"},{\"doc_count\":419,\"doc_percent\":0.0053032604,\"key\":\"CN_IN_US\"},{\"doc_count\":377,\"doc_percent\":0.0047716685,\"key\":\"CN_IN_GB\"},{\"doc_count\":372,\"doc_percent\":0.004708384,\"key\":\"CN_GZ\"},{\"doc_count\":333,\"doc_percent\":0.004214763,\"key\":\"CN_GS\"},{\"doc_count\":279,\"doc_percent\":0.003531288,\"key\":\"HK\"},{\"doc_count\":258,\"doc_percent\":0.0032654922,\"key\":\"CN_XJ\"},{\"doc_count\":250,\"doc_percent\":0.0031642364,\"key\":\"TW\"},{\"doc_count\":230,\"doc_percent\":0.0029110976,\"key\":\"CN_HA\"},{\"doc_count\":135,\"doc_percent\":0.0017086877,\"key\":\"CN_IN_CN\"},{\"doc_count\":112,\"doc_percent\":0.001417578,\"key\":\"CN_IN_SG\"},{\"doc_count\":102,\"doc_percent\":0.0012910085,\"key\":\"CN_UNKNOWN\"},{\"doc_count\":99,\"doc_percent\":0.0012530377,\"key\":\"CN_NX\"},{\"doc_count\":88,\"doc_percent\":0.0011138113,\"key\":\"CN_QH\"},{\"doc_count\":80,\"doc_percent\":0.0010125557,\"key\":\"CN_IN_CA\"},{\"doc_count\":69,\"doc_percent\":8.733293E-4,\"key\":\"CN_IN_MY\"},{\"doc_count\":63,\"doc_percent\":7.973876E-4,\"key\":\"CN_IN_UK\"},{\"doc_count\":57,\"doc_percent\":7.2144595E-4,\"key\":\"CN_IN_AU\"},{\"doc_count\":52,\"doc_percent\":6.581612E-4,\"key\":\"CN_IN_JP\"},{\"doc_count\":44,\"doc_percent\":5.5690564E-4,\"key\":\"CN_IN_KR\"},{\"doc_count\":43,\"doc_percent\":5.442487E-4,\"key\":\"CN_XZ\"},{\"doc_count\":25,\"doc_percent\":3.1642366E-4,\"key\":\"CN_IN_FR\"},{\"doc_count\":24,\"doc_percent\":3.0376672E-4,\"key\":\"CN_IN_NL\"},{\"doc_count\":19,\"doc_percent\":2.4048198E-4,\"key\":\"CN_IN_TH\"},{\"doc_count\":17,\"doc_percent\":2.1516808E-4,\"key\":\"CN_IN_DE\"},{\"doc_count\":17,\"doc_percent\":2.1516808E-4,\"key\":\"MO\"},{\"doc_count\":15,\"doc_percent\":1.898542E-4,\"key\":\"CN_IN_RU\"},{\"doc_count\":11,\"doc_percent\":1.3922641E-4,\"key\":\"CN_IN_VN\"},{\"doc_count\":10,\"doc_percent\":1.2656946E-4,\"key\":\"CN_IN_NZ\"},{\"doc_count\":9,\"doc_percent\":1.13912516E-4,\"key\":\"CN_IN_IT\"},{\"doc_count\":7,\"doc_percent\":8.859862E-5,\"key\":\"CN_IN_ID\"},{\"doc_count\":7,\"doc_percent\":8.859862E-5,\"key\":\"CN_IN_KH\"},{\"doc_count\":7,\"doc_percent\":8.859862E-5,\"key\":\"CN_IN_TR\"},{\"doc_count\":6,\"doc_percent\":7.594168E-5,\"key\":\"CN_IN_AE\"},{\"doc_count\":6,\"doc_percent\":7.594168E-5,\"key\":\"CN_IN_BR\"},{\"doc_count\":6,\"doc_percent\":7.594168E-5,\"key\":\"CN_IN_CH\"},{\"doc_count\":6,\"doc_percent\":7.594168E-5,\"key\":\"CN_IN_PH\"},{\"doc_count\":5,\"doc_percent\":6.328473E-5,\"key\":\"CN_IN_ES\"},{\"doc_count\":3,\"doc_percent\":3.797084E-5,\"key\":\"CN_IN_IE\"},{\"doc_count\":3,\"doc_percent\":3.797084E-5,\"key\":\"CN_IN_IN\"},{\"doc_count\":3,\"doc_percent\":3.797084E-5,\"key\":\"CN_IN_NO\"},{\"doc_count\":3,\"doc_percent\":3.797084E-5,\"key\":\"CN_IN_PK\"},{\"doc_count\":3,\"doc_percent\":3.797084E-5,\"key\":\"CN_IN_VE\"},{\"doc_count\":2,\"doc_percent\":2.5313891E-5,\"key\":\"CN_IN_AZ\"},{\"doc_count\":2,\"doc_percent\":2.5313891E-5,\"key\":\"CN_IN_BD\"},{\"doc_count\":2,\"doc_percent\":2.5313891E-5,\"key\":\"CN_IN_BE\"},{\"doc_count\":2,\"doc_percent\":2.5313891E-5,\"key\":\"CN_IN_FI\"},{\"doc_count\":2,\"doc_percent\":2.5313891E-5,\"key\":\"CN_IN_GR\"},{\"doc_count\":2,\"doc_percent\":2.5313891E-5,\"key\":\"CN_IN_HU\"},{\"doc_count\":2,\"doc_percent\":2.5313891E-5,\"key\":\"CN_IN_LA\"},{\"doc_count\":2,\"doc_percent\":2.5313891E-5,\"key\":\"CN_IN_MX\"},{\"doc_count\":2,\"doc_percent\":2.5313891E-5,\"key\":\"CN_IN_PT\"},{\"doc_count\":2,\"doc_percent\":2.5313891E-5,\"key\":\"CN_IN_RO\"},{\"doc_count\":2,\"doc_percent\":2.5313891E-5,\"key\":\"CN_IN_SA\"},{\"doc_count\":2,\"doc_percent\":2.5313891E-5,\"key\":\"CN_IN_SE\"},{\"doc_count\":2,\"doc_percent\":2.5313891E-5,\"key\":\"CN_IN_SM2\"},{\"doc_count\":2,\"doc_percent\":2.5313891E-5,\"key\":\"CN_IN_TN\"},{\"doc_count\":1,\"doc_percent\":1.2656946E-5,\"key\":\"CN_IN_AR\"},{\"doc_count\":1,\"doc_percent\":1.2656946E-5,\"key\":\"CN_IN_BG\"},{\"doc_count\":1,\"doc_percent\":1.2656946E-5,\"key\":\"CN_IN_BO\"},{\"doc_count\":1,\"doc_percent\":1.2656946E-5,\"key\":\"CN_IN_BZ\"},{\"doc_count\":1,\"doc_percent\":1.2656946E-5,\"key\":\"CN_IN_CZ\"},{\"doc_count\":1,\"doc_percent\":1.2656946E-5,\"key\":\"CN_IN_DO\"},{\"doc_count\":1,\"doc_percent\":1.2656946E-5,\"key\":\"CN_IN_DZ\"},{\"doc_count\":1,\"doc_percent\":1.2656946E-5,\"key\":\"CN_IN_EC\"},{\"doc_count\":1,\"doc_percent\":1.2656946E-5,\"key\":\"CN_IN_IL\"},{\"doc_count\":1,\"doc_percent\":1.2656946E-5,\"key\":\"CN_IN_IQ\"},{\"doc_count\":1,\"doc_percent\":1.2656946E-5,\"key\":\"CN_IN_KZ\"},{\"doc_count\":1,\"doc_percent\":1.2656946E-5,\"key\":\"CN_IN_LK\"},{\"doc_count\":1,\"doc_percent\":1.2656946E-5,\"key\":\"CN_IN_MA\"},{\"doc_count\":1,\"doc_percent\":1.2656946E-5,\"key\":\"CN_IN_ML\"},{\"doc_count\":1,\"doc_percent\":1.2656946E-5,\"key\":\"CN_IN_MM\"},{\"doc_count\":1,\"doc_percent\":1.2656946E-5,\"key\":\"CN_IN_NI\"},{\"doc_count\":1,\"doc_percent\":1.2656946E-5,\"key\":\"CN_IN_PL\"},{\"doc_count\":1,\"doc_percent\":1.2656946E-5,\"key\":\"CN_IN_QA\"},{\"doc_count\":1,\"doc_percent\":1.2656946E-5,\"key\":\"CN_IN_UK4\"},{\"doc_count\":1,\"doc_percent\":1.2656946E-5,\"key\":\"CN_IN_ZA\"}],\"raw_interest\":[{\"doc_count\":63522,\"doc_percent\":0.80399454,\"en_name\":\"Food
        // &
        // Drink\",\"key\":\"26\",\"zh_cn_name\":\"食品美食\"},{\"doc_count\":55223,\"doc_percent\":0.6989545,\"en_name\":\"Restaurants\",\"key\":\"2603\",\"zh_cn_name\":\"餐馆美食\"},{\"doc_count\":43551,\"doc_percent\":0.5512227,\"en_name\":\"Arts
        // &
        // Entertainment\",\"key\":\"31\",\"zh_cn_name\":\"娱乐\"},{\"doc_count\":27303,\"doc_percent\":0.3455726,\"en_name\":\"Variety
        // &
        // Entertainment\",\"key\":\"3101\",\"zh_cn_name\":\"娱乐综艺\"},{\"doc_count\":20356,\"doc_percent\":0.2576448,\"en_name\":\"TV
        // Dramas\",\"key\":\"3103\",\"zh_cn_name\":\"网络影视剧\"},{\"doc_count\":19247,\"doc_percent\":0.24360824,\"en_name\":\"Cooking
        // &
        // Recipes\",\"key\":\"2601\",\"zh_cn_name\":\"烹饪和菜谱\"},{\"doc_count\":18946,\"doc_percent\":0.2397985,\"en_name\":\"Personal
        // Finance\",\"key\":\"21\",\"zh_cn_name\":\"金融财经\"},{\"doc_count\":18901,\"doc_percent\":0.23922893,\"en_name\":\"Pop
        // Music\",\"key\":\"3106\",\"zh_cn_name\":\"流行音乐\"},{\"doc_count\":18320,\"doc_percent\":0.23187526,\"en_name\":\"Health
        // &
        // Wellness\",\"key\":\"15\",\"zh_cn_name\":\"健康医疗\"},{\"doc_count\":17470,\"doc_percent\":0.22111686,\"en_name\":\"Leisure
        // Travel & Business
        // Travel\",\"key\":\"25\",\"zh_cn_name\":\"旅游商旅\"},{\"doc_count\":16020,\"doc_percent\":0.20276427,\"en_name\":\"Jobs
        // &
        // Education\",\"key\":\"12\",\"zh_cn_name\":\"教育培训\"},{\"doc_count\":15537,\"doc_percent\":0.19665097,\"en_name\":\"Automobiles\",\"key\":\"17\",\"zh_cn_name\":\"汽车\"},{\"doc_count\":12489,\"doc_percent\":0.1580726,\"en_name\":\"Car
        // Type\",\"key\":\"1712\",\"zh_cn_name\":\"车型\"},{\"doc_count\":12481,\"doc_percent\":0.15797134,\"en_name\":\"Investing\",\"key\":\"2102\",\"zh_cn_name\":\"投资理财\"},{\"doc_count\":11793,\"doc_percent\":0.14926337,\"en_name\":\"Travel
        // Destination\",\"key\":\"2502\",\"zh_cn_name\":\"旅游目的地\"},{\"doc_count\":10809,\"doc_percent\":0.13680893,\"en_name\":\"Female
        // Fashion\",\"key\":\"24\",\"zh_cn_name\":\"时尚\"},{\"doc_count\":10029,\"doc_percent\":0.12693651,\"en_name\":\"Culture\",\"key\":\"11\",\"zh_cn_name\":\"文化艺术\"},{\"doc_count\":10018,\"doc_percent\":0.12679729,\"en_name\":\"Sports
        // &
        // Fitness\",\"key\":\"18\",\"zh_cn_name\":\"运动健身\"},{\"doc_count\":9965,\"doc_percent\":0.12612647,\"en_name\":\"Fresh
        // Food\",\"key\":\"2605\",\"zh_cn_name\":\"生鲜食品\"},{\"doc_count\":9678,\"doc_percent\":0.12249392,\"en_name\":\"Overseas
        // Education\",\"key\":\"1202\",\"zh_cn_name\":\"留学移民\"},{\"doc_count\":9479,\"doc_percent\":0.119975194,\"en_name\":\"Movies\",\"key\":\"3102\",\"zh_cn_name\":\"院线电影\"},{\"doc_count\":9350,\"doc_percent\":0.118342444,\"en_name\":\"Home
        // &
        // Lifestyle\",\"key\":\"27\",\"zh_cn_name\":\"家居生活\"},{\"doc_count\":8726,\"doc_percent\":0.11044451,\"en_name\":\"Real
        // Estate &
        // Construction\",\"key\":\"2103\",\"zh_cn_name\":\"房地产及建筑\"},{\"doc_count\":8486,\"doc_percent\":0.10740685,\"en_name\":\"Psychology\",\"key\":\"1501\",\"zh_cn_name\":\"情感心理\"},{\"doc_count\":7539,\"doc_percent\":0.09542072,\"en_name\":\"Hotels
        // &
        // Accommodations\",\"key\":\"2501\",\"zh_cn_name\":\"酒店\"},{\"doc_count\":7186,\"doc_percent\":0.09095281,\"en_name\":\"Van\",\"key\":\"171206\",\"zh_cn_name\":\"面包车\"},{\"doc_count\":7143,\"doc_percent\":0.09040856,\"en_name\":\"Asset
        // Management\",\"key\":\"210202\",\"zh_cn_name\":\"投资和资产管理\"},{\"doc_count\":7023,\"doc_percent\":0.08888973,\"en_name\":\"Sports
        // Events\",\"key\":\"1803\",\"zh_cn_name\":\"体育赛事\"},{\"doc_count\":6885,\"doc_percent\":0.08714307,\"en_name\":\"Culture/Literature\",\"key\":\"1102\",\"zh_cn_name\":\"文化文学\"},{\"doc_count\":6602,\"doc_percent\":0.08356116,\"en_name\":\"Overseas
        // Education
        // Destination\",\"key\":\"120203\",\"zh_cn_name\":\"留学移民国家\"},{\"doc_count\":6386,\"doc_percent\":0.08082726,\"en_name\":\"Private
        // School\",\"key\":\"1208\",\"zh_cn_name\":\"私立学校\"},{\"doc_count\":6351,\"doc_percent\":0.08038426,\"en_name\":\"Consulting
        // &
        // Services\",\"key\":\"22\",\"zh_cn_name\":\"咨询及服务\"},{\"doc_count\":6228,\"doc_percent\":0.07882746,\"en_name\":\"Cosmetic
        // Procedures\",\"key\":\"1502\",\"zh_cn_name\":\"整形整容\"},{\"doc_count\":5945,\"doc_percent\":0.075245544,\"en_name\":\"SUV\",\"key\":\"171204\",\"zh_cn_name\":\"越野车\"},{\"doc_count\":5853,\"doc_percent\":0.07408111,\"en_name\":\"Car
        // Manufacturer
        // Country\",\"key\":\"1711\",\"zh_cn_name\":\"生产国家\"},{\"doc_count\":5613,\"doc_percent\":0.07104344,\"en_name\":\"Clothing\",\"key\":\"2401\",\"zh_cn_name\":\"服装\"},{\"doc_count\":5511,\"doc_percent\":0.06975243,\"en_name\":\"Furniture
        // Decoration\",\"key\":\"2701\",\"zh_cn_name\":\"家居家装\"},{\"doc_count\":5289,\"doc_percent\":0.06694259,\"en_name\":\"Personal
        // Loan &
        // Mortgage\",\"key\":\"210201\",\"zh_cn_name\":\"个人贷款\"},{\"doc_count\":5247,\"doc_percent\":0.066410996,\"en_name\":\"Sexual
        // Health\",\"key\":\"1504\",\"zh_cn_name\":\"两性健康\"},{\"doc_count\":5069,\"doc_percent\":0.06415806,\"en_name\":\"Fitness\",\"key\":\"1801\",\"zh_cn_name\":\"健身\"},{\"doc_count\":4773,\"doc_percent\":0.060411602,\"en_name\":\"Healthcare\",\"key\":\"1503\",\"zh_cn_name\":\"保健养生\"},{\"doc_count\":4706,\"doc_percent\":0.05956359,\"en_name\":\"Beauty
        // &
        // Cosmetics\",\"key\":\"16\",\"zh_cn_name\":\"美容及化妆品\"},{\"doc_count\":4699,\"doc_percent\":0.05947499,\"en_name\":\"Early
        // Childhood
        // Education\",\"key\":\"1205\",\"zh_cn_name\":\"早教幼教\"},{\"doc_count\":4599,\"doc_percent\":0.058209296,\"en_name\":\"Hong
        // Kong,Macau and Singapore
        // (Travel)\",\"key\":\"250207\",\"zh_cn_name\":\"港澳游\"},{\"doc_count\":4597,\"doc_percent\":0.058183983,\"en_name\":\"Shoes
        // &
        // Bags\",\"key\":\"2404\",\"zh_cn_name\":\"鞋包\"},{\"doc_count\":4483,\"doc_percent\":0.05674109,\"en_name\":\"Designers
        // &
        // Collections\",\"key\":\"2403\",\"zh_cn_name\":\"奢侈品\"},{\"doc_count\":4413,\"doc_percent\":0.055855103,\"en_name\":\"Drinks\",\"key\":\"2607\",\"zh_cn_name\":\"饮料\"},{\"doc_count\":4388,\"doc_percent\":0.05553868,\"en_name\":\"Primary
        // Middle & High
        // School\",\"key\":\"120803\",\"zh_cn_name\":\"私立中学\"},{\"doc_count\":4356,\"doc_percent\":0.055133656,\"en_name\":\"Japan
        // / Korea (Travel)\",\"key\":\"250203\",\"zh_cn_name\":\"日本 /
        // 韩国旅游\"},{\"doc_count\":4249,\"doc_percent\":0.053779364,\"en_name\":\"High-end
        // Hotel\",\"key\":\"250102\",\"zh_cn_name\":\"高级酒店\"},{\"doc_count\":3966,\"doc_percent\":0.05019745,\"en_name\":\"Wedding
        // Services\",\"key\":\"2201\",\"zh_cn_name\":\"婚庆\"},{\"doc_count\":3689,\"doc_percent\":0.046691474,\"en_name\":\"Baby
        // &
        // Maternity\",\"key\":\"20\",\"zh_cn_name\":\"母婴育儿\"},{\"doc_count\":3589,\"doc_percent\":0.04542578,\"en_name\":\"Skin
        // Care\",\"key\":\"1601\",\"zh_cn_name\":\"护肤\"},{\"doc_count\":3544,\"doc_percent\":0.044856217,\"en_name\":\"Snacks\",\"key\":\"2602\",\"zh_cn_name\":\"休闲食品\"},{\"doc_count\":3439,\"doc_percent\":0.043527238,\"en_name\":\"Maternity
        // &
        // Parenting\",\"key\":\"2001\",\"zh_cn_name\":\"母婴用品\"},{\"doc_count\":3186,\"doc_percent\":0.04032503,\"en_name\":\"Japan
        // & Korea
        // (Education)\",\"key\":\"12020304\",\"zh_cn_name\":\"留学移民日韩\"},{\"doc_count\":3119,\"doc_percent\":0.039477017,\"en_name\":\"Luxury
        // Cars\",\"key\":\"1710\",\"zh_cn_name\":\"豪华汽车\"},{\"doc_count\":3099,\"doc_percent\":0.039223876,\"en_name\":\"Comics
        // &
        // Animation\",\"key\":\"3104\",\"zh_cn_name\":\"动画漫画\"},{\"doc_count\":3094,\"doc_percent\":0.03916059,\"en_name\":\"Germany
        // (Car)\",\"key\":\"171102\",\"zh_cn_name\":\"德国车\"},{\"doc_count\":3036,\"doc_percent\":0.03842649,\"en_name\":\"Australia
        // & New Zealand (Travel)\",\"key\":\"250206\",\"zh_cn_name\":\"大洋洲旅游
        // （澳洲 &
        // 新西兰）\"},{\"doc_count\":2983,\"doc_percent\":0.037755672,\"en_name\":\"Real
        // Estate\",\"key\":\"210304\",\"zh_cn_name\":\"楼盘\"},{\"doc_count\":2887,\"doc_percent\":0.036540605,\"en_name\":\"Hong
        // Kong,Macau and Singapore
        // (Education)\",\"key\":\"12020305\",\"zh_cn_name\":\"留学移民港澳新\"},{\"doc_count\":2847,\"doc_percent\":0.036034327,\"en_name\":\"High-End
        // Cars\",\"key\":\"1701\",\"zh_cn_name\":\"高档汽车\"},{\"doc_count\":2831,\"doc_percent\":0.035831813,\"en_name\":\"Property
        // Management\",\"key\":\"210303\",\"zh_cn_name\":\"物业管理\"},{\"doc_count\":2822,\"doc_percent\":0.0357179,\"en_name\":\"Pets\",\"key\":\"2703\",\"zh_cn_name\":\"宠物\"},{\"doc_count\":2792,\"doc_percent\":0.035338193,\"en_name\":\"Mid-End
        // Cars\",\"key\":\"1702\",\"zh_cn_name\":\"中档汽车\"},{\"doc_count\":2785,\"doc_percent\":0.035249595,\"en_name\":\"Real
        // Estate
        // Agencies\",\"key\":\"210302\",\"zh_cn_name\":\"中介代理\"},{\"doc_count\":2751,\"doc_percent\":0.03481926,\"en_name\":\"Make-Up/Cosmetics\",\"key\":\"1603\",\"zh_cn_name\":\"彩妆\"},{\"doc_count\":2718,\"doc_percent\":0.03440158,\"en_name\":\"Entry-Level
        // Cars\",\"key\":\"1703\",\"zh_cn_name\":\"入门级汽车\"},{\"doc_count\":2687,\"doc_percent\":0.034009214,\"en_name\":\"Humanities
        // &
        // Arts\",\"key\":\"1104\",\"zh_cn_name\":\"人文艺术\"},{\"doc_count\":2458,\"doc_percent\":0.031110773,\"en_name\":\"Japan
        // & Korea
        // (Car)\",\"key\":\"171101\",\"zh_cn_name\":\"日本韩国车\"},{\"doc_count\":2452,\"doc_percent\":0.031034833,\"en_name\":\"Alcohol\",\"key\":\"30\",\"zh_cn_name\":\"酒类\"},{\"doc_count\":2396,\"doc_percent\":0.030326042,\"en_name\":\"United
        // States
        // (Car)\",\"key\":\"171103\",\"zh_cn_name\":\"美国车\"},{\"doc_count\":2391,\"doc_percent\":0.030262759,\"en_name\":\"Private
        // Primary
        // School\",\"key\":\"120802\",\"zh_cn_name\":\"私立小学\"},{\"doc_count\":2357,\"doc_percent\":0.029832423,\"en_name\":\"North
        // America
        // (Travel)\",\"key\":\"250201\",\"zh_cn_name\":\"北美旅游\"},{\"doc_count\":2303,\"doc_percent\":0.029148947,\"en_name\":\"Insurance\",\"key\":\"2101\",\"zh_cn_name\":\"保险\"},{\"doc_count\":2239,\"doc_percent\":0.028338902,\"en_name\":\"Careers\",\"key\":\"2202\",\"zh_cn_name\":\"招聘求职\"},{\"doc_count\":2153,\"doc_percent\":0.027250405,\"en_name\":\"Domestic
        // Appliance\",\"key\":\"2702\",\"zh_cn_name\":\"家用电器\"},{\"doc_count\":2150,\"doc_percent\":0.027212434,\"en_name\":\"Sedan\",\"key\":\"171201\",\"zh_cn_name\":\"三厢车\"},{\"doc_count\":2093,\"doc_percent\":0.026490988,\"en_name\":\"MPV\",\"key\":\"171208\",\"zh_cn_name\":\"多功能车\"},{\"doc_count\":2041,\"doc_percent\":0.025832826,\"en_name\":\"Retail
        // Banking\",\"key\":\"210204\",\"zh_cn_name\":\"银行零售服务\"},{\"doc_count\":1943,\"doc_percent\":0.024592446,\"en_name\":\"Economy
        // Hotel\",\"key\":\"250104\",\"zh_cn_name\":\"经济型酒店\"},{\"doc_count\":1938,\"doc_percent\":0.024529161,\"en_name\":\"Private
        // Kindergarten\",\"key\":\"120801\",\"zh_cn_name\":\"私立幼儿园\"},{\"doc_count\":1881,\"doc_percent\":0.023807716,\"en_name\":\"Local
        // Food\",\"key\":\"2606\",\"zh_cn_name\":\"地方特产\"},{\"doc_count\":1879,\"doc_percent\":0.023782402,\"en_name\":\"SEA
        // (Travel)\",\"key\":\"250202\",\"zh_cn_name\":\"东南亚旅游\"},{\"doc_count\":1843,\"doc_percent\":0.02332675,\"en_name\":\"Online
        // Literature\",\"key\":\"1101\",\"zh_cn_name\":\"网络小说\"},{\"doc_count\":1843,\"doc_percent\":0.02332675,\"en_name\":\"China
        // (Car)\",\"key\":\"171104\",\"zh_cn_name\":\"国产车\"},{\"doc_count\":1817,\"doc_percent\":0.022997672,\"en_name\":\"Credit
        // Card\",\"key\":\"210203\",\"zh_cn_name\":\"信用卡\"},{\"doc_count\":1802,\"doc_percent\":0.022807816,\"en_name\":\"Used
        // Cars\",\"key\":\"1705\",\"zh_cn_name\":\"二手车\"},{\"doc_count\":1656,\"doc_percent\":0.020959903,\"en_name\":\"Jewelry/Accessories\",\"key\":\"2402\",\"zh_cn_name\":\"首饰饰品\"},{\"doc_count\":1647,\"doc_percent\":0.02084599,\"en_name\":\"Property
        // Development\",\"key\":\"210301\",\"zh_cn_name\":\"开发商\"},{\"doc_count\":1640,\"doc_percent\":0.020757392,\"en_name\":\"Australia
        // & New Zealand
        // (Education)\",\"key\":\"12020303\",\"zh_cn_name\":\"留学移民澳洲\"},{\"doc_count\":1629,\"doc_percent\":0.020618165,\"en_name\":\"Vacation
        // Rental\",\"key\":\"250105\",\"zh_cn_name\":\"度假型出租\"},{\"doc_count\":1602,\"doc_percent\":0.020276427,\"en_name\":\"Brightening
        // &
        // Whitening\",\"key\":\"160103\",\"zh_cn_name\":\"美白提亮祛斑\"},{\"doc_count\":1492,\"doc_percent\":0.018884163,\"en_name\":\"Makeup
        // Tools\",\"key\":\"160305\",\"zh_cn_name\":\"美发护发\"},{\"doc_count\":1452,\"doc_percent\":0.018377885,\"en_name\":\"Lip
        // Color\",\"key\":\"160303\",\"zh_cn_name\":\"唇部彩妆\"},{\"doc_count\":1450,\"doc_percent\":0.018352572,\"en_name\":\"Acne
        // Removing\",\"key\":\"160107\",\"zh_cn_name\":\"祛痘\"},{\"doc_count\":1371,\"doc_percent\":0.017352672,\"en_name\":\"Vocational
        // & Continuing
        // Education\",\"key\":\"1204\",\"zh_cn_name\":\"职业技能培训\"},{\"doc_count\":1294,\"doc_percent\":0.016378088,\"en_name\":\"Sports
        // Car\",\"key\":\"171209\",\"zh_cn_name\":\"跑车\"},{\"doc_count\":1276,\"doc_percent\":0.016150264,\"en_name\":\"Coupe\",\"key\":\"171202\",\"zh_cn_name\":\"轿跑车\"}],\"total\":79008},\"brand_competitor\":{\"age\":[{\"doc_count\":2110,\"doc_percent\":0.30513376,\"key\":\"18-24\"},{\"doc_count\":1806,\"doc_percent\":0.26117137,\"key\":\"25-34\"},{\"doc_count\":1187,\"doc_percent\":0.17165582,\"key\":\"35-44\"},{\"doc_count\":870,\"doc_percent\":0.12581345,\"key\":\"45-54\"},{\"doc_count\":437,\"doc_percent\":0.06319595,\"key\":\"0-17\"},{\"doc_count\":279,\"doc_percent\":0.040347073,\"key\":\"UNKNOWN\"},{\"doc_count\":226,\"doc_percent\":0.032682575,\"key\":\"55-64\"}],\"city\":[{\"doc_count\":1884,\"doc_percent\":0.2724512,\"key\":\"BJ\"},{\"doc_count\":521,\"doc_percent\":0.07534346,\"key\":\"SH\"},{\"doc_count\":391,\"doc_percent\":0.056543745,\"key\":\"\"},{\"doc_count\":281,\"doc_percent\":0.040636297,\"key\":\"GZ31\"},{\"doc_count\":216,\"doc_percent\":0.031236442,\"key\":\"SZ14\"},{\"doc_count\":210,\"doc_percent\":0.030368764,\"key\":\"HZ211\"},{\"doc_count\":184,\"doc_percent\":0.026608821,\"key\":\"NJ21\"},{\"doc_count\":132,\"doc_percent\":0.019088937,\"key\":\"WH34\"},{\"doc_count\":128,\"doc_percent\":0.018510485,\"key\":\"FZ21\"},{\"doc_count\":111,\"doc_percent\":0.01605206,\"key\":\"CD1\"},{\"doc_count\":107,\"doc_percent\":0.015473608,\"key\":\"SZ11\"},{\"doc_count\":106,\"doc_percent\":0.015328995,\"key\":\"TJ\"},{\"doc_count\":88,\"doc_percent\":0.012725958,\"key\":\"XM\"},{\"doc_count\":77,\"doc_percent\":0.011135213,\"key\":\"NC212\"},{\"doc_count\":74,\"doc_percent\":0.010701374,\"key\":\"JN321\"},{\"doc_count\":66,\"doc_percent\":0.0095444685,\"key\":\"SY32\"},{\"doc_count\":65,\"doc_percent\":0.0093998555,\"key\":\"CQ\"},{\"doc_count\":65,\"doc_percent\":0.0093998555,\"key\":\"CS\"},{\"doc_count\":54,\"doc_percent\":0.0078091105,\"key\":\"FS21\"},{\"doc_count\":54,\"doc_percent\":0.0078091105,\"key\":\"QD\"},{\"doc_count\":54,\"doc_percent\":0.0078091105,\"key\":\"ZZ41\"},{\"doc_count\":52,\"doc_percent\":0.0075198845,\"key\":\"SJZ\"},{\"doc_count\":50,\"doc_percent\":0.007230658,\"key\":\"DG\"},{\"doc_count\":50,\"doc_percent\":0.007230658,\"key\":\"HEB\"},{\"doc_count\":49,\"doc_percent\":0.0070860446,\"key\":\"XA\"},{\"doc_count\":46,\"doc_percent\":0.0066522053,\"key\":\"NB\"},{\"doc_count\":46,\"doc_percent\":0.0066522053,\"key\":\"WX\"},{\"doc_count\":45,\"doc_percent\":0.0065075923,\"key\":\"LA\"},{\"doc_count\":45,\"doc_percent\":0.0065075923,\"key\":\"QZ212\"},{\"doc_count\":44,\"doc_percent\":0.006362979,\"key\":\"FZ3\"},{\"doc_count\":44,\"doc_percent\":0.006362979,\"key\":\"HF\"},{\"doc_count\":44,\"doc_percent\":0.006362979,\"key\":\"NN\"},{\"doc_count\":35,\"doc_percent\":0.0050614607,\"key\":\"CC\"},{\"doc_count\":35,\"doc_percent\":0.0050614607,\"key\":\"HY221\"},{\"doc_count\":33,\"doc_percent\":0.0047722342,\"key\":\"GA31\"},{\"doc_count\":32,\"doc_percent\":0.0046276213,\"key\":\"TY\"},{\"doc_count\":28,\"doc_percent\":0.0040491684,\"key\":\"DL\"},{\"doc_count\":27,\"doc_percent\":0.0039045552,\"key\":\"SX312\"},{\"doc_count\":25,\"doc_percent\":0.003615329,\"key\":\"TZ\"},{\"doc_count\":25,\"doc_percent\":0.003615329,\"key\":\"YBCX\"},{\"doc_count\":23,\"doc_percent\":0.0033261026,\"key\":\"GZ41\"},{\"doc_count\":23,\"doc_percent\":0.0033261026,\"key\":\"LZ213\"},{\"doc_count\":22,\"doc_percent\":0.0031814894,\"key\":\"ST\"},{\"doc_count\":21,\"doc_percent\":0.0030368764,\"key\":\"CZ211\"},{\"doc_count\":21,\"doc_percent\":0.0030368764,\"key\":\"WZ11\"},{\"doc_count\":21,\"doc_percent\":0.0030368764,\"key\":\"ZS112\"},{\"doc_count\":20,\"doc_percent\":0.0028922632,\"key\":\"NT\"},{\"doc_count\":18,\"doc_percent\":0.0026030368,\"key\":\"HK33\"},{\"doc_count\":18,\"doc_percent\":0.0026030368,\"key\":\"JX112\"},{\"doc_count\":18,\"doc_percent\":0.0026030368,\"key\":\"LF23\"},{\"doc_count\":18,\"doc_percent\":0.0026030368,\"key\":\"XY122\"},{\"doc_count\":17,\"doc_percent\":0.0024584236,\"key\":\"JH\"},{\"doc_count\":17,\"doc_percent\":0.0024584236,\"key\":\"KM\"},{\"doc_count\":17,\"doc_percent\":0.0024584236,\"key\":\"TZ41\"},{\"doc_count\":17,\"doc_percent\":0.0024584236,\"key\":\"YZ21\"},{\"doc_count\":16,\"doc_percent\":0.0023138106,\"key\":\"BD\"},{\"doc_count\":16,\"doc_percent\":0.0023138106,\"key\":\"JL22\"},{\"doc_count\":16,\"doc_percent\":0.0023138106,\"key\":\"LY224\"},{\"doc_count\":16,\"doc_percent\":0.0023138106,\"key\":\"XZ21\"},{\"doc_count\":16,\"doc_percent\":0.0023138106,\"key\":\"ZQ\"},{\"doc_count\":15,\"doc_percent\":0.0021691974,\"key\":\"HHHT\"},{\"doc_count\":14,\"doc_percent\":0.0020245842,\"key\":\"GY421\"},{\"doc_count\":14,\"doc_percent\":0.0020245842,\"key\":\"JM122\"},{\"doc_count\":14,\"doc_percent\":0.0020245842,\"key\":\"PT\"},{\"doc_count\":13,\"doc_percent\":0.0018799711,\"key\":\"HA223\"},{\"doc_count\":13,\"doc_percent\":0.0018799711,\"key\":\"UNKNOWN\"},{\"doc_count\":13,\"doc_percent\":0.0018799711,\"key\":\"WF\"},{\"doc_count\":13,\"doc_percent\":0.0018799711,\"key\":\"WLMQ\"},{\"doc_count\":13,\"doc_percent\":0.0018799711,\"key\":\"ZH\"},{\"doc_count\":12,\"doc_percent\":0.0017353579,\"key\":\"GL\"},{\"doc_count\":12,\"doc_percent\":0.0017353579,\"key\":\"HN232\"},{\"doc_count\":12,\"doc_percent\":0.0017353579,\"key\":\"HZ411\"},{\"doc_count\":12,\"doc_percent\":0.0017353579,\"key\":\"SM121\"},{\"doc_count\":12,\"doc_percent\":0.0017353579,\"key\":\"SQ41\"},{\"doc_count\":12,\"doc_percent\":0.0017353579,\"key\":\"WH132\"},{\"doc_count\":12,\"doc_percent\":0.0017353579,\"key\":\"ZJ411\"},{\"doc_count\":11,\"doc_percent\":0.0015907447,\"key\":\"LY42\"},{\"doc_count\":11,\"doc_percent\":0.0015907447,\"key\":\"XX\"},{\"doc_count\":10,\"doc_percent\":0.0014461316,\"key\":\"CD222\"},{\"doc_count\":10,\"doc_percent\":0.0014461316,\"key\":\"CZ1\"},{\"doc_count\":10,\"doc_percent\":0.0014461316,\"key\":\"LS43\"},{\"doc_count\":10,\"doc_percent\":0.0014461316,\"key\":\"ND\"},{\"doc_count\":10,\"doc_percent\":0.0014461316,\"key\":\"SZ21\"},{\"doc_count\":10,\"doc_percent\":0.0014461316,\"key\":\"ZB\"},{\"doc_count\":10,\"doc_percent\":0.0014461316,\"key\":\"ZJ412\"},{\"doc_count\":10,\"doc_percent\":0.0014461316,\"key\":\"ZZ111\"},{\"doc_count\":9,\"doc_percent\":0.0013015184,\"key\":\"HD21\"},{\"doc_count\":9,\"doc_percent\":0.0013015184,\"key\":\"HZ212\"},{\"doc_count\":9,\"doc_percent\":0.0013015184,\"key\":\"LYG\"},{\"doc_count\":9,\"doc_percent\":0.0013015184,\"key\":\"LZ31\"},{\"doc_count\":9,\"doc_percent\":0.0013015184,\"key\":\"QHD\"},{\"doc_count\":9,\"doc_percent\":0.0013015184,\"key\":\"YX\"},{\"doc_count\":9,\"doc_percent\":0.0013015184,\"key\":\"ZS111\"},{\"doc_count\":8,\"doc_percent\":0.0011569053,\"key\":\"DQ\"},{\"doc_count\":8,\"doc_percent\":0.0011569053,\"key\":\"FS34\"},{\"doc_count\":8,\"doc_percent\":0.0011569053,\"key\":\"JJ\"},{\"doc_count\":8,\"doc_percent\":0.0011569053,\"key\":\"JN322\"},{\"doc_count\":8,\"doc_percent\":0.0011569053,\"key\":\"JY22\"},{\"doc_count\":8,\"doc_percent\":0.0011569053,\"key\":\"LY222\"},{\"doc_count\":8,\"doc_percent\":0.0011569053,\"key\":\"WZ211\"}],\"createtime\":0,\"device\":[{\"doc_count\":4145,\"doc_percent\":0.59942156,\"key\":\"PC\"},{\"doc_count\":2482,\"doc_percent\":0.35892987,\"key\":\"Mobile\"},{\"doc_count\":144,\"doc_percent\":0.020824295,\"key\":\"Tablet\"},{\"doc_count\":144,\"doc_percent\":0.020824295,\"key\":\"UNKNOWN\"}],\"gender\":[{\"doc_count\":3814,\"doc_percent\":0.5515546,\"key\":\"m\"},{\"doc_count\":1769,\"doc_percent\":0.2558207,\"key\":\"UNKNOWN\"},{\"doc_count\":1332,\"doc_percent\":0.19262473,\"key\":\"f\"}],\"interest\":[{\"doc_count\":6755,\"doc_percent\":0.9768619,\"en_name\":\"Home
        // &
        // Lifestyle\",\"key\":\"27\",\"zh_cn_name\":\"家居生活\"},{\"doc_count\":6751,\"doc_percent\":0.97628343,\"en_name\":\"Health
        // &
        // Wellness\",\"key\":\"15\",\"zh_cn_name\":\"健康医疗\"},{\"doc_count\":6717,\"doc_percent\":0.9713666,\"en_name\":\"Food
        // &
        // Drink\",\"key\":\"26\",\"zh_cn_name\":\"食品美食\"},{\"doc_count\":6188,\"doc_percent\":0.8948662,\"en_name\":\"Arts
        // &
        // Entertainment\",\"key\":\"31\",\"zh_cn_name\":\"娱乐\"},{\"doc_count\":6056,\"doc_percent\":0.8757773,\"en_name\":\"Culture\",\"key\":\"11\",\"zh_cn_name\":\"文化艺术\"},{\"doc_count\":6041,\"doc_percent\":0.8736081,\"en_name\":\"Pets\",\"key\":\"2703\",\"zh_cn_name\":\"宠物\"},{\"doc_count\":5989,\"doc_percent\":0.8660882,\"en_name\":\"Psychology\",\"key\":\"1501\",\"zh_cn_name\":\"情感心理\"},{\"doc_count\":5820,\"doc_percent\":0.8416486,\"en_name\":\"Restaurants\",\"key\":\"2603\",\"zh_cn_name\":\"餐馆美食\"},{\"doc_count\":5706,\"doc_percent\":0.8251627,\"en_name\":\"Humanities
        // &
        // Arts\",\"key\":\"1104\",\"zh_cn_name\":\"人文艺术\"},{\"doc_count\":5696,\"doc_percent\":0.8237166,\"en_name\":\"Comics
        // &
        // Animation\",\"key\":\"3104\",\"zh_cn_name\":\"动画漫画\"},{\"doc_count\":3797,\"doc_percent\":0.54909617,\"en_name\":\"Domestic
        // Appliance\",\"key\":\"2702\",\"zh_cn_name\":\"家用电器\"},{\"doc_count\":3594,\"doc_percent\":0.5197397,\"en_name\":\"Healthcare\",\"key\":\"1503\",\"zh_cn_name\":\"保健养生\"},{\"doc_count\":3503,\"doc_percent\":0.5065799,\"en_name\":\"Cosmetic
        // Procedures\",\"key\":\"1502\",\"zh_cn_name\":\"整形整容\"},{\"doc_count\":3396,\"doc_percent\":0.4911063,\"en_name\":\"Jobs
        // &
        // Education\",\"key\":\"12\",\"zh_cn_name\":\"教育培训\"},{\"doc_count\":3353,\"doc_percent\":0.48488793,\"en_name\":\"Fresh
        // Food\",\"key\":\"2605\",\"zh_cn_name\":\"生鲜食品\"},{\"doc_count\":3083,\"doc_percent\":0.4458424,\"en_name\":\"Automobiles\",\"key\":\"17\",\"zh_cn_name\":\"汽车\"},{\"doc_count\":3027,\"doc_percent\":0.43774402,\"en_name\":\"Leisure
        // Travel & Business
        // Travel\",\"key\":\"25\",\"zh_cn_name\":\"旅游商旅\"},{\"doc_count\":2972,\"doc_percent\":0.42979032,\"en_name\":\"Personal
        // Finance\",\"key\":\"21\",\"zh_cn_name\":\"金融财经\"},{\"doc_count\":2654,\"doc_percent\":0.38380334,\"en_name\":\"Private
        // School\",\"key\":\"1208\",\"zh_cn_name\":\"私立学校\"},{\"doc_count\":2601,\"doc_percent\":0.37613884,\"en_name\":\"Travel
        // Destination\",\"key\":\"2502\",\"zh_cn_name\":\"旅游目的地\"},{\"doc_count\":2490,\"doc_percent\":0.36008677,\"en_name\":\"Car
        // Manufacturer
        // Country\",\"key\":\"1711\",\"zh_cn_name\":\"生产国家\"},{\"doc_count\":2266,\"doc_percent\":0.32769343,\"en_name\":\"Japan
        // & Korea
        // (Car)\",\"key\":\"171101\",\"zh_cn_name\":\"日本韩国车\"},{\"doc_count\":2152,\"doc_percent\":0.31120753,\"en_name\":\"Sports
        // &
        // Fitness\",\"key\":\"18\",\"zh_cn_name\":\"运动健身\"},{\"doc_count\":2019,\"doc_percent\":0.29197398,\"en_name\":\"Beauty
        // &
        // Cosmetics\",\"key\":\"16\",\"zh_cn_name\":\"美容及化妆品\"},{\"doc_count\":2018,\"doc_percent\":0.29182935,\"en_name\":\"Car
        // Type\",\"key\":\"1712\",\"zh_cn_name\":\"车型\"},{\"doc_count\":1996,\"doc_percent\":0.28864786,\"en_name\":\"Germany
        // (Car)\",\"key\":\"171102\",\"zh_cn_name\":\"德国车\"},{\"doc_count\":1900,\"doc_percent\":0.274765,\"en_name\":\"Insurance\",\"key\":\"2101\",\"zh_cn_name\":\"保险\"},{\"doc_count\":1865,\"doc_percent\":0.26970354,\"en_name\":\"Skin
        // Care\",\"key\":\"1601\",\"zh_cn_name\":\"护肤\"},{\"doc_count\":1863,\"doc_percent\":0.2694143,\"en_name\":\"Baby
        // &
        // Maternity\",\"key\":\"20\",\"zh_cn_name\":\"母婴育儿\"},{\"doc_count\":1862,\"doc_percent\":0.2692697,\"en_name\":\"Overseas
        // Education\",\"key\":\"1202\",\"zh_cn_name\":\"留学移民\"},{\"doc_count\":1857,\"doc_percent\":0.26854664,\"en_name\":\"Maternity
        // &
        // Parenting\",\"key\":\"2001\",\"zh_cn_name\":\"母婴用品\"},{\"doc_count\":1828,\"doc_percent\":0.26435286,\"en_name\":\"Alcohol\",\"key\":\"30\",\"zh_cn_name\":\"酒类\"},{\"doc_count\":1806,\"doc_percent\":0.26117137,\"en_name\":\"Furniture
        // Decoration\",\"key\":\"2701\",\"zh_cn_name\":\"家居家装\"},{\"doc_count\":1790,\"doc_percent\":0.25885755,\"en_name\":\"Movies\",\"key\":\"3102\",\"zh_cn_name\":\"院线电影\"},{\"doc_count\":1789,\"doc_percent\":0.25871295,\"en_name\":\"Consulting
        // &
        // Services\",\"key\":\"22\",\"zh_cn_name\":\"咨询及服务\"},{\"doc_count\":1604,\"doc_percent\":0.2319595,\"en_name\":\"Real
        // Estate &
        // Construction\",\"key\":\"2103\",\"zh_cn_name\":\"房地产及建筑\"},{\"doc_count\":1577,\"doc_percent\":0.22805496,\"en_name\":\"Pop
        // Music\",\"key\":\"3106\",\"zh_cn_name\":\"流行音乐\"},{\"doc_count\":1569,\"doc_percent\":0.22689804,\"en_name\":\"Japan
        // / Korea (Travel)\",\"key\":\"250203\",\"zh_cn_name\":\"日本 /
        // 韩国旅游\"},{\"doc_count\":1526,\"doc_percent\":0.22067969,\"en_name\":\"Sexual
        // Health\",\"key\":\"1504\",\"zh_cn_name\":\"两性健康\"},{\"doc_count\":1504,\"doc_percent\":0.2174982,\"en_name\":\"Primary
        // Middle & High
        // School\",\"key\":\"120803\",\"zh_cn_name\":\"私立中学\"},{\"doc_count\":1502,\"doc_percent\":0.21720897,\"en_name\":\"Female
        // Fashion\",\"key\":\"24\",\"zh_cn_name\":\"时尚\"},{\"doc_count\":1500,\"doc_percent\":0.21691974,\"en_name\":\"Investing\",\"key\":\"2102\",\"zh_cn_name\":\"投资理财\"},{\"doc_count\":1464,\"doc_percent\":0.21171367,\"en_name\":\"Make-Up/Cosmetics\",\"key\":\"1603\",\"zh_cn_name\":\"彩妆\"},{\"doc_count\":1457,\"doc_percent\":0.21070138,\"en_name\":\"Private
        // Primary
        // School\",\"key\":\"120802\",\"zh_cn_name\":\"私立小学\"},{\"doc_count\":1443,\"doc_percent\":0.20867679,\"en_name\":\"Cooking
        // &
        // Recipes\",\"key\":\"2601\",\"zh_cn_name\":\"烹饪和菜谱\"},{\"doc_count\":1424,\"doc_percent\":0.20592915,\"en_name\":\"Culture/Literature\",\"key\":\"1102\",\"zh_cn_name\":\"文化文学\"},{\"doc_count\":1402,\"doc_percent\":0.20274764,\"en_name\":\"Healthy
        // Food\",\"key\":\"2604\",\"zh_cn_name\":\"保健食品\"},{\"doc_count\":1396,\"doc_percent\":0.20187998,\"en_name\":\"Wine\",\"key\":\"3002\",\"zh_cn_name\":\"葡萄酒\"},{\"doc_count\":1372,\"doc_percent\":0.19840926,\"en_name\":\"Wedding
        // Services\",\"key\":\"2201\",\"zh_cn_name\":\"婚庆\"},{\"doc_count\":1371,\"doc_percent\":0.19826464,\"en_name\":\"Hotels
        // &
        // Accommodations\",\"key\":\"2501\",\"zh_cn_name\":\"酒店\"},{\"doc_count\":1312,\"doc_percent\":0.18973246,\"en_name\":\"Sports
        // Events\",\"key\":\"1803\",\"zh_cn_name\":\"体育赛事\"},{\"doc_count\":1299,\"doc_percent\":0.1878525,\"en_name\":\"TV
        // Dramas\",\"key\":\"3103\",\"zh_cn_name\":\"网络影视剧\"},{\"doc_count\":1216,\"doc_percent\":0.1758496,\"en_name\":\"Asset
        // Management\",\"key\":\"210202\",\"zh_cn_name\":\"投资和资产管理\"},{\"doc_count\":1113,\"doc_percent\":0.16095445,\"en_name\":\"Clothing\",\"key\":\"2401\",\"zh_cn_name\":\"服装\"},{\"doc_count\":1080,\"doc_percent\":0.15618221,\"en_name\":\"Country
        // of
        // Origin\",\"key\":\"300207\",\"zh_cn_name\":\"产地\"},{\"doc_count\":1041,\"doc_percent\":0.1505423,\"en_name\":\"Variety
        // &
        // Entertainment\",\"key\":\"3101\",\"zh_cn_name\":\"娱乐综艺\"},{\"doc_count\":1013,\"doc_percent\":0.14649314,\"en_name\":\"SUV\",\"key\":\"171204\",\"zh_cn_name\":\"越野车\"},{\"doc_count\":995,\"doc_percent\":0.1438901,\"en_name\":\"MPV\",\"key\":\"171208\",\"zh_cn_name\":\"多功能车\"},{\"doc_count\":992,\"doc_percent\":0.14345625,\"en_name\":\"Outdoor
        // Sports\",\"key\":\"1802\",\"zh_cn_name\":\"户外\"},{\"doc_count\":972,\"doc_percent\":0.140564,\"en_name\":\"Australia
        // & New Zealand (Travel)\",\"key\":\"250206\",\"zh_cn_name\":\"大洋洲旅游
        // （澳洲 &
        // 新西兰）\"},{\"doc_count\":968,\"doc_percent\":0.13998553,\"en_name\":\"Baby
        // Feeding\",\"key\":\"200102\",\"zh_cn_name\":\"喂养用品\"},{\"doc_count\":967,\"doc_percent\":0.13984093,\"en_name\":\"Overseas
        // Education
        // Application\",\"key\":\"120202\",\"zh_cn_name\":\"留学申请\"},{\"doc_count\":960,\"doc_percent\":0.13882864,\"en_name\":\"Mother's
        // Goods\",\"key\":\"200105\",\"zh_cn_name\":\"妈妈用品\"},{\"doc_count\":956,\"doc_percent\":0.13825019,\"en_name\":\"Bodycare\",\"key\":\"160110\",\"zh_cn_name\":\"身体护肤\"},{\"doc_count\":948,\"doc_percent\":0.13709328,\"en_name\":\"Mid-End
        // Cars\",\"key\":\"1702\",\"zh_cn_name\":\"中档汽车\"},{\"doc_count\":886,\"doc_percent\":0.12812726,\"en_name\":\"United
        // States
        // (Car)\",\"key\":\"171103\",\"zh_cn_name\":\"美国车\"},{\"doc_count\":883,\"doc_percent\":0.12769341,\"en_name\":\"Overseas
        // Education
        // Destination\",\"key\":\"120203\",\"zh_cn_name\":\"留学移民国家\"},{\"doc_count\":879,\"doc_percent\":0.12711497,\"en_name\":\"Health
        // & Medical
        // Insurance\",\"key\":\"210102\",\"zh_cn_name\":\"健康保险\"},{\"doc_count\":872,\"doc_percent\":0.12610267,\"en_name\":\"SEA
        // (Travel)\",\"key\":\"250202\",\"zh_cn_name\":\"东南亚旅游\"},{\"doc_count\":870,\"doc_percent\":0.12581345,\"en_name\":\"Fitness\",\"key\":\"1801\",\"zh_cn_name\":\"健身\"},{\"doc_count\":869,\"doc_percent\":0.12566884,\"en_name\":\"China
        // (Car)\",\"key\":\"171104\",\"zh_cn_name\":\"国产车\"},{\"doc_count\":864,\"doc_percent\":0.12494577,\"en_name\":\"Luxury
        // Cars\",\"key\":\"1710\",\"zh_cn_name\":\"豪华汽车\"},{\"doc_count\":861,\"doc_percent\":0.12451193,\"en_name\":\"Eye
        // Makeup\",\"key\":\"160302\",\"zh_cn_name\":\"眼部彩妆\"},{\"doc_count\":853,\"doc_percent\":0.12335502,\"en_name\":\"Private
        // Kindergarten\",\"key\":\"120801\",\"zh_cn_name\":\"私立幼儿园\"},{\"doc_count\":833,\"doc_percent\":0.12046276,\"en_name\":\"Makeup
        // Tools\",\"key\":\"160305\",\"zh_cn_name\":\"美发护发\"},{\"doc_count\":822,\"doc_percent\":0.11887202,\"en_name\":\"High-End
        // Cars\",\"key\":\"1701\",\"zh_cn_name\":\"高档汽车\"},{\"doc_count\":806,\"doc_percent\":0.11655821,\"en_name\":\"Property
        // Management\",\"key\":\"210303\",\"zh_cn_name\":\"物业管理\"},{\"doc_count\":803,\"doc_percent\":0.11612437,\"en_name\":\"Sedan\",\"key\":\"171201\",\"zh_cn_name\":\"三厢车\"},{\"doc_count\":777,\"doc_percent\":0.112364426,\"en_name\":\"Hong
        // Kong,Macau and Singapore
        // (Travel)\",\"key\":\"250207\",\"zh_cn_name\":\"港澳游\"},{\"doc_count\":771,\"doc_percent\":0.11149675,\"en_name\":\"Baby
        // Bedding\",\"key\":\"200109\",\"zh_cn_name\":\"婴儿寝具\"},{\"doc_count\":763,\"doc_percent\":0.11033984,\"en_name\":\"Snacks\",\"key\":\"2602\",\"zh_cn_name\":\"休闲食品\"},{\"doc_count\":761,\"doc_percent\":0.11005061,\"en_name\":\"Baby
        // Care\",\"key\":\"200106\",\"zh_cn_name\":\"婴幼护理\"},{\"doc_count\":759,\"doc_percent\":0.10976139,\"en_name\":\"Real
        // Estate\",\"key\":\"210304\",\"zh_cn_name\":\"楼盘\"},{\"doc_count\":753,\"doc_percent\":0.10889371,\"en_name\":\"Coupe\",\"key\":\"171202\",\"zh_cn_name\":\"轿跑车\"},{\"doc_count\":751,\"doc_percent\":0.10860448,\"en_name\":\"Sports
        // Car\",\"key\":\"171209\",\"zh_cn_name\":\"跑车\"},{\"doc_count\":727,\"doc_percent\":0.105133764,\"en_name\":\"Hatchback\",\"key\":\"171203\",\"zh_cn_name\":\"两厢车\"},{\"doc_count\":725,\"doc_percent\":0.10484454,\"en_name\":\"Station
        // Wagon\",\"key\":\"171205\",\"zh_cn_name\":\"旅行车\"},{\"doc_count\":722,\"doc_percent\":0.1044107,\"en_name\":\"Luxury
        // Hotel\",\"key\":\"250101\",\"zh_cn_name\":\"奢华酒店\"},{\"doc_count\":714,\"doc_percent\":0.1032538,\"en_name\":\"Hydration\",\"key\":\"160102\",\"zh_cn_name\":\"补水保湿\"},{\"doc_count\":708,\"doc_percent\":0.10238612,\"en_name\":\"Auto
        // Insurance\",\"key\":\"1708\",\"zh_cn_name\":\"汽车保险\"},{\"doc_count\":697,\"doc_percent\":0.10079537,\"en_name\":\"Imported
        // Wine\",\"key\":\"3003\",\"zh_cn_name\":\"洋酒\"},{\"doc_count\":681,\"doc_percent\":0.09848156,\"en_name\":\"North
        // America
        // (Travel)\",\"key\":\"250201\",\"zh_cn_name\":\"北美旅游\"},{\"doc_count\":681,\"doc_percent\":0.09848156,\"en_name\":\"Europe
        // (Travel)\",\"key\":\"250204\",\"zh_cn_name\":\"欧洲旅游\"},{\"doc_count\":676,\"doc_percent\":0.097758494,\"en_name\":\"Anti-allergy\",\"key\":\"160108\",\"zh_cn_name\":\"抗过敏\"},{\"doc_count\":674,\"doc_percent\":0.09746927,\"en_name\":\"Books/Magazines\",\"key\":\"1103\",\"zh_cn_name\":\"书刊杂志\"},{\"doc_count\":666,\"doc_percent\":0.09631237,\"en_name\":\"Property
        // Insurance\",\"key\":\"210103\",\"zh_cn_name\":\"财产保险\"},{\"doc_count\":632,\"doc_percent\":0.09139552,\"en_name\":\"Drinks\",\"key\":\"2607\",\"zh_cn_name\":\"饮料\"},{\"doc_count\":610,\"doc_percent\":0.088214025,\"en_name\":\"Van\",\"key\":\"171206\",\"zh_cn_name\":\"面包车\"},{\"doc_count\":602,\"doc_percent\":0.08705712,\"en_name\":\"Beer\",\"key\":\"3004\",\"zh_cn_name\":\"啤酒\"},{\"doc_count\":589,\"doc_percent\":0.08517715,\"en_name\":\"Eyecare\",\"key\":\"160109\",\"zh_cn_name\":\"眼部护理\"}],\"province\":[{\"doc_count\":1884,\"doc_percent\":0.2724512,\"key\":\"CN_BJ\"},{\"doc_count\":750,\"doc_percent\":0.10845987,\"key\":\"CN_GD\"},{\"doc_count\":521,\"doc_percent\":0.07534346,\"key\":\"CN_SH\"},{\"doc_count\":482,\"doc_percent\":0.06970354,\"key\":\"CN_JS\"},{\"doc_count\":393,\"doc_percent\":0.056832973,\"key\":\"CN_ZJ\"},{\"doc_count\":320,\"doc_percent\":0.04627621,\"key\":\"CN_FJ\"},{\"doc_count\":237,\"doc_percent\":0.03427332,\"key\":\"CN_SD\"},{\"doc_count\":195,\"doc_percent\":0.028199567,\"key\":\"CN_HU\"},{\"doc_count\":182,\"doc_percent\":0.026319595,\"key\":\"CN_SC\"},{\"doc_count\":163,\"doc_percent\":0.023571946,\"key\":\"CN_JX\"},{\"doc_count\":150,\"doc_percent\":0.021691974,\"key\":\"CN_AH\"},{\"doc_count\":138,\"doc_percent\":0.019956617,\"key\":\"CN_HN\"},{\"doc_count\":137,\"doc_percent\":0.019812003,\"key\":\"CN_HB\"},{\"doc_count\":137,\"doc_percent\":0.019812003,\"key\":\"CN_LN\"},{\"doc_count\":127,\"doc_percent\":0.018365871,\"key\":\"CN_HE\"},{\"doc_count\":106,\"doc_percent\":0.015328995,\"key\":\"CN_TJ\"},{\"doc_count\":97,\"doc_percent\":0.014027476,\"key\":\"CN_GX\"},{\"doc_count\":79,\"doc_percent\":0.01142444,\"key\":\"CN_HL\"},{\"doc_count\":79,\"doc_percent\":0.01142444,\"key\":\"HK\"},{\"doc_count\":78,\"doc_percent\":0.011279826,\"key\":\"CN_JL\"},{\"doc_count\":70,\"doc_percent\":0.010122921,\"key\":\"CN_SA\"},{\"doc_count\":65,\"doc_percent\":0.0093998555,\"key\":\"CN_CQ\"},{\"doc_count\":56,\"doc_percent\":0.008098337,\"key\":\"CN_IN_US\"},{\"doc_count\":48,\"doc_percent\":0.0069414317,\"key\":\"CN_SX\"},{\"doc_count\":43,\"doc_percent\":0.006218366,\"key\":\"CN_GZ\"},{\"doc_count\":42,\"doc_percent\":0.006073753,\"key\":\"CN_YN\"},{\"doc_count\":35,\"doc_percent\":0.0050614607,\"key\":\"CN_NM\"},{\"doc_count\":31,\"doc_percent\":0.004483008,\"key\":\"CN_GS\"},{\"doc_count\":27,\"doc_percent\":0.0039045552,\"key\":\"CN_IN_GB\"},{\"doc_count\":26,\"doc_percent\":0.0037599423,\"key\":\"CN_XJ\"},{\"doc_count\":25,\"doc_percent\":0.003615329,\"key\":\"CN_IN_MY\"},{\"doc_count\":25,\"doc_percent\":0.003615329,\"key\":\"CN_IN_SG\"},{\"doc_count\":22,\"doc_percent\":0.0031814894,\"key\":\"TW\"},{\"doc_count\":21,\"doc_percent\":0.0030368764,\"key\":\"CN_HA\"},{\"doc_count\":19,\"doc_percent\":0.00274765,\"key\":\"CN_IN_AU\"},{\"doc_count\":17,\"doc_percent\":0.0024584236,\"key\":\"CN_IN_UK\"},{\"doc_count\":13,\"doc_percent\":0.0018799711,\"key\":\"CN_UNKNOWN\"},{\"doc_count\":11,\"doc_percent\":0.0015907447,\"key\":\"CN_IN_JP\"},{\"doc_count\":8,\"doc_percent\":0.0011569053,\"key\":\"CN_IN_CA\"},{\"doc_count\":6,\"doc_percent\":8.6767896E-4,\"key\":\"CN_NX\"},{\"doc_count\":5,\"doc_percent\":7.230658E-4,\"key\":\"CN_IN_CN\"},{\"doc_count\":5,\"doc_percent\":7.230658E-4,\"key\":\"CN_IN_KR\"},{\"doc_count\":5,\"doc_percent\":7.230658E-4,\"key\":\"CN_QH\"},{\"doc_count\":4,\"doc_percent\":5.7845266E-4,\"key\":\"CN_IN_PH\"},{\"doc_count\":4,\"doc_percent\":5.7845266E-4,\"key\":\"CN_IN_RU\"},{\"doc_count\":4,\"doc_percent\":5.7845266E-4,\"key\":\"CN_IN_TH\"},{\"doc_count\":2,\"doc_percent\":2.8922633E-4,\"key\":\"CN_IN_CH\"},{\"doc_count\":2,\"doc_percent\":2.8922633E-4,\"key\":\"CN_IN_DE\"},{\"doc_count\":2,\"doc_percent\":2.8922633E-4,\"key\":\"CN_IN_FR\"},{\"doc_count\":2,\"doc_percent\":2.8922633E-4,\"key\":\"CN_IN_IT\"},{\"doc_count\":2,\"doc_percent\":2.8922633E-4,\"key\":\"CN_IN_NL\"},{\"doc_count\":2,\"doc_percent\":2.8922633E-4,\"key\":\"CN_IN_NZ\"},{\"doc_count\":2,\"doc_percent\":2.8922633E-4,\"key\":\"CN_XZ\"},{\"doc_count\":2,\"doc_percent\":2.8922633E-4,\"key\":\"MO\"},{\"doc_count\":1,\"doc_percent\":1.4461316E-4,\"key\":\"CN_IN_AZ\"},{\"doc_count\":1,\"doc_percent\":1.4461316E-4,\"key\":\"CN_IN_BD\"},{\"doc_count\":1,\"doc_percent\":1.4461316E-4,\"key\":\"CN_IN_CZ\"},{\"doc_count\":1,\"doc_percent\":1.4461316E-4,\"key\":\"CN_IN_ES\"},{\"doc_count\":1,\"doc_percent\":1.4461316E-4,\"key\":\"CN_IN_FI\"},{\"doc_count\":1,\"doc_percent\":1.4461316E-4,\"key\":\"CN_IN_MM\"},{\"doc_count\":1,\"doc_percent\":1.4461316E-4,\"key\":\"CN_IN_VN\"}],\"raw_interest\":[{\"doc_count\":6415,\"doc_percent\":0.9276934,\"en_name\":\"Food
        // &
        // Drink\",\"key\":\"26\",\"zh_cn_name\":\"食品美食\"},{\"doc_count\":5547,\"doc_percent\":0.8021692,\"en_name\":\"Restaurants\",\"key\":\"2603\",\"zh_cn_name\":\"餐馆美食\"},{\"doc_count\":2612,\"doc_percent\":0.37772956,\"en_name\":\"Fresh
        // Food\",\"key\":\"2605\",\"zh_cn_name\":\"生鲜食品\"},{\"doc_count\":2183,\"doc_percent\":0.31569052,\"en_name\":\"Arts
        // &
        // Entertainment\",\"key\":\"31\",\"zh_cn_name\":\"娱乐\"},{\"doc_count\":1700,\"doc_percent\":0.24584237,\"en_name\":\"Personal
        // Finance\",\"key\":\"21\",\"zh_cn_name\":\"金融财经\"},{\"doc_count\":1415,\"doc_percent\":0.20462762,\"en_name\":\"Health
        // &
        // Wellness\",\"key\":\"15\",\"zh_cn_name\":\"健康医疗\"},{\"doc_count\":1164,\"doc_percent\":0.16832972,\"en_name\":\"Investing\",\"key\":\"2102\",\"zh_cn_name\":\"投资理财\"},{\"doc_count\":1032,\"doc_percent\":0.14924078,\"en_name\":\"Automobiles\",\"key\":\"17\",\"zh_cn_name\":\"汽车\"},{\"doc_count\":1027,\"doc_percent\":0.14851771,\"en_name\":\"Pop
        // Music\",\"key\":\"3106\",\"zh_cn_name\":\"流行音乐\"},{\"doc_count\":980,\"doc_percent\":0.14172089,\"en_name\":\"Jobs
        // &
        // Education\",\"key\":\"12\",\"zh_cn_name\":\"教育培训\"},{\"doc_count\":952,\"doc_percent\":0.13767172,\"en_name\":\"TV
        // Dramas\",\"key\":\"3103\",\"zh_cn_name\":\"网络影视剧\"},{\"doc_count\":942,\"doc_percent\":0.1362256,\"en_name\":\"Asset
        // Management\",\"key\":\"210202\",\"zh_cn_name\":\"投资和资产管理\"},{\"doc_count\":937,\"doc_percent\":0.13550253,\"en_name\":\"Leisure
        // Travel & Business
        // Travel\",\"key\":\"25\",\"zh_cn_name\":\"旅游商旅\"},{\"doc_count\":916,\"doc_percent\":0.13246566,\"en_name\":\"Culture\",\"key\":\"11\",\"zh_cn_name\":\"文化艺术\"},{\"doc_count\":869,\"doc_percent\":0.12566884,\"en_name\":\"Sports
        // &
        // Fitness\",\"key\":\"18\",\"zh_cn_name\":\"运动健身\"},{\"doc_count\":848,\"doc_percent\":0.12263196,\"en_name\":\"Female
        // Fashion\",\"key\":\"24\",\"zh_cn_name\":\"时尚\"},{\"doc_count\":819,\"doc_percent\":0.11843818,\"en_name\":\"Variety
        // &
        // Entertainment\",\"key\":\"3101\",\"zh_cn_name\":\"娱乐综艺\"},{\"doc_count\":767,\"doc_percent\":0.11091829,\"en_name\":\"Car
        // Type\",\"key\":\"1712\",\"zh_cn_name\":\"车型\"},{\"doc_count\":767,\"doc_percent\":0.11091829,\"en_name\":\"Home
        // &
        // Lifestyle\",\"key\":\"27\",\"zh_cn_name\":\"家居生活\"},{\"doc_count\":758,\"doc_percent\":0.10961678,\"en_name\":\"Real
        // Estate &
        // Construction\",\"key\":\"2103\",\"zh_cn_name\":\"房地产及建筑\"},{\"doc_count\":709,\"doc_percent\":0.10253073,\"en_name\":\"Movies\",\"key\":\"3102\",\"zh_cn_name\":\"院线电影\"},{\"doc_count\":696,\"doc_percent\":0.10065076,\"en_name\":\"Cooking
        // &
        // Recipes\",\"key\":\"2601\",\"zh_cn_name\":\"烹饪和菜谱\"},{\"doc_count\":685,\"doc_percent\":0.099060014,\"en_name\":\"Travel
        // Destination\",\"key\":\"2502\",\"zh_cn_name\":\"旅游目的地\"},{\"doc_count\":652,\"doc_percent\":0.09428778,\"en_name\":\"Overseas
        // Education\",\"key\":\"1202\",\"zh_cn_name\":\"留学移民\"},{\"doc_count\":592,\"doc_percent\":0.08561099,\"en_name\":\"Sports
        // Events\",\"key\":\"1803\",\"zh_cn_name\":\"体育赛事\"},{\"doc_count\":586,\"doc_percent\":0.08474331,\"en_name\":\"Psychology\",\"key\":\"1501\",\"zh_cn_name\":\"情感心理\"},{\"doc_count\":546,\"doc_percent\":0.07895879,\"en_name\":\"Culture/Literature\",\"key\":\"1102\",\"zh_cn_name\":\"文化文学\"},{\"doc_count\":541,\"doc_percent\":0.07823572,\"en_name\":\"Car
        // Manufacturer
        // Country\",\"key\":\"1711\",\"zh_cn_name\":\"生产国家\"},{\"doc_count\":516,\"doc_percent\":0.07462039,\"en_name\":\"Drinks\",\"key\":\"2607\",\"zh_cn_name\":\"饮料\"},{\"doc_count\":457,\"doc_percent\":0.066088215,\"en_name\":\"Property
        // Management\",\"key\":\"210303\",\"zh_cn_name\":\"物业管理\"},{\"doc_count\":453,\"doc_percent\":0.06550976,\"en_name\":\"SUV\",\"key\":\"171204\",\"zh_cn_name\":\"越野车\"},{\"doc_count\":449,\"doc_percent\":0.06493131,\"en_name\":\"Clothing\",\"key\":\"2401\",\"zh_cn_name\":\"服装\"},{\"doc_count\":424,\"doc_percent\":0.06131598,\"en_name\":\"Cosmetic
        // Procedures\",\"key\":\"1502\",\"zh_cn_name\":\"整形整容\"},{\"doc_count\":405,\"doc_percent\":0.05856833,\"en_name\":\"Fitness\",\"key\":\"1801\",\"zh_cn_name\":\"健身\"},{\"doc_count\":401,\"doc_percent\":0.057989877,\"en_name\":\"Beauty
        // &
        // Cosmetics\",\"key\":\"16\",\"zh_cn_name\":\"美容及化妆品\"},{\"doc_count\":391,\"doc_percent\":0.056543745,\"en_name\":\"Shoes
        // &
        // Bags\",\"key\":\"2404\",\"zh_cn_name\":\"鞋包\"},{\"doc_count\":388,\"doc_percent\":0.056109905,\"en_name\":\"Sexual
        // Health\",\"key\":\"1504\",\"zh_cn_name\":\"两性健康\"},{\"doc_count\":362,\"doc_percent\":0.052349962,\"en_name\":\"Overseas
        // Education
        // Destination\",\"key\":\"120203\",\"zh_cn_name\":\"留学移民国家\"},{\"doc_count\":359,\"doc_percent\":0.051916126,\"en_name\":\"Consulting
        // &
        // Services\",\"key\":\"22\",\"zh_cn_name\":\"咨询及服务\"},{\"doc_count\":357,\"doc_percent\":0.0516269,\"en_name\":\"Van\",\"key\":\"171206\",\"zh_cn_name\":\"面包车\"},{\"doc_count\":330,\"doc_percent\":0.047722343,\"en_name\":\"Healthcare\",\"key\":\"1503\",\"zh_cn_name\":\"保健养生\"},{\"doc_count\":328,\"doc_percent\":0.047433116,\"en_name\":\"Hotels
        // &
        // Accommodations\",\"key\":\"2501\",\"zh_cn_name\":\"酒店\"},{\"doc_count\":311,\"doc_percent\":0.044974692,\"en_name\":\"Private
        // School\",\"key\":\"1208\",\"zh_cn_name\":\"私立学校\"},{\"doc_count\":311,\"doc_percent\":0.044974692,\"en_name\":\"Furniture
        // Decoration\",\"key\":\"2701\",\"zh_cn_name\":\"家居家装\"},{\"doc_count\":302,\"doc_percent\":0.043673173,\"en_name\":\"Pets\",\"key\":\"2703\",\"zh_cn_name\":\"宠物\"},{\"doc_count\":296,\"doc_percent\":0.042805497,\"en_name\":\"Mid-End
        // Cars\",\"key\":\"1702\",\"zh_cn_name\":\"中档汽车\"},{\"doc_count\":284,\"doc_percent\":0.041070137,\"en_name\":\"Skin
        // Care\",\"key\":\"1601\",\"zh_cn_name\":\"护肤\"},{\"doc_count\":282,\"doc_percent\":0.04078091,\"en_name\":\"Online
        // Literature\",\"key\":\"1101\",\"zh_cn_name\":\"网络小说\"},{\"doc_count\":277,\"doc_percent\":0.040057845,\"en_name\":\"Luxury
        // Cars\",\"key\":\"1710\",\"zh_cn_name\":\"豪华汽车\"},{\"doc_count\":271,\"doc_percent\":0.039190166,\"en_name\":\"Domestic
        // Appliance\",\"key\":\"2702\",\"zh_cn_name\":\"家用电器\"},{\"doc_count\":267,\"doc_percent\":0.038611714,\"en_name\":\"Germany
        // (Car)\",\"key\":\"171102\",\"zh_cn_name\":\"德国车\"},{\"doc_count\":263,\"doc_percent\":0.038033262,\"en_name\":\"United
        // States
        // (Car)\",\"key\":\"171103\",\"zh_cn_name\":\"美国车\"},{\"doc_count\":260,\"doc_percent\":0.037599422,\"en_name\":\"Designers
        // &
        // Collections\",\"key\":\"2403\",\"zh_cn_name\":\"奢侈品\"},{\"doc_count\":257,\"doc_percent\":0.037165582,\"en_name\":\"Entry-Level
        // Cars\",\"key\":\"1703\",\"zh_cn_name\":\"入门级汽车\"},{\"doc_count\":248,\"doc_percent\":0.035864063,\"en_name\":\"Baby
        // &
        // Maternity\",\"key\":\"20\",\"zh_cn_name\":\"母婴育儿\"},{\"doc_count\":246,\"doc_percent\":0.03557484,\"en_name\":\"Hong
        // Kong,Macau and Singapore
        // (Travel)\",\"key\":\"250207\",\"zh_cn_name\":\"港澳游\"},{\"doc_count\":246,\"doc_percent\":0.03557484,\"en_name\":\"Alcohol\",\"key\":\"30\",\"zh_cn_name\":\"酒类\"},{\"doc_count\":241,\"doc_percent\":0.03485177,\"en_name\":\"High-End
        // Cars\",\"key\":\"1701\",\"zh_cn_name\":\"高档汽车\"},{\"doc_count\":233,\"doc_percent\":0.033694867,\"en_name\":\"Maternity
        // &
        // Parenting\",\"key\":\"2001\",\"zh_cn_name\":\"母婴用品\"},{\"doc_count\":228,\"doc_percent\":0.0329718,\"en_name\":\"Make-Up/Cosmetics\",\"key\":\"1603\",\"zh_cn_name\":\"彩妆\"},{\"doc_count\":228,\"doc_percent\":0.0329718,\"en_name\":\"Personal
        // Loan &
        // Mortgage\",\"key\":\"210201\",\"zh_cn_name\":\"个人贷款\"},{\"doc_count\":225,\"doc_percent\":0.03253796,\"en_name\":\"Japan
        // / Korea (Travel)\",\"key\":\"250203\",\"zh_cn_name\":\"日本 /
        // 韩国旅游\"},{\"doc_count\":219,\"doc_percent\":0.031670284,\"en_name\":\"Snacks\",\"key\":\"2602\",\"zh_cn_name\":\"休闲食品\"},{\"doc_count\":217,\"doc_percent\":0.031381056,\"en_name\":\"China
        // (Car)\",\"key\":\"171104\",\"zh_cn_name\":\"国产车\"},{\"doc_count\":214,\"doc_percent\":0.030947216,\"en_name\":\"Wedding
        // Services\",\"key\":\"2201\",\"zh_cn_name\":\"婚庆\"},{\"doc_count\":206,\"doc_percent\":0.02979031,\"en_name\":\"Sedan\",\"key\":\"171201\",\"zh_cn_name\":\"三厢车\"},{\"doc_count\":201,\"doc_percent\":0.029067244,\"en_name\":\"Primary
        // Middle & High
        // School\",\"key\":\"120803\",\"zh_cn_name\":\"私立中学\"},{\"doc_count\":195,\"doc_percent\":0.028199567,\"en_name\":\"Japan
        // & Korea
        // (Car)\",\"key\":\"171101\",\"zh_cn_name\":\"日本韩国车\"},{\"doc_count\":191,\"doc_percent\":0.027621113,\"en_name\":\"Humanities
        // &
        // Arts\",\"key\":\"1104\",\"zh_cn_name\":\"人文艺术\"},{\"doc_count\":191,\"doc_percent\":0.027621113,\"en_name\":\"Comics
        // &
        // Animation\",\"key\":\"3104\",\"zh_cn_name\":\"动画漫画\"},{\"doc_count\":180,\"doc_percent\":0.02603037,\"en_name\":\"Used
        // Cars\",\"key\":\"1705\",\"zh_cn_name\":\"二手车\"},{\"doc_count\":158,\"doc_percent\":0.02284888,\"en_name\":\"Hong
        // Kong,Macau and Singapore
        // (Education)\",\"key\":\"12020305\",\"zh_cn_name\":\"留学移民港澳新\"},{\"doc_count\":156,\"doc_percent\":0.022559652,\"en_name\":\"Australia
        // & New Zealand (Travel)\",\"key\":\"250206\",\"zh_cn_name\":\"大洋洲旅游
        // （澳洲 &
        // 新西兰）\"},{\"doc_count\":146,\"doc_percent\":0.02111352,\"en_name\":\"Insurance\",\"key\":\"2101\",\"zh_cn_name\":\"保险\"},{\"doc_count\":142,\"doc_percent\":0.020535069,\"en_name\":\"Healthy
        // Food\",\"key\":\"2604\",\"zh_cn_name\":\"保健食品\"},{\"doc_count\":138,\"doc_percent\":0.019956617,\"en_name\":\"Japan
        // & Korea
        // (Education)\",\"key\":\"12020304\",\"zh_cn_name\":\"留学移民日韩\"},{\"doc_count\":138,\"doc_percent\":0.019956617,\"en_name\":\"Brightening
        // &
        // Whitening\",\"key\":\"160103\",\"zh_cn_name\":\"美白提亮祛斑\"},{\"doc_count\":136,\"doc_percent\":0.019667389,\"en_name\":\"Early
        // Childhood
        // Education\",\"key\":\"1205\",\"zh_cn_name\":\"早教幼教\"},{\"doc_count\":136,\"doc_percent\":0.019667389,\"en_name\":\"Sports
        // Car\",\"key\":\"171209\",\"zh_cn_name\":\"跑车\"},{\"doc_count\":129,\"doc_percent\":0.018655097,\"en_name\":\"MPV\",\"key\":\"171208\",\"zh_cn_name\":\"多功能车\"},{\"doc_count\":129,\"doc_percent\":0.018655097,\"en_name\":\"Retail
        // Banking\",\"key\":\"210204\",\"zh_cn_name\":\"银行零售服务\"},{\"doc_count\":126,\"doc_percent\":0.018221257,\"en_name\":\"Careers\",\"key\":\"2202\",\"zh_cn_name\":\"招聘求职\"},{\"doc_count\":126,\"doc_percent\":0.018221257,\"en_name\":\"High-end
        // Hotel\",\"key\":\"250102\",\"zh_cn_name\":\"高级酒店\"},{\"doc_count\":123,\"doc_percent\":0.01778742,\"en_name\":\"Credit
        // Card\",\"key\":\"210203\",\"zh_cn_name\":\"信用卡\"},{\"doc_count\":121,\"doc_percent\":0.017498191,\"en_name\":\"Local
        // Food\",\"key\":\"2606\",\"zh_cn_name\":\"地方特产\"},{\"doc_count\":120,\"doc_percent\":0.01735358,\"en_name\":\"Economy
        // Hotel\",\"key\":\"250104\",\"zh_cn_name\":\"经济型酒店\"},{\"doc_count\":119,\"doc_percent\":0.017208965,\"en_name\":\"North
        // America
        // (Travel)\",\"key\":\"250201\",\"zh_cn_name\":\"北美旅游\"},{\"doc_count\":115,\"doc_percent\":0.016630514,\"en_name\":\"Australia
        // & New Zealand
        // (Education)\",\"key\":\"12020303\",\"zh_cn_name\":\"留学移民澳洲\"},{\"doc_count\":115,\"doc_percent\":0.016630514,\"en_name\":\"Real
        // Estate
        // Agencies\",\"key\":\"210302\",\"zh_cn_name\":\"中介代理\"},{\"doc_count\":109,\"doc_percent\":0.015762834,\"en_name\":\"Makeup
        // Tools\",\"key\":\"160305\",\"zh_cn_name\":\"美发护发\"},{\"doc_count\":105,\"doc_percent\":0.015184382,\"en_name\":\"Europe
        // (Travel)\",\"key\":\"250204\",\"zh_cn_name\":\"欧洲旅游\"},{\"doc_count\":104,\"doc_percent\":0.015039769,\"en_name\":\"Property
        // Development\",\"key\":\"210301\",\"zh_cn_name\":\"开发商\"},{\"doc_count\":103,\"doc_percent\":0.014895155,\"en_name\":\"SEA
        // (Travel)\",\"key\":\"250202\",\"zh_cn_name\":\"东南亚旅游\"},{\"doc_count\":102,\"doc_percent\":0.014750542,\"en_name\":\"Jewelry/Accessories\",\"key\":\"2402\",\"zh_cn_name\":\"首饰饰品\"},{\"doc_count\":102,\"doc_percent\":0.014750542,\"en_name\":\"Wine\",\"key\":\"3002\",\"zh_cn_name\":\"葡萄酒\"},{\"doc_count\":99,\"doc_percent\":0.014316703,\"en_name\":\"Private
        // Kindergarten\",\"key\":\"120801\",\"zh_cn_name\":\"私立幼儿园\"},{\"doc_count\":98,\"doc_percent\":0.014172089,\"en_name\":\"Private
        // Primary
        // School\",\"key\":\"120802\",\"zh_cn_name\":\"私立小学\"},{\"doc_count\":97,\"doc_percent\":0.014027476,\"en_name\":\"Real
        // Estate\",\"key\":\"210304\",\"zh_cn_name\":\"楼盘\"},{\"doc_count\":95,\"doc_percent\":0.01373825,\"en_name\":\"Acne
        // Removing\",\"key\":\"160107\",\"zh_cn_name\":\"祛痘\"},{\"doc_count\":95,\"doc_percent\":0.01373825,\"en_name\":\"Africa
        // (Travel)\",\"key\":\"250205\",\"zh_cn_name\":\"非洲旅游\"}],\"total\":6915},\"competitor\":{\"age\":[{\"doc_count\":33594,\"doc_percent\":0.27532002,\"key\":\"25-34\"},{\"doc_count\":31643,\"doc_percent\":0.2593306,\"key\":\"35-44\"},{\"doc_count\":23935,\"doc_percent\":0.19615959,\"key\":\"45-54\"},{\"doc_count\":14476,\"doc_percent\":0.11863823,\"key\":\"18-24\"},{\"doc_count\":7609,\"doc_percent\":0.062359653,\"key\":\"UNKNOWN\"},{\"doc_count\":5931,\"doc_percent\":0.048607584,\"key\":\"0-17\"},{\"doc_count\":4829,\"doc_percent\":0.039576128,\"key\":\"55-64\"},{\"doc_count\":1,\"doc_percent\":8.195512E-6,\"key\":\"65+\"}],\"city\":[{\"doc_count\":21852,\"doc_percent\":0.17908832,\"key\":\"BJ\"},{\"doc_count\":10670,\"doc_percent\":0.087446116,\"key\":\"SH\"},{\"doc_count\":7067,\"doc_percent\":0.057917684,\"key\":\"\"},{\"doc_count\":4924,\"doc_percent\":0.040354703,\"key\":\"SZ14\"},{\"doc_count\":4338,\"doc_percent\":0.035552133,\"key\":\"GZ31\"},{\"doc_count\":3093,\"doc_percent\":0.02534872,\"key\":\"HZ211\"},{\"doc_count\":2399,\"doc_percent\":0.019661034,\"key\":\"NJ21\"},{\"doc_count\":2355,\"doc_percent\":0.019300431,\"key\":\"WH34\"},{\"doc_count\":1981,\"doc_percent\":0.016235309,\"key\":\"TJ\"},{\"doc_count\":1849,\"doc_percent\":0.015153502,\"key\":\"SZ11\"},{\"doc_count\":1814,\"doc_percent\":0.014866659,\"key\":\"CD1\"},{\"doc_count\":1570,\"doc_percent\":0.012866954,\"key\":\"SY32\"},{\"doc_count\":1442,\"doc_percent\":0.011817928,\"key\":\"CQ\"},{\"doc_count\":1441,\"doc_percent\":0.011809733,\"key\":\"CS\"},{\"doc_count\":1383,\"doc_percent\":0.011334393,\"key\":\"DG\"},{\"doc_count\":1341,\"doc_percent\":0.010990182,\"key\":\"FS21\"},{\"doc_count\":1315,\"doc_percent\":0.010777098,\"key\":\"ZZ41\"},{\"doc_count\":1231,\"doc_percent\":0.010088676,\"key\":\"NC212\"},{\"doc_count\":1207,\"doc_percent\":0.009891983,\"key\":\"FZ21\"},{\"doc_count\":1142,\"doc_percent\":0.009359275,\"key\":\"HF\"},{\"doc_count\":1098,\"doc_percent\":0.0089986725,\"key\":\"DL\"},{\"doc_count\":1098,\"doc_percent\":0.0089986725,\"key\":\"JN321\"},{\"doc_count\":1064,\"doc_percent\":0.0087200245,\"key\":\"XA\"},{\"doc_count\":1015,\"doc_percent\":0.008318445,\"key\":\"NB\"},{\"doc_count\":1009,\"doc_percent\":0.008269272,\"key\":\"QD\"},{\"doc_count\":886,\"doc_percent\":0.0072612236,\"key\":\"WX\"},{\"doc_count\":881,\"doc_percent\":0.0072202464,\"key\":\"XM\"},{\"doc_count\":852,\"doc_percent\":0.0069825766,\"key\":\"WZ11\"},{\"doc_count\":830,\"doc_percent\":0.006802275,\"key\":\"HEB\"},{\"doc_count\":829,\"doc_percent\":0.0067940797,\"key\":\"SJZ\"},{\"doc_count\":793,\"doc_percent\":0.0064990413,\"key\":\"NN\"},{\"doc_count\":570,\"doc_percent\":0.004671442,\"key\":\"CC\"},{\"doc_count\":568,\"doc_percent\":0.004655051,\"key\":\"CZ211\"},{\"doc_count\":564,\"doc_percent\":0.004622269,\"key\":\"SX312\"},{\"doc_count\":548,\"doc_percent\":0.0044911406,\"key\":\"JX112\"},{\"doc_count\":539,\"doc_percent\":0.0044173812,\"key\":\"JH\"},{\"doc_count\":526,\"doc_percent\":0.0043108393,\"key\":\"KM\"},{\"doc_count\":524,\"doc_percent\":0.0042944485,\"key\":\"QZ212\"},{\"doc_count\":524,\"doc_percent\":0.0042944485,\"key\":\"ZS112\"},{\"doc_count\":510,\"doc_percent\":0.004179711,\"key\":\"XZ21\"},{\"doc_count\":472,\"doc_percent\":0.0038682818,\"key\":\"TZ\"},{\"doc_count\":465,\"doc_percent\":0.003810913,\"key\":\"ZJ411\"},{\"doc_count\":461,\"doc_percent\":0.003778131,\"key\":\"YT122\"},{\"doc_count\":453,\"doc_percent\":0.003712567,\"key\":\"TY\"},{\"doc_count\":437,\"doc_percent\":0.003581439,\"key\":\"GA31\"},{\"doc_count\":422,\"doc_percent\":0.0034585062,\"key\":\"NT\"},{\"doc_count\":414,\"doc_percent\":0.003392942,\"key\":\"NY\"},{\"doc_count\":408,\"doc_percent\":0.0033437689,\"key\":\"ZH\"},{\"doc_count\":388,\"doc_percent\":0.0031798587,\"key\":\"WF\"},{\"doc_count\":387,\"doc_percent\":0.0031716633,\"key\":\"TZ41\"},{\"doc_count\":379,\"doc_percent\":0.003106099,\"key\":\"HZ411\"},{\"doc_count\":373,\"doc_percent\":0.003056926,\"key\":\"JM122\"},{\"doc_count\":366,\"doc_percent\":0.0029995574,\"key\":\"BD\"},{\"doc_count\":360,\"doc_percent\":0.0029503843,\"key\":\"GY421\"},{\"doc_count\":360,\"doc_percent\":0.0029503843,\"key\":\"GZ41\"},{\"doc_count\":358,\"doc_percent\":0.0029339932,\"key\":\"YZ21\"},{\"doc_count\":357,\"doc_percent\":0.0029257978,\"key\":\"HK33\"},{\"doc_count\":344,\"doc_percent\":0.0028192562,\"key\":\"TS21\"},{\"doc_count\":341,\"doc_percent\":0.0027946697,\"key\":\"UNKNOWN\"},{\"doc_count\":340,\"doc_percent\":0.002786474,\"key\":\"ZZ31\"},{\"doc_count\":330,\"doc_percent\":0.002704519,\"key\":\"LY224\"},{\"doc_count\":329,\"doc_percent\":0.0026963234,\"key\":\"LZ213\"},{\"doc_count\":326,\"doc_percent\":0.002671737,\"key\":\"HHHT\"},{\"doc_count\":312,\"doc_percent\":0.0025569997,\"key\":\"LF23\"},{\"doc_count\":312,\"doc_percent\":0.0025569997,\"key\":\"ST\"},{\"doc_count\":289,\"doc_percent\":0.002368503,\"key\":\"ZB\"},{\"doc_count\":288,\"doc_percent\":0.0023603076,\"key\":\"PY\"},{\"doc_count\":277,\"doc_percent\":0.0022701568,\"key\":\"WLMQ\"},{\"doc_count\":276,\"doc_percent\":0.0022619613,\"key\":\"JL22\"},{\"doc_count\":274,\"doc_percent\":0.0022455703,\"key\":\"GL\"},{\"doc_count\":260,\"doc_percent\":0.0021308332,\"key\":\"HY221\"},{\"doc_count\":259,\"doc_percent\":0.0021226376,\"key\":\"JN322\"},{\"doc_count\":255,\"doc_percent\":0.0020898555,\"key\":\"LY42\"},{\"doc_count\":249,\"doc_percent\":0.0020406826,\"key\":\"CZ1\"},{\"doc_count\":239,\"doc_percent\":0.0019587274,\"key\":\"LZ31\"},{\"doc_count\":238,\"doc_percent\":0.0019505318,\"key\":\"BT\"},{\"doc_count\":238,\"doc_percent\":0.0019505318,\"key\":\"HZ212\"},{\"doc_count\":232,\"doc_percent\":0.0019013588,\"key\":\"HA223\"},{\"doc_count\":219,\"doc_percent\":0.0017948172,\"key\":\"WH22\"},{\"doc_count\":213,\"doc_percent\":0.0017456441,\"key\":\"YC22\"},{\"doc_count\":212,\"doc_percent\":0.0017374486,\"key\":\"TA\"},{\"doc_count\":212,\"doc_percent\":0.0017374486,\"key\":\"WH132\"},{\"doc_count\":210,\"doc_percent\":0.0017210576,\"key\":\"ZJ412\"},{\"doc_count\":208,\"doc_percent\":0.0017046665,\"key\":\"XX\"},{\"doc_count\":205,\"doc_percent\":0.00168008,\"key\":\"JY22\"},{\"doc_count\":203,\"doc_percent\":0.0016636889,\"key\":\"HD21\"},{\"doc_count\":193,\"doc_percent\":0.0015817338,\"key\":\"LZ211\"},{\"doc_count\":193,\"doc_percent\":0.0015817338,\"key\":\"YC212\"},{\"doc_count\":179,\"doc_percent\":0.0014669966,\"key\":\"LYG\"},{\"doc_count\":177,\"doc_percent\":0.0014506057,\"key\":\"MAS\"},{\"doc_count\":175,\"doc_percent\":0.0014342146,\"key\":\"KF\"},{\"doc_count\":175,\"doc_percent\":0.0014342146,\"key\":\"XY122\"},{\"doc_count\":174,\"doc_percent\":0.0014260191,\"key\":\"LA\"},{\"doc_count\":172,\"doc_percent\":0.0014096281,\"key\":\"ZQ\"},{\"doc_count\":171,\"doc_percent\":0.0014014326,\"key\":\"DQ\"},{\"doc_count\":171,\"doc_percent\":0.0014014326,\"key\":\"QHD\"},{\"doc_count\":170,\"doc_percent\":0.001393237,\"key\":\"AS11\"},{\"doc_count\":169,\"doc_percent\":0.0013850415,\"key\":\"DY12\"},{\"doc_count\":168,\"doc_percent\":0.001376846,\"key\":\"LC22\"},{\"doc_count\":165,\"doc_percent\":0.0013522595,\"key\":\"YX\"}],\"createtime\":0,\"device\":[{\"doc_count\":100045,\"doc_percent\":0.81992,\"key\":\"PC\"},{\"doc_count\":15647,\"doc_percent\":0.12823518,\"key\":\"Mobile\"},{\"doc_count\":5336,\"doc_percent\":0.043731254,\"key\":\"Tablet\"},{\"doc_count\":990,\"doc_percent\":0.0081135575,\"key\":\"UNKNOWN\"}],\"gender\":[{\"doc_count\":68770,\"doc_percent\":0.56360537,\"key\":\"m\"},{\"doc_count\":28639,\"doc_percent\":0.23471127,\"key\":\"f\"},{\"doc_count\":24609,\"doc_percent\":0.20168336,\"key\":\"UNKNOWN\"}],\"interest\":[{\"doc_count\":111264,\"doc_percent\":0.9118655,\"en_name\":\"Home
        // &
        // Lifestyle\",\"key\":\"27\",\"zh_cn_name\":\"家居生活\"},{\"doc_count\":110592,\"doc_percent\":0.90635806,\"en_name\":\"Arts
        // &
        // Entertainment\",\"key\":\"31\",\"zh_cn_name\":\"娱乐\"},{\"doc_count\":110550,\"doc_percent\":0.90601385,\"en_name\":\"Health
        // &
        // Wellness\",\"key\":\"15\",\"zh_cn_name\":\"健康医疗\"},{\"doc_count\":104503,\"doc_percent\":0.8564556,\"en_name\":\"Food
        // &
        // Drink\",\"key\":\"26\",\"zh_cn_name\":\"食品美食\"},{\"doc_count\":102249,\"doc_percent\":0.8379829,\"en_name\":\"Pets\",\"key\":\"2703\",\"zh_cn_name\":\"宠物\"},{\"doc_count\":99899,\"doc_percent\":0.81872344,\"en_name\":\"Culture\",\"key\":\"11\",\"zh_cn_name\":\"文化艺术\"},{\"doc_count\":99000,\"doc_percent\":0.8113557,\"en_name\":\"Psychology\",\"key\":\"1501\",\"zh_cn_name\":\"情感心理\"},{\"doc_count\":93635,\"doc_percent\":0.7673868,\"en_name\":\"Jobs
        // &
        // Education\",\"key\":\"12\",\"zh_cn_name\":\"教育培训\"},{\"doc_count\":89220,\"doc_percent\":0.7312036,\"en_name\":\"Leisure
        // Travel & Business
        // Travel\",\"key\":\"25\",\"zh_cn_name\":\"旅游商旅\"},{\"doc_count\":86131,\"doc_percent\":0.7058877,\"en_name\":\"Restaurants\",\"key\":\"2603\",\"zh_cn_name\":\"餐馆美食\"},{\"doc_count\":84138,\"doc_percent\":0.689554,\"en_name\":\"Automobiles\",\"key\":\"17\",\"zh_cn_name\":\"汽车\"},{\"doc_count\":82440,\"doc_percent\":0.675638,\"en_name\":\"Private
        // School\",\"key\":\"1208\",\"zh_cn_name\":\"私立学校\"},{\"doc_count\":80197,\"doc_percent\":0.6572555,\"en_name\":\"Travel
        // Destination\",\"key\":\"2502\",\"zh_cn_name\":\"旅游目的地\"},{\"doc_count\":76379,\"doc_percent\":0.625965,\"en_name\":\"Comics
        // &
        // Animation\",\"key\":\"3104\",\"zh_cn_name\":\"动画漫画\"},{\"doc_count\":73832,\"doc_percent\":0.60509104,\"en_name\":\"Humanities
        // &
        // Arts\",\"key\":\"1104\",\"zh_cn_name\":\"人文艺术\"},{\"doc_count\":73295,\"doc_percent\":0.60069007,\"en_name\":\"Sports
        // &
        // Fitness\",\"key\":\"18\",\"zh_cn_name\":\"运动健身\"},{\"doc_count\":72831,\"doc_percent\":0.59688735,\"en_name\":\"Personal
        // Finance\",\"key\":\"21\",\"zh_cn_name\":\"金融财经\"},{\"doc_count\":69383,\"doc_percent\":0.5686292,\"en_name\":\"Overseas
        // Education\",\"key\":\"1202\",\"zh_cn_name\":\"留学移民\"},{\"doc_count\":65689,\"doc_percent\":0.538355,\"en_name\":\"Furniture
        // Decoration\",\"key\":\"2701\",\"zh_cn_name\":\"家居家装\"},{\"doc_count\":65615,\"doc_percent\":0.5377485,\"en_name\":\"Consulting
        // &
        // Services\",\"key\":\"22\",\"zh_cn_name\":\"咨询及服务\"},{\"doc_count\":64163,\"doc_percent\":0.5258486,\"en_name\":\"Baby
        // &
        // Maternity\",\"key\":\"20\",\"zh_cn_name\":\"母婴育儿\"},{\"doc_count\":64033,\"doc_percent\":0.52478325,\"en_name\":\"Maternity
        // &
        // Parenting\",\"key\":\"2001\",\"zh_cn_name\":\"母婴用品\"},{\"doc_count\":63836,\"doc_percent\":0.5231687,\"en_name\":\"Car
        // Type\",\"key\":\"1712\",\"zh_cn_name\":\"车型\"},{\"doc_count\":61798,\"doc_percent\":0.50646627,\"en_name\":\"Primary
        // Middle & High
        // School\",\"key\":\"120803\",\"zh_cn_name\":\"私立中学\"},{\"doc_count\":60647,\"doc_percent\":0.49703324,\"en_name\":\"Beauty
        // &
        // Cosmetics\",\"key\":\"16\",\"zh_cn_name\":\"美容及化妆品\"},{\"doc_count\":60647,\"doc_percent\":0.49703324,\"en_name\":\"Japan
        // / Korea (Travel)\",\"key\":\"250203\",\"zh_cn_name\":\"日本 /
        // 韩国旅游\"},{\"doc_count\":59241,\"doc_percent\":0.48551035,\"en_name\":\"Car
        // Manufacturer
        // Country\",\"key\":\"1711\",\"zh_cn_name\":\"生产国家\"},{\"doc_count\":58691,\"doc_percent\":0.4810028,\"en_name\":\"Pop
        // Music\",\"key\":\"3106\",\"zh_cn_name\":\"流行音乐\"},{\"doc_count\":57867,\"doc_percent\":0.4742497,\"en_name\":\"Wedding
        // Services\",\"key\":\"2201\",\"zh_cn_name\":\"婚庆\"},{\"doc_count\":56843,\"doc_percent\":0.4658575,\"en_name\":\"TV
        // Dramas\",\"key\":\"3103\",\"zh_cn_name\":\"网络影视剧\"},{\"doc_count\":56823,\"doc_percent\":0.4656936,\"en_name\":\"Skin
        // Care\",\"key\":\"1601\",\"zh_cn_name\":\"护肤\"},{\"doc_count\":56595,\"doc_percent\":0.46382502,\"en_name\":\"Movies\",\"key\":\"3102\",\"zh_cn_name\":\"院线电影\"},{\"doc_count\":55655,\"doc_percent\":0.45612124,\"en_name\":\"Culture/Literature\",\"key\":\"1102\",\"zh_cn_name\":\"文化文学\"},{\"doc_count\":55503,\"doc_percent\":0.4548755,\"en_name\":\"Insurance\",\"key\":\"2101\",\"zh_cn_name\":\"保险\"},{\"doc_count\":55328,\"doc_percent\":0.4534413,\"en_name\":\"Private
        // Primary
        // School\",\"key\":\"120802\",\"zh_cn_name\":\"私立小学\"},{\"doc_count\":53798,\"doc_percent\":0.44090217,\"en_name\":\"Japan
        // & Korea
        // (Car)\",\"key\":\"171101\",\"zh_cn_name\":\"日本韩国车\"},{\"doc_count\":51536,\"doc_percent\":0.4223639,\"en_name\":\"Alcohol\",\"key\":\"30\",\"zh_cn_name\":\"酒类\"},{\"doc_count\":50698,\"doc_percent\":0.41549608,\"en_name\":\"Hotels
        // &
        // Accommodations\",\"key\":\"2501\",\"zh_cn_name\":\"酒店\"},{\"doc_count\":49757,\"doc_percent\":0.4077841,\"en_name\":\"Female
        // Fashion\",\"key\":\"24\",\"zh_cn_name\":\"时尚\"},{\"doc_count\":49361,\"doc_percent\":0.40453866,\"en_name\":\"Sexual
        // Health\",\"key\":\"1504\",\"zh_cn_name\":\"两性健康\"},{\"doc_count\":49277,\"doc_percent\":0.40385026,\"en_name\":\"Domestic
        // Appliance\",\"key\":\"2702\",\"zh_cn_name\":\"家用电器\"},{\"doc_count\":48557,\"doc_percent\":0.3979495,\"en_name\":\"Variety
        // &
        // Entertainment\",\"key\":\"3101\",\"zh_cn_name\":\"娱乐综艺\"},{\"doc_count\":48476,\"doc_percent\":0.39728564,\"en_name\":\"Make-Up/Cosmetics\",\"key\":\"1603\",\"zh_cn_name\":\"彩妆\"},{\"doc_count\":46071,\"doc_percent\":0.37757543,\"en_name\":\"Outdoor
        // Sports\",\"key\":\"1802\",\"zh_cn_name\":\"户外\"},{\"doc_count\":45914,\"doc_percent\":0.37628874,\"en_name\":\"Germany
        // (Car)\",\"key\":\"171102\",\"zh_cn_name\":\"德国车\"},{\"doc_count\":45764,\"doc_percent\":0.37505943,\"en_name\":\"Overseas
        // Education
        // Application\",\"key\":\"120202\",\"zh_cn_name\":\"留学申请\"},{\"doc_count\":41755,\"doc_percent\":0.34220362,\"en_name\":\"Healthcare\",\"key\":\"1503\",\"zh_cn_name\":\"保健养生\"},{\"doc_count\":41490,\"doc_percent\":0.3400318,\"en_name\":\"MPV\",\"key\":\"171208\",\"zh_cn_name\":\"多功能车\"},{\"doc_count\":41280,\"doc_percent\":0.33831075,\"en_name\":\"Cosmetic
        // Procedures\",\"key\":\"1502\",\"zh_cn_name\":\"整形整容\"},{\"doc_count\":39636,\"doc_percent\":0.32483733,\"en_name\":\"Fresh
        // Food\",\"key\":\"2605\",\"zh_cn_name\":\"生鲜食品\"},{\"doc_count\":39522,\"doc_percent\":0.32390302,\"en_name\":\"Real
        // Estate &
        // Construction\",\"key\":\"2103\",\"zh_cn_name\":\"房地产及建筑\"},{\"doc_count\":38997,\"doc_percent\":0.31960037,\"en_name\":\"Clothing\",\"key\":\"2401\",\"zh_cn_name\":\"服装\"},{\"doc_count\":38766,\"doc_percent\":0.3177072,\"en_name\":\"Healthy
        // Food\",\"key\":\"2604\",\"zh_cn_name\":\"保健食品\"},{\"doc_count\":38549,\"doc_percent\":0.3159288,\"en_name\":\"Sports
        // Events\",\"key\":\"1803\",\"zh_cn_name\":\"体育赛事\"},{\"doc_count\":37723,\"doc_percent\":0.3091593,\"en_name\":\"Wine\",\"key\":\"3002\",\"zh_cn_name\":\"葡萄酒\"},{\"doc_count\":37564,\"doc_percent\":0.30785623,\"en_name\":\"Cooking
        // &
        // Recipes\",\"key\":\"2601\",\"zh_cn_name\":\"烹饪和菜谱\"},{\"doc_count\":36550,\"doc_percent\":0.29954597,\"en_name\":\"Baby
        // Bedding\",\"key\":\"200109\",\"zh_cn_name\":\"婴儿寝具\"},{\"doc_count\":34886,\"doc_percent\":0.28590864,\"en_name\":\"Investing\",\"key\":\"2102\",\"zh_cn_name\":\"投资理财\"},{\"doc_count\":34666,\"doc_percent\":0.28410563,\"en_name\":\"Overseas
        // Education
        // Destination\",\"key\":\"120203\",\"zh_cn_name\":\"留学移民国家\"},{\"doc_count\":33438,\"doc_percent\":0.27404153,\"en_name\":\"Eye
        // Makeup\",\"key\":\"160302\",\"zh_cn_name\":\"眼部彩妆\"},{\"doc_count\":31732,\"doc_percent\":0.26005998,\"en_name\":\"SEA
        // (Travel)\",\"key\":\"250202\",\"zh_cn_name\":\"东南亚旅游\"},{\"doc_count\":29568,\"doc_percent\":0.2423249,\"en_name\":\"SUV\",\"key\":\"171204\",\"zh_cn_name\":\"越野车\"},{\"doc_count\":29524,\"doc_percent\":0.2419643,\"en_name\":\"Fitness\",\"key\":\"1801\",\"zh_cn_name\":\"健身\"},{\"doc_count\":29488,\"doc_percent\":0.24166927,\"en_name\":\"Australia
        // & New Zealand (Travel)\",\"key\":\"250206\",\"zh_cn_name\":\"大洋洲旅游
        // （澳洲 &
        // 新西兰）\"},{\"doc_count\":28811,\"doc_percent\":0.2361209,\"en_name\":\"Bodycare\",\"key\":\"160110\",\"zh_cn_name\":\"身体护肤\"},{\"doc_count\":28750,\"doc_percent\":0.23562098,\"en_name\":\"Country
        // of
        // Origin\",\"key\":\"300207\",\"zh_cn_name\":\"产地\"},{\"doc_count\":28487,\"doc_percent\":0.23346555,\"en_name\":\"Mid-End
        // Cars\",\"key\":\"1702\",\"zh_cn_name\":\"中档汽车\"},{\"doc_count\":27611,\"doc_percent\":0.22628629,\"en_name\":\"China
        // (Car)\",\"key\":\"171104\",\"zh_cn_name\":\"国产车\"},{\"doc_count\":27500,\"doc_percent\":0.22537659,\"en_name\":\"Makeup
        // Tools\",\"key\":\"160305\",\"zh_cn_name\":\"美发护发\"},{\"doc_count\":26308,\"doc_percent\":0.21560754,\"en_name\":\"United
        // States
        // (Car)\",\"key\":\"171103\",\"zh_cn_name\":\"美国车\"},{\"doc_count\":26147,\"doc_percent\":0.21428806,\"en_name\":\"High-End
        // Cars\",\"key\":\"1701\",\"zh_cn_name\":\"高档汽车\"},{\"doc_count\":25952,\"doc_percent\":0.21268994,\"en_name\":\"Luxury
        // Cars\",\"key\":\"1710\",\"zh_cn_name\":\"豪华汽车\"},{\"doc_count\":25325,\"doc_percent\":0.20755135,\"en_name\":\"Imported
        // Wine\",\"key\":\"3003\",\"zh_cn_name\":\"洋酒\"},{\"doc_count\":25202,\"doc_percent\":0.2065433,\"en_name\":\"Private
        // Kindergarten\",\"key\":\"120801\",\"zh_cn_name\":\"私立幼儿园\"},{\"doc_count\":24838,\"doc_percent\":0.20356013,\"en_name\":\"Luxury
        // Hotel\",\"key\":\"250101\",\"zh_cn_name\":\"奢华酒店\"},{\"doc_count\":24828,\"doc_percent\":0.20347817,\"en_name\":\"Asset
        // Management\",\"key\":\"210202\",\"zh_cn_name\":\"投资和资产管理\"},{\"doc_count\":24752,\"doc_percent\":0.20285532,\"en_name\":\"Sedan\",\"key\":\"171201\",\"zh_cn_name\":\"三厢车\"},{\"doc_count\":24681,\"doc_percent\":0.20227343,\"en_name\":\"Europe
        // (Travel)\",\"key\":\"250204\",\"zh_cn_name\":\"欧洲旅游\"},{\"doc_count\":24265,\"doc_percent\":0.1988641,\"en_name\":\"Coupe\",\"key\":\"171202\",\"zh_cn_name\":\"轿跑车\"},{\"doc_count\":23963,\"doc_percent\":0.19638906,\"en_name\":\"Sports
        // Car\",\"key\":\"171209\",\"zh_cn_name\":\"跑车\"},{\"doc_count\":23925,\"doc_percent\":0.19607763,\"en_name\":\"Baby
        // Feeding\",\"key\":\"200102\",\"zh_cn_name\":\"喂养用品\"},{\"doc_count\":23614,\"doc_percent\":0.19352883,\"en_name\":\"Hatchback\",\"key\":\"171203\",\"zh_cn_name\":\"两厢车\"},{\"doc_count\":23571,\"doc_percent\":0.19317642,\"en_name\":\"Auto
        // Insurance\",\"key\":\"1708\",\"zh_cn_name\":\"汽车保险\"},{\"doc_count\":23469,\"doc_percent\":0.19234048,\"en_name\":\"Station
        // Wagon\",\"key\":\"171205\",\"zh_cn_name\":\"旅行车\"},{\"doc_count\":23416,\"doc_percent\":0.19190611,\"en_name\":\"Eyecare\",\"key\":\"160109\",\"zh_cn_name\":\"眼部护理\"},{\"doc_count\":23403,\"doc_percent\":0.19179957,\"en_name\":\"Rental
        // Cars\",\"key\":\"1706\",\"zh_cn_name\":\"汽车租赁\"},{\"doc_count\":23346,\"doc_percent\":0.19133243,\"en_name\":\"Baby
        // Care\",\"key\":\"200106\",\"zh_cn_name\":\"婴幼护理\"},{\"doc_count\":23315,\"doc_percent\":0.19107836,\"en_name\":\"Designers
        // &
        // Collections\",\"key\":\"2403\",\"zh_cn_name\":\"奢侈品\"},{\"doc_count\":23185,\"doc_percent\":0.19001295,\"en_name\":\"Hong
        // Kong,Macau and Singapore
        // (Travel)\",\"key\":\"250207\",\"zh_cn_name\":\"港澳游\"},{\"doc_count\":22954,\"doc_percent\":0.18811978,\"en_name\":\"Lip
        // Color\",\"key\":\"160303\",\"zh_cn_name\":\"唇部彩妆\"},{\"doc_count\":22873,\"doc_percent\":0.18745595,\"en_name\":\"Gin\",\"key\":\"300307\",\"zh_cn_name\":\"杜松子酒\"},{\"doc_count\":22679,\"doc_percent\":0.18586601,\"en_name\":\"Real
        // Estate\",\"key\":\"210304\",\"zh_cn_name\":\"楼盘\"},{\"doc_count\":22612,\"doc_percent\":0.18531692,\"en_name\":\"Hydration\",\"key\":\"160102\",\"zh_cn_name\":\"补水保湿\"},{\"doc_count\":22589,\"doc_percent\":0.18512842,\"en_name\":\"Anti-anging
        // /
        // Wrinkles\",\"key\":\"160101\",\"zh_cn_name\":\"抗衰老去皱\"},{\"doc_count\":22586,\"doc_percent\":0.18510383,\"en_name\":\"Cleansing
        // & Makeup
        // Removal\",\"key\":\"160105\",\"zh_cn_name\":\"清洁卸妆\"},{\"doc_count\":22410,\"doc_percent\":0.18366143,\"en_name\":\"Face
        // Makeup\",\"key\":\"160301\",\"zh_cn_name\":\"面部彩妆\"},{\"doc_count\":22286,\"doc_percent\":0.18264519,\"en_name\":\"Mother's
        // Goods\",\"key\":\"200105\",\"zh_cn_name\":\"妈妈用品\"},{\"doc_count\":22169,\"doc_percent\":0.18168631,\"en_name\":\"Brightening
        // &
        // Whitening\",\"key\":\"160103\",\"zh_cn_name\":\"美白提亮祛斑\"},{\"doc_count\":22085,\"doc_percent\":0.18099788,\"en_name\":\"Men's
        // Skincare\",\"key\":\"160106\",\"zh_cn_name\":\"男士护肤\"},{\"doc_count\":21961,\"doc_percent\":0.17998165,\"en_name\":\"Cocktail\",\"key\":\"300304\",\"zh_cn_name\":\"鸡尾酒\"}],\"province\":[{\"doc_count\":21852,\"doc_percent\":0.17908832,\"key\":\"CN_BJ\"},{\"doc_count\":15470,\"doc_percent\":0.12678458,\"key\":\"CN_GD\"},{\"doc_count\":10670,\"doc_percent\":0.087446116,\"key\":\"CN_SH\"},{\"doc_count\":8630,\"doc_percent\":0.07072727,\"key\":\"CN_JS\"},{\"doc_count\":7686,\"doc_percent\":0.0629907,\"key\":\"CN_ZJ\"},{\"doc_count\":5578,\"doc_percent\":0.04571457,\"key\":\"CN_SD\"},{\"doc_count\":3903,\"doc_percent\":0.031987082,\"key\":\"CN_LN\"},{\"doc_count\":3885,\"doc_percent\":0.031839564,\"key\":\"CN_HE\"},{\"doc_count\":3825,\"doc_percent\":0.031347834,\"key\":\"CN_HU\"},{\"doc_count\":3554,\"doc_percent\":0.02912685,\"key\":\"CN_SC\"},{\"doc_count\":3386,\"doc_percent\":0.027750004,\"key\":\"CN_FJ\"},{\"doc_count\":2930,\"doc_percent\":0.02401285,\"key\":\"CN_HB\"},{\"doc_count\":2901,\"doc_percent\":0.02377518,\"key\":\"CN_AH\"},{\"doc_count\":2650,\"doc_percent\":0.021718107,\"key\":\"CN_HN\"},{\"doc_count\":2462,\"doc_percent\":0.020177351,\"key\":\"CN_JX\"},{\"doc_count\":2203,\"doc_percent\":0.018054713,\"key\":\"CN_GX\"},{\"doc_count\":1981,\"doc_percent\":0.016235309,\"key\":\"CN_TJ\"},{\"doc_count\":1719,\"doc_percent\":0.014088085,\"key\":\"CN_SA\"},{\"doc_count\":1567,\"doc_percent\":0.012842367,\"key\":\"CN_HL\"},{\"doc_count\":1442,\"doc_percent\":0.011817928,\"key\":\"CN_CQ\"},{\"doc_count\":1425,\"doc_percent\":0.011678604,\"key\":\"CN_IN_US\"},{\"doc_count\":1273,\"doc_percent\":0.010432887,\"key\":\"CN_JL\"},{\"doc_count\":1238,\"doc_percent\":0.010146044,\"key\":\"CN_SX\"},{\"doc_count\":1098,\"doc_percent\":0.0089986725,\"key\":\"CN_YN\"},{\"doc_count\":1021,\"doc_percent\":0.008367618,\"key\":\"CN_NM\"},{\"doc_count\":795,\"doc_percent\":0.006515432,\"key\":\"CN_GZ\"},{\"doc_count\":721,\"doc_percent\":0.005908964,\"key\":\"HK\"},{\"doc_count\":560,\"doc_percent\":0.004589487,\"key\":\"CN_HA\"},{\"doc_count\":530,\"doc_percent\":0.0043436214,\"key\":\"CN_GS\"},{\"doc_count\":522,\"doc_percent\":0.0042780573,\"key\":\"CN_IN_GB\"},{\"doc_count\":520,\"doc_percent\":0.0042616664,\"key\":\"CN_XJ\"},{\"doc_count\":499,\"doc_percent\":0.0040895604,\"key\":\"CN_IN_CA\"},{\"doc_count\":472,\"doc_percent\":0.0038682818,\"key\":\"TW\"},{\"doc_count\":376,\"doc_percent\":0.0030815126,\"key\":\"CN_IN_AU\"},{\"doc_count\":341,\"doc_percent\":0.0027946697,\"key\":\"CN_UNKNOWN\"},{\"doc_count\":254,\"doc_percent\":0.00208166,\"key\":\"CN_IN_SG\"},{\"doc_count\":246,\"doc_percent\":0.002016096,\"key\":\"CN_IN_UK\"},{\"doc_count\":207,\"doc_percent\":0.001696471,\"key\":\"CN_NX\"},{\"doc_count\":168,\"doc_percent\":0.001376846,\"key\":\"CN_IN_JP\"},{\"doc_count\":153,\"doc_percent\":0.0012539134,\"key\":\"CN_IN_MY\"},{\"doc_count\":135,\"doc_percent\":0.0011063941,\"key\":\"CN_QH\"},{\"doc_count\":107,\"doc_percent\":8.769198E-4,\"key\":\"CN_IN_DE\"},{\"doc_count\":98,\"doc_percent\":8.031602E-4,\"key\":\"CN_IN_CN\"},{\"doc_count\":91,\"doc_percent\":7.457916E-4,\"key\":\"CN_IN_NZ\"},{\"doc_count\":89,\"doc_percent\":7.294006E-4,\"key\":\"CN_IN_KR\"},{\"doc_count\":69,\"doc_percent\":5.6549034E-4,\"key\":\"CN_IN_FR\"},{\"doc_count\":60,\"doc_percent\":4.9173075E-4,\"key\":\"CN_XZ\"},{\"doc_count\":50,\"doc_percent\":4.0977562E-4,\"key\":\"MO\"},{\"doc_count\":49,\"doc_percent\":4.015801E-4,\"key\":\"CN_IN_NL\"},{\"doc_count\":40,\"doc_percent\":3.2782048E-4,\"key\":\"CN_IN_TH\"},{\"doc_count\":33,\"doc_percent\":2.704519E-4,\"key\":\"CN_IN_ES\"},{\"doc_count\":30,\"doc_percent\":2.4586538E-4,\"key\":\"CN_IN_RU\"},{\"doc_count\":29,\"doc_percent\":2.3766985E-4,\"key\":\"CN_IN_VN\"},{\"doc_count\":28,\"doc_percent\":2.2947435E-4,\"key\":\"CN_IN_IT\"},{\"doc_count\":23,\"doc_percent\":1.8849678E-4,\"key\":\"CN_IN_PH\"},{\"doc_count\":23,\"doc_percent\":1.8849678E-4,\"key\":\"CN_IN_SE\"},{\"doc_count\":20,\"doc_percent\":1.6391024E-4,\"key\":\"CN_IN_CH\"},{\"doc_count\":19,\"doc_percent\":1.5571473E-4,\"key\":\"CN_IN_BR\"},{\"doc_count\":19,\"doc_percent\":1.5571473E-4,\"key\":\"CN_IN_ID\"},{\"doc_count\":19,\"doc_percent\":1.5571473E-4,\"key\":\"CN_IN_KH\"},{\"doc_count\":17,\"doc_percent\":1.393237E-4,\"key\":\"CN_IN_DK\"},{\"doc_count\":14,\"doc_percent\":1.1473717E-4,\"key\":\"CN_IN_IE\"},{\"doc_count\":12,\"doc_percent\":9.834614E-5,\"key\":\"CN_IN_BD\"},{\"doc_count\":12,\"doc_percent\":9.834614E-5,\"key\":\"CN_IN_FI\"},{\"doc_count\":10,\"doc_percent\":8.195512E-5,\"key\":\"CN_IN_IN\"},{\"doc_count\":10,\"doc_percent\":8.195512E-5,\"key\":\"CN_IN_RO\"},{\"doc_count\":9,\"doc_percent\":7.375961E-5,\"key\":\"CN_IN_AE\"},{\"doc_count\":9,\"doc_percent\":7.375961E-5,\"key\":\"CN_IN_BE\"},{\"doc_count\":9,\"doc_percent\":7.375961E-5,\"key\":\"CN_IN_NO\"},{\"doc_count\":8,\"doc_percent\":6.55641E-5,\"key\":\"CN_IN_EG\"},{\"doc_count\":6,\"doc_percent\":4.917307E-5,\"key\":\"CN_IN_AR\"},{\"doc_count\":6,\"doc_percent\":4.917307E-5,\"key\":\"CN_IN_AT\"},{\"doc_count\":6,\"doc_percent\":4.917307E-5,\"key\":\"CN_IN_IQ\"},{\"doc_count\":6,\"doc_percent\":4.917307E-5,\"key\":\"CN_IN_MX\"},{\"doc_count\":6,\"doc_percent\":4.917307E-5,\"key\":\"CN_IN_PK\"},{\"doc_count\":5,\"doc_percent\":4.097756E-5,\"key\":\"CN_IN_HU\"},{\"doc_count\":5,\"doc_percent\":4.097756E-5,\"key\":\"CN_IN_LK\"},{\"doc_count\":5,\"doc_percent\":4.097756E-5,\"key\":\"CN_IN_PE\"},{\"doc_count\":5,\"doc_percent\":4.097756E-5,\"key\":\"CN_IN_SA\"},{\"doc_count\":5,\"doc_percent\":4.097756E-5,\"key\":\"CN_IN_TR\"},{\"doc_count\":4,\"doc_percent\":3.278205E-5,\"key\":\"CN_IN_BG\"},{\"doc_count\":4,\"doc_percent\":3.278205E-5,\"key\":\"CN_IN_CO\"},{\"doc_count\":4,\"doc_percent\":3.278205E-5,\"key\":\"CN_IN_KZ\"},{\"doc_count\":4,\"doc_percent\":3.278205E-5,\"key\":\"CN_IN_MA\"},{\"doc_count\":4,\"doc_percent\":3.278205E-5,\"key\":\"CN_IN_PL\"},{\"doc_count\":4,\"doc_percent\":3.278205E-5,\"key\":\"CN_IN_SI\"},{\"doc_count\":4,\"doc_percent\":3.278205E-5,\"key\":\"CN_IN_VE\"},{\"doc_count\":3,\"doc_percent\":2.4586536E-5,\"key\":\"CN_IN_AZ\"},{\"doc_count\":3,\"doc_percent\":2.4586536E-5,\"key\":\"CN_IN_BN\"},{\"doc_count\":3,\"doc_percent\":2.4586536E-5,\"key\":\"CN_IN_DZ\"},{\"doc_count\":3,\"doc_percent\":2.4586536E-5,\"key\":\"CN_IN_GH\"},{\"doc_count\":3,\"doc_percent\":2.4586536E-5,\"key\":\"CN_IN_GR\"},{\"doc_count\":3,\"doc_percent\":2.4586536E-5,\"key\":\"CN_IN_LU\"},{\"doc_count\":3,\"doc_percent\":2.4586536E-5,\"key\":\"CN_IN_MM\"},{\"doc_count\":3,\"doc_percent\":2.4586536E-5,\"key\":\"CN_IN_PT\"},{\"doc_count\":2,\"doc_percent\":1.6391024E-5,\"key\":\"CN_IN_AO\"},{\"doc_count\":2,\"doc_percent\":1.6391024E-5,\"key\":\"CN_IN_BH\"},{\"doc_count\":2,\"doc_percent\":1.6391024E-5,\"key\":\"CN_IN_CD\"},{\"doc_count\":2,\"doc_percent\":1.6391024E-5,\"key\":\"CN_IN_CZ\"},{\"doc_count\":2,\"doc_percent\":1.6391024E-5,\"key\":\"CN_IN_EC\"}],\"raw_interest\":[{\"doc_count\":80476,\"doc_percent\":0.659542,\"en_name\":\"Food
        // &
        // Drink\",\"key\":\"26\",\"zh_cn_name\":\"食品美食\"},{\"doc_count\":75680,\"doc_percent\":0.62023634,\"en_name\":\"Arts
        // &
        // Entertainment\",\"key\":\"31\",\"zh_cn_name\":\"娱乐\"},{\"doc_count\":63066,\"doc_percent\":0.51685816,\"en_name\":\"Restaurants\",\"key\":\"2603\",\"zh_cn_name\":\"餐馆美食\"},{\"doc_count\":48143,\"doc_percent\":0.39455655,\"en_name\":\"TV
        // Dramas\",\"key\":\"3103\",\"zh_cn_name\":\"网络影视剧\"},{\"doc_count\":46663,\"doc_percent\":0.3824272,\"en_name\":\"Pop
        // Music\",\"key\":\"3106\",\"zh_cn_name\":\"流行音乐\"},{\"doc_count\":43124,\"doc_percent\":0.35342327,\"en_name\":\"Variety
        // &
        // Entertainment\",\"key\":\"3101\",\"zh_cn_name\":\"娱乐综艺\"},{\"doc_count\":40859,\"doc_percent\":0.33486044,\"en_name\":\"Health
        // &
        // Wellness\",\"key\":\"15\",\"zh_cn_name\":\"健康医疗\"},{\"doc_count\":35173,\"doc_percent\":0.28826076,\"en_name\":\"Personal
        // Finance\",\"key\":\"21\",\"zh_cn_name\":\"金融财经\"},{\"doc_count\":34251,\"doc_percent\":0.2807045,\"en_name\":\"Jobs
        // &
        // Education\",\"key\":\"12\",\"zh_cn_name\":\"教育培训\"},{\"doc_count\":34201,\"doc_percent\":0.28029472,\"en_name\":\"Leisure
        // Travel & Business
        // Travel\",\"key\":\"25\",\"zh_cn_name\":\"旅游商旅\"},{\"doc_count\":33620,\"doc_percent\":0.2755331,\"en_name\":\"Movies\",\"key\":\"3102\",\"zh_cn_name\":\"院线电影\"},{\"doc_count\":33012,\"doc_percent\":0.27055025,\"en_name\":\"Female
        // Fashion\",\"key\":\"24\",\"zh_cn_name\":\"时尚\"},{\"doc_count\":32054,\"doc_percent\":0.26269895,\"en_name\":\"Automobiles\",\"key\":\"17\",\"zh_cn_name\":\"汽车\"},{\"doc_count\":27487,\"doc_percent\":0.22527005,\"en_name\":\"Sports
        // &
        // Fitness\",\"key\":\"18\",\"zh_cn_name\":\"运动健身\"},{\"doc_count\":27422,\"doc_percent\":0.22473733,\"en_name\":\"Travel
        // Destination\",\"key\":\"2502\",\"zh_cn_name\":\"旅游目的地\"},{\"doc_count\":25072,\"doc_percent\":0.20547788,\"en_name\":\"Overseas
        // Education\",\"key\":\"1202\",\"zh_cn_name\":\"留学移民\"},{\"doc_count\":24739,\"doc_percent\":0.20274878,\"en_name\":\"Home
        // &
        // Lifestyle\",\"key\":\"27\",\"zh_cn_name\":\"家居生活\"},{\"doc_count\":24656,\"doc_percent\":0.20206855,\"en_name\":\"Car
        // Type\",\"key\":\"1712\",\"zh_cn_name\":\"车型\"},{\"doc_count\":24597,\"doc_percent\":0.20158501,\"en_name\":\"Culture\",\"key\":\"11\",\"zh_cn_name\":\"文化艺术\"},{\"doc_count\":23975,\"doc_percent\":0.1964874,\"en_name\":\"Investing\",\"key\":\"2102\",\"zh_cn_name\":\"投资理财\"},{\"doc_count\":20531,\"doc_percent\":0.16826206,\"en_name\":\"Sports
        // Events\",\"key\":\"1803\",\"zh_cn_name\":\"体育赛事\"},{\"doc_count\":19881,\"doc_percent\":0.16293497,\"en_name\":\"Clothing\",\"key\":\"2401\",\"zh_cn_name\":\"服装\"},{\"doc_count\":19414,\"doc_percent\":0.15910767,\"en_name\":\"Psychology\",\"key\":\"1501\",\"zh_cn_name\":\"情感心理\"},{\"doc_count\":18089,\"doc_percent\":0.14824861,\"en_name\":\"Shoes
        // &
        // Bags\",\"key\":\"2404\",\"zh_cn_name\":\"鞋包\"},{\"doc_count\":17426,\"doc_percent\":0.142815,\"en_name\":\"Designers
        // &
        // Collections\",\"key\":\"2403\",\"zh_cn_name\":\"奢侈品\"},{\"doc_count\":17409,\"doc_percent\":0.14267567,\"en_name\":\"Beauty
        // &
        // Cosmetics\",\"key\":\"16\",\"zh_cn_name\":\"美容及化妆品\"},{\"doc_count\":16971,\"doc_percent\":0.13908604,\"en_name\":\"Cooking
        // &
        // Recipes\",\"key\":\"2601\",\"zh_cn_name\":\"烹饪和菜谱\"},{\"doc_count\":16120,\"doc_percent\":0.13211165,\"en_name\":\"Asset
        // Management\",\"key\":\"210202\",\"zh_cn_name\":\"投资和资产管理\"},{\"doc_count\":15892,\"doc_percent\":0.13024308,\"en_name\":\"Fresh
        // Food\",\"key\":\"2605\",\"zh_cn_name\":\"生鲜食品\"},{\"doc_count\":15855,\"doc_percent\":0.12993984,\"en_name\":\"Comics
        // &
        // Animation\",\"key\":\"3104\",\"zh_cn_name\":\"动画漫画\"},{\"doc_count\":15647,\"doc_percent\":0.12823518,\"en_name\":\"Culture/Literature\",\"key\":\"1102\",\"zh_cn_name\":\"文化文学\"},{\"doc_count\":15155,\"doc_percent\":0.12420299,\"en_name\":\"Car
        // Manufacturer
        // Country\",\"key\":\"1711\",\"zh_cn_name\":\"生产国家\"},{\"doc_count\":15063,\"doc_percent\":0.123449,\"en_name\":\"Real
        // Estate &
        // Construction\",\"key\":\"2103\",\"zh_cn_name\":\"房地产及建筑\"},{\"doc_count\":14841,\"doc_percent\":0.121629596,\"en_name\":\"Cosmetic
        // Procedures\",\"key\":\"1502\",\"zh_cn_name\":\"整形整容\"},{\"doc_count\":14565,\"doc_percent\":0.11936764,\"en_name\":\"Pets\",\"key\":\"2703\",\"zh_cn_name\":\"宠物\"},{\"doc_count\":14249,\"doc_percent\":0.11677785,\"en_name\":\"Skin
        // Care\",\"key\":\"1601\",\"zh_cn_name\":\"护肤\"},{\"doc_count\":14210,\"doc_percent\":0.11645823,\"en_name\":\"Overseas
        // Education
        // Destination\",\"key\":\"120203\",\"zh_cn_name\":\"留学移民国家\"},{\"doc_count\":14188,\"doc_percent\":0.116277926,\"en_name\":\"Consulting
        // &
        // Services\",\"key\":\"22\",\"zh_cn_name\":\"咨询及服务\"},{\"doc_count\":11797,\"doc_percent\":0.09668246,\"en_name\":\"SUV\",\"key\":\"171204\",\"zh_cn_name\":\"越野车\"},{\"doc_count\":11079,\"doc_percent\":0.09079808,\"en_name\":\"Make-Up/Cosmetics\",\"key\":\"1603\",\"zh_cn_name\":\"彩妆\"},{\"doc_count\":11018,\"doc_percent\":0.09029815,\"en_name\":\"Fitness\",\"key\":\"1801\",\"zh_cn_name\":\"健身\"},{\"doc_count\":11006,\"doc_percent\":0.090199806,\"en_name\":\"Van\",\"key\":\"171206\",\"zh_cn_name\":\"面包车\"},{\"doc_count\":10794,\"doc_percent\":0.08846236,\"en_name\":\"Baby
        // &
        // Maternity\",\"key\":\"20\",\"zh_cn_name\":\"母婴育儿\"},{\"doc_count\":10727,\"doc_percent\":0.08791326,\"en_name\":\"Sexual
        // Health\",\"key\":\"1504\",\"zh_cn_name\":\"两性健康\"},{\"doc_count\":10521,\"doc_percent\":0.08622498,\"en_name\":\"Healthcare\",\"key\":\"1503\",\"zh_cn_name\":\"保健养生\"},{\"doc_count\":10421,\"doc_percent\":0.08540543,\"en_name\":\"Maternity
        // &
        // Parenting\",\"key\":\"2001\",\"zh_cn_name\":\"母婴用品\"},{\"doc_count\":10353,\"doc_percent\":0.084848136,\"en_name\":\"Private
        // School\",\"key\":\"1208\",\"zh_cn_name\":\"私立学校\"},{\"doc_count\":10052,\"doc_percent\":0.082381286,\"en_name\":\"Wedding
        // Services\",\"key\":\"2201\",\"zh_cn_name\":\"婚庆\"},{\"doc_count\":9884,\"doc_percent\":0.08100444,\"en_name\":\"Japan
        // / Korea (Travel)\",\"key\":\"250203\",\"zh_cn_name\":\"日本 /
        // 韩国旅游\"},{\"doc_count\":9717,\"doc_percent\":0.07963579,\"en_name\":\"Hong
        // Kong,Macau and Singapore
        // (Travel)\",\"key\":\"250207\",\"zh_cn_name\":\"港澳游\"},{\"doc_count\":9568,\"doc_percent\":0.07841466,\"en_name\":\"Hotels
        // &
        // Accommodations\",\"key\":\"2501\",\"zh_cn_name\":\"酒店\"},{\"doc_count\":8976,\"doc_percent\":0.07356292,\"en_name\":\"Personal
        // Loan &
        // Mortgage\",\"key\":\"210201\",\"zh_cn_name\":\"个人贷款\"},{\"doc_count\":8852,\"doc_percent\":0.072546676,\"en_name\":\"Drinks\",\"key\":\"2607\",\"zh_cn_name\":\"饮料\"},{\"doc_count\":8435,\"doc_percent\":0.06912915,\"en_name\":\"Brightening
        // &
        // Whitening\",\"key\":\"160103\",\"zh_cn_name\":\"美白提亮祛斑\"},{\"doc_count\":8367,\"doc_percent\":0.06857185,\"en_name\":\"Germany
        // (Car)\",\"key\":\"171102\",\"zh_cn_name\":\"德国车\"},{\"doc_count\":7450,\"doc_percent\":0.061056565,\"en_name\":\"High-End
        // Cars\",\"key\":\"1701\",\"zh_cn_name\":\"高档汽车\"},{\"doc_count\":7263,\"doc_percent\":0.059524003,\"en_name\":\"Mid-End
        // Cars\",\"key\":\"1702\",\"zh_cn_name\":\"中档汽车\"},{\"doc_count\":7113,\"doc_percent\":0.058294676,\"en_name\":\"Luxury
        // Cars\",\"key\":\"1710\",\"zh_cn_name\":\"豪华汽车\"},{\"doc_count\":6667,\"doc_percent\":0.05463948,\"en_name\":\"Entry-Level
        // Cars\",\"key\":\"1703\",\"zh_cn_name\":\"入门级汽车\"},{\"doc_count\":6530,\"doc_percent\":0.053516693,\"en_name\":\"United
        // States
        // (Car)\",\"key\":\"171103\",\"zh_cn_name\":\"美国车\"},{\"doc_count\":6438,\"doc_percent\":0.052762706,\"en_name\":\"Japan
        // & Korea
        // (Car)\",\"key\":\"171101\",\"zh_cn_name\":\"日本韩国车\"},{\"doc_count\":6435,\"doc_percent\":0.05273812,\"en_name\":\"Online
        // Literature\",\"key\":\"1101\",\"zh_cn_name\":\"网络小说\"},{\"doc_count\":6425,\"doc_percent\":0.052656166,\"en_name\":\"Primary
        // Middle & High
        // School\",\"key\":\"120803\",\"zh_cn_name\":\"私立中学\"},{\"doc_count\":6419,\"doc_percent\":0.052606992,\"en_name\":\"Furniture
        // Decoration\",\"key\":\"2701\",\"zh_cn_name\":\"家居家装\"},{\"doc_count\":6284,\"doc_percent\":0.0515006,\"en_name\":\"Jewelry/Accessories\",\"key\":\"2402\",\"zh_cn_name\":\"首饰饰品\"},{\"doc_count\":6259,\"doc_percent\":0.05129571,\"en_name\":\"Australia
        // & New Zealand (Travel)\",\"key\":\"250206\",\"zh_cn_name\":\"大洋洲旅游
        // （澳洲 &
        // 新西兰）\"},{\"doc_count\":6257,\"doc_percent\":0.051279318,\"en_name\":\"Alcohol\",\"key\":\"30\",\"zh_cn_name\":\"酒类\"},{\"doc_count\":6200,\"doc_percent\":0.050812174,\"en_name\":\"Japan
        // & Korea
        // (Education)\",\"key\":\"12020304\",\"zh_cn_name\":\"留学移民日韩\"},{\"doc_count\":6124,\"doc_percent\":0.050189316,\"en_name\":\"Snacks\",\"key\":\"2602\",\"zh_cn_name\":\"休闲食品\"},{\"doc_count\":5893,\"doc_percent\":0.048296154,\"en_name\":\"Hong
        // Kong,Macau and Singapore
        // (Education)\",\"key\":\"12020305\",\"zh_cn_name\":\"留学移民港澳新\"},{\"doc_count\":5764,\"doc_percent\":0.04723893,\"en_name\":\"Domestic
        // Appliance\",\"key\":\"2702\",\"zh_cn_name\":\"家用电器\"},{\"doc_count\":5584,\"doc_percent\":0.04576374,\"en_name\":\"Face
        // Makeup\",\"key\":\"160301\",\"zh_cn_name\":\"面部彩妆\"},{\"doc_count\":5452,\"doc_percent\":0.044681933,\"en_name\":\"Lip
        // Color\",\"key\":\"160303\",\"zh_cn_name\":\"唇部彩妆\"},{\"doc_count\":5446,\"doc_percent\":0.04463276,\"en_name\":\"Humanities
        // &
        // Arts\",\"key\":\"1104\",\"zh_cn_name\":\"人文艺术\"},{\"doc_count\":5397,\"doc_percent\":0.04423118,\"en_name\":\"North
        // America
        // (Travel)\",\"key\":\"250201\",\"zh_cn_name\":\"北美旅游\"},{\"doc_count\":5339,\"doc_percent\":0.04375584,\"en_name\":\"Acne
        // Removing\",\"key\":\"160107\",\"zh_cn_name\":\"祛痘\"},{\"doc_count\":5290,\"doc_percent\":0.043354258,\"en_name\":\"Sedan\",\"key\":\"171201\",\"zh_cn_name\":\"三厢车\"},{\"doc_count\":5263,\"doc_percent\":0.04313298,\"en_name\":\"Property
        // Management\",\"key\":\"210303\",\"zh_cn_name\":\"物业管理\"},{\"doc_count\":5188,\"doc_percent\":0.042518318,\"en_name\":\"MPV\",\"key\":\"171208\",\"zh_cn_name\":\"多功能车\"},{\"doc_count\":5134,\"doc_percent\":0.04207576,\"en_name\":\"Anti-anging
        // /
        // Wrinkles\",\"key\":\"160101\",\"zh_cn_name\":\"抗衰老去皱\"},{\"doc_count\":5104,\"doc_percent\":0.041829895,\"en_name\":\"Makeup
        // Tools\",\"key\":\"160305\",\"zh_cn_name\":\"美发护发\"},{\"doc_count\":5020,\"doc_percent\":0.041141473,\"en_name\":\"Early
        // Childhood
        // Education\",\"key\":\"1205\",\"zh_cn_name\":\"早教幼教\"},{\"doc_count\":4991,\"doc_percent\":0.0409038,\"en_name\":\"SEA
        // (Travel)\",\"key\":\"250202\",\"zh_cn_name\":\"东南亚旅游\"},{\"doc_count\":4606,\"doc_percent\":0.03774853,\"en_name\":\"China
        // (Car)\",\"key\":\"171104\",\"zh_cn_name\":\"国产车\"},{\"doc_count\":4483,\"doc_percent\":0.03674048,\"en_name\":\"Used
        // Cars\",\"key\":\"1705\",\"zh_cn_name\":\"二手车\"},{\"doc_count\":4272,\"doc_percent\":0.03501123,\"en_name\":\"Baby
        // Care\",\"key\":\"200106\",\"zh_cn_name\":\"婴幼护理\"},{\"doc_count\":4240,\"doc_percent\":0.03474897,\"en_name\":\"Local
        // Food\",\"key\":\"2606\",\"zh_cn_name\":\"地方特产\"},{\"doc_count\":4165,\"doc_percent\":0.03413431,\"en_name\":\"Australia
        // & New Zealand
        // (Education)\",\"key\":\"12020303\",\"zh_cn_name\":\"留学移民澳洲\"},{\"doc_count\":4115,\"doc_percent\":0.03372453,\"en_name\":\"Sports
        // Car\",\"key\":\"171209\",\"zh_cn_name\":\"跑车\"},{\"doc_count\":3895,\"doc_percent\":0.03192152,\"en_name\":\"Baby
        // Food\",\"key\":\"200104\",\"zh_cn_name\":\"幼儿食品\"},{\"doc_count\":3890,\"doc_percent\":0.031880543,\"en_name\":\"High-end
        // Hotel\",\"key\":\"250102\",\"zh_cn_name\":\"高级酒店\"},{\"doc_count\":3736,\"doc_percent\":0.030618433,\"en_name\":\"Cleansing
        // & Makeup
        // Removal\",\"key\":\"160105\",\"zh_cn_name\":\"清洁卸妆\"},{\"doc_count\":3571,\"doc_percent\":0.029266173,\"en_name\":\"Property
        // Development\",\"key\":\"210301\",\"zh_cn_name\":\"开发商\"},{\"doc_count\":3571,\"doc_percent\":0.029266173,\"en_name\":\"Real
        // Estate\",\"key\":\"210304\",\"zh_cn_name\":\"楼盘\"},{\"doc_count\":3498,\"doc_percent\":0.0286679,\"en_name\":\"Careers\",\"key\":\"2202\",\"zh_cn_name\":\"招聘求职\"},{\"doc_count\":3490,\"doc_percent\":0.028602337,\"en_name\":\"Coupe\",\"key\":\"171202\",\"zh_cn_name\":\"轿跑车\"},{\"doc_count\":3483,\"doc_percent\":0.028544968,\"en_name\":\"Eyecare\",\"key\":\"160109\",\"zh_cn_name\":\"眼部护理\"},{\"doc_count\":3445,\"doc_percent\":0.02823354,\"en_name\":\"Europe
        // (Travel)\",\"key\":\"250204\",\"zh_cn_name\":\"欧洲旅游\"},{\"doc_count\":3443,\"doc_percent\":0.028217148,\"en_name\":\"Retail
        // Banking\",\"key\":\"210204\",\"zh_cn_name\":\"银行零售服务\"},{\"doc_count\":3436,\"doc_percent\":0.02815978,\"en_name\":\"Private
        // Primary
        // School\",\"key\":\"120802\",\"zh_cn_name\":\"私立小学\"}],\"total\":122018}}";
        String jsonStr = "";
        List<ComparisonComposition> list = new ArrayList<>();
        ComparisonComposition comparisonComposition = JSON.parseObject(jsonStr, ComparisonComposition.class);
        list.add(comparisonComposition);
        String brand = "肯德基";
        List<String> otherBrandList = new ArrayList<>();
        otherBrandList.add("麦当劳,汉堡王");
        // otherBrandList.add("快餐");
        // otherBrandList.add("吉野家");
        List<BubbleChart> bubbleCharRowList = ConvertToReportDataUtils.getBubbleChart(list, brand, otherBrandList);
        System.out.println(bubbleCharRowList.toString());

        List<AudienceChart> getBubbleChart = ConvertToReportDataUtils.getAudienceChartList(list, brand, otherBrandList,
                null, null, null, Locale.ENGLISH,null);
        System.out.println(getBubbleChart.toString());
    }

}
