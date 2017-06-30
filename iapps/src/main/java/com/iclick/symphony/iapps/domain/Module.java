package com.iclick.symphony.iapps.domain;

import java.io.Serializable;
import javax.persistence.*;
import java.util.Set;


/**
 * The persistent class for the module database table.
 * 
 */
@Entity
@Table(name="module")
@NamedQuery(name="Module.findAll", query="SELECT m FROM Module m")
public class Module implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;

	private String name;

	private Boolean visible;

	//bi-directional many-to-many association to AppInfo
	@ManyToMany
	@JoinTable(
		name="app_module_relation"
		, joinColumns={
			@JoinColumn(name="module_id")
			}
		, inverseJoinColumns={
			@JoinColumn(name="app_id")
			}
		)
	private Set<AppInfo> appInfos;

	public Module() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Boolean getVisible() {
		return this.visible;
	}

	public void setVisible(Boolean visible) {
		this.visible = visible;
	}

	public Set<AppInfo> getAppInfos() {
		return this.appInfos;
	}

	public void setAppInfos(Set<AppInfo> appInfos) {
		this.appInfos = appInfos;
	}
}