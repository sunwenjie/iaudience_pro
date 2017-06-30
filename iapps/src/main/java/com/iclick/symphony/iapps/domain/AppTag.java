package com.iclick.symphony.iapps.domain;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Set;


/**
 * The persistent class for the app_tag database table.
 * 
 */
@Entity
@Table(name="app_tag")
@NamedQuery(name="AppTag.findAll", query="SELECT a FROM AppTag a")
public class AppTag implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;

	private Boolean enabled;

	private String name;

	//bi-directional many-to-many association to AppInfo
	@ManyToMany
	@JoinTable(
		name="app_tag_relation"
		, joinColumns={
			@JoinColumn(name="tag_id")
			}
		, inverseJoinColumns={
			@JoinColumn(name="app_id")
			}
		)
	private Set<AppInfo> appInfos;

	public AppTag() {
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

}