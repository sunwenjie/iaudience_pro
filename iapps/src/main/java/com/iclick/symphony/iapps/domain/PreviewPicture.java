package com.iclick.symphony.iapps.domain;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the preview_pictures database table.
 * 
 */
@Entity
@Table(name="preview_pictures")
@NamedQuery(name="PreviewPicture.findAll", query="SELECT p FROM PreviewPicture p")
public class PreviewPicture implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;

	private String url;

	//bi-directional many-to-one association to AppInfo
	@ManyToOne
	@JoinColumn(name="app_id")
	private AppInfo appInfo;

	public PreviewPicture() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public AppInfo getAppInfo() {
		return this.appInfo;
	}

	public void setAppInfo(AppInfo appInfo) {
		this.appInfo = appInfo;
	}

}