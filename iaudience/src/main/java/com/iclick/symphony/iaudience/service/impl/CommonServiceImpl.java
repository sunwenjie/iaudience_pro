package com.iclick.symphony.iaudience.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.iclick.symphony.iaudience.dao.BrandRepository;
import com.iclick.symphony.iaudience.dao.InterestStructureRepository;
import com.iclick.symphony.iaudience.dao.LocationRepository;
import com.iclick.symphony.iaudience.dao.ProductRepository;
import com.iclick.symphony.iaudience.entity.Brand;
import com.iclick.symphony.iaudience.entity.InterestStructure;
import com.iclick.symphony.iaudience.entity.LocationProvince;
import com.iclick.symphony.iaudience.entity.Product;
import com.iclick.symphony.iaudience.model.Interest;
import com.iclick.symphony.iaudience.model.common.Option;
import com.iclick.symphony.iaudience.service.CommonService;
import com.iclick.symphony.iaudience.util.Constant;

@Service
public class CommonServiceImpl implements CommonService {
	@Autowired
	private LocationRepository locationRepository;

	@Autowired
	private InterestStructureRepository interestRepository;

	@Autowired
	private ProductRepository productRepository;

	@Autowired
	private BrandRepository brandRepository;

	protected Logger log = LoggerFactory.getLogger(this.getClass());

	@Transactional(propagation = Propagation.REQUIRED)
	public List<Option> getRegionOptionList(Locale locale) {
		if (Locale.ENGLISH.equals(locale)) {
			return this.getProvinceNameCnList();
		}
		return this.getProvinceNameCnList();
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public List<Option> getAgeGroupOptionList(Locale locale) {
		return this.getOptionFromArray(Constant.AGEGROUP);
	}

	private List<Option> getOptionFromArray(String[] args) {
		if (args == null) {
			return new ArrayList<Option>();
		}
		List<Option> ageGroupList = new ArrayList<>(Constant.AGEGROUP.length);

		for (int i = 0; i < Constant.AGEGROUP.length; i++) {
			ageGroupList.add(new Option(Constant.AGEGROUP[i], String.valueOf(i)));
		}
		return ageGroupList;
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public List<LocationProvince> getProvinceList() {
		return locationRepository.findProvinceList();
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public List<Option> getProvinceNameCnList() {
		List<Option> optionList = new ArrayList<Option>();
		List<LocationProvince> rows = locationRepository.findProvinceList();
		for (LocationProvince row : rows) {
			optionList.add(new Option(row.getProvinceNameCn(), String.valueOf(row.getProvinceId())));
		}
		return optionList;
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public List<Option> getProvinceNameEnList() {
		List<Option> optionList = new ArrayList<Option>();
		List<LocationProvince> rows = locationRepository.findProvinceList();
		for (LocationProvince row : rows) {
			optionList.add(new Option(row.getProvinceNameEn(), String.valueOf(row.getProvinceId())));
		}
		return optionList;
	}

	@Transactional(propagation = Propagation.REQUIRED)
	@Override
	public Map<String, String> getInterestMaping(Locale locale) {
		List<InterestStructure> interestList = interestRepository.findInterestList();
		Map<String, String> interestMapping = new HashMap<>();
		String name = null;
		for (InterestStructure interest : interestList) {
			if (Locale.ENGLISH.equals(locale)) {
				name = interest.getNameEn();
			} else {
				name = interest.getNameCn();
			}
			interestMapping.put(interest.getId() + "", name);
		}
		return interestMapping;
	}

	@Transactional(propagation = Propagation.REQUIRED)
	@Override
	public List<Interest> getInterestList(Locale locale) {
		List<Interest> resultList = new ArrayList<Interest>();
		List<Interest> tempList = null;
		try {
			List<InterestStructure> interestList = interestRepository.findInterestList();

			Interest interest = null;
			Map<String, List<Interest>> subMap = new HashMap<>();
			String parentId = null;
			for (InterestStructure row : interestList) {
				interest = coverToInterest(row, locale);
				parentId = interest.getParentId();
				interest.setChildren(subMap.get(interest.getAudienceId()));

				// 顶级节点
				if ("0".equals(parentId)) {
					resultList.add(interest);
				} else {
					if (subMap.containsKey(parentId)) {
						subMap.get(parentId).add(interest);
					} else {
						tempList = new ArrayList<Interest>();
						tempList.add(interest);
						subMap.put(parentId, tempList);
					}
				}
				interest = null;
			}
		} catch (Exception e) {
		}
		return resultList;
	}

	public String getInterestName(Integer id, Locale locale) {
		InterestStructure interest = interestRepository.findOne(id);
		String name = "";
		if (Locale.ENGLISH.equals(locale)) {
			name = interest.getNameEn();
		} else {
			name = interest.getNameCn();
		}
		return name;
	}

	private Interest coverToInterest(InterestStructure row, Locale locale) {

		Interest interest = new Interest();

		if (Locale.CHINESE.equals(locale)) {
			interest.setName(row.getNameCn());
		} else {
			interest.setName(row.getNameEn());
		}
		String id = String.valueOf(row.getId());
		interest.setAudienceId(id);
		if (StringUtils.isNotBlank(id) && id.length() > 2) {
			interest.setParentId(id.substring(0, id.length() - 2));
		} else {
			interest.setParentId("0");
		}
		return interest;

	}

	public Brand getBrandById(int id) {
		return brandRepository.getOne(id);

	}

	public Product getProductById(int id) {
		return productRepository.getOne(id);

	}

}
