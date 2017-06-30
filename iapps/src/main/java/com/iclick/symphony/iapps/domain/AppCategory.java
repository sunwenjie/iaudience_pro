package com.iclick.symphony.iapps.domain;

import java.io.Serializable;
import javax.persistence.*;

import java.util.HashSet;
import java.util.Set;


/**
 * The persistent class for the app_category database table.
 * 
 */
@Entity
@Table(name="app_category")
@NamedQuery(name="AppCategory.findAll", query="SELECT a FROM AppCategory a")
public class AppCategory implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;

	private Boolean enabled;

	private String name;

	//bi-directional many-to-one association to AppInfo
	//,cascade={CascadeType.REFRESH},fetch=FetchType.LAZY
	@OneToMany(mappedBy="appCategory")
	@OrderBy("id DESC")
	private Set<AppInfo> appInfos;

	public AppCategory() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Boolean getEnabled() {
		return this.enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Set<AppInfo> getAppInfos() {
		return this.appInfos;
	}

	public void setAppInfos(Set<AppInfo> appInfos) {
		this.appInfos = appInfos;
	}

	public AppInfo addAppInfo(AppInfo appInfo) {
		getAppInfos().add(appInfo);
		appInfo.setAppCategory(this);

		return appInfo;
	}

	public AppInfo removeAppInfo(AppInfo appInfo) {
		getAppInfos().remove(appInfo);
		appInfo.setAppCategory(null);

		return appInfo;
	}

}