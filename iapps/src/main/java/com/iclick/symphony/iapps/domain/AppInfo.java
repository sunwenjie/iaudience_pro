package com.iclick.symphony.iapps.domain;

import java.io.Serializable;
import javax.persistence.*;

import org.hibernate.annotations.BatchSize;

import java.util.Date;
import java.util.Set;


/**
 * The persistent class for the app_info database table.
 * 
 */
@Entity
@Table(name="app_info")
@NamedQuery(name="AppInfo.findAll", query="SELECT a FROM AppInfo a")
public class AppInfo implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;

	@Column(name="app_key")
	private String appKey;

	@Column(name="app_secret")
	private String appSecret;

	private Boolean del;

	@Lob
	@Basic(fetch=FetchType.LAZY)
	private String description;

	private Boolean enabled;

	private String icon;

	@Column(name="index_url")
	private String indexUrl;

	@Column(name="login_url")
	private String loginUrl;

	private String name;

	@Column(name="publisher_id")
	private Integer publisherId;

	@Column(name="register_url")
	private String registerUrl;

	private Integer stars;
	
	private Boolean featured;
	
	@Column(name="latest_version")
	private Boolean latestVersion;
	
	@Lob
	@Basic(fetch=FetchType.LAZY)
	@Column(name="update_content")
	private String updateContent;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="update_time")
	private Date updateTime;

	private String version;

	//bi-directional many-to-one association to AppCategory
	@ManyToOne
	@JoinColumn(name="category_id")
	private AppCategory appCategory;

	//bi-directional many-to-many association to AppTag
	@ManyToMany(mappedBy="appInfos")
	private Set<AppTag> appTags;

	//bi-directional many-to-many association to Module
	@ManyToMany(mappedBy="appInfos")
	private Set<Module> modules;

	//bi-directional many-to-one association to UserApp
	@OneToMany(mappedBy="appInfo")
	private Set<UserApp> userApps;

	//bi-directional many-to-one association to AppPurchaseStrategy
	//,cascade={CascadeType.REFRESH},fetch=FetchType.LAZY
	@OneToMany(mappedBy="appInfo")
	@OrderBy("price")
	private Set<AppPurchaseStrategy> appPurchaseStrategies;

	//bi-directional many-to-one association to PreviewPicture
	//,cascade={CascadeType.REFRESH},fetch=FetchType.LAZY
	@OneToMany(mappedBy="appInfo")
	@OrderBy
	private Set<PreviewPicture> previewPictures;

	public AppInfo() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAppKey() {
		return this.appKey;
	}

	public void setAppKey(String appKey) {
		this.appKey = appKey;
	}

	public String getAppSecret() {
		return this.appSecret;
	}

	public void setAppSecret(String appSecret) {
		this.appSecret = appSecret;
	}

	public Boolean getDel() {
		return this.del;
	}

	public void setDel(Boolean del) {
		this.del = del;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Boolean getEnabled() {
		return this.enabled;
	}

	public void setEnabled(Boolean enabled) {
		this.enabled = enabled;
	}

	public String getIcon() {
		return this.icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getIndexUrl() {
		return this.indexUrl;
	}

	public void setIndexUrl(String indexUrl) {
		this.indexUrl = indexUrl;
	}

	public String getLoginUrl() {
		return this.loginUrl;
	}

	public void setLoginUrl(String loginUrl) {
		this.loginUrl = loginUrl;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getPublisherId() {
		return this.publisherId;
	}

	public void setPublisherId(Integer publisherId) {
		this.publisherId = publisherId;
	}

	public String getRegisterUrl() {
		return this.registerUrl;
	}

	public void setRegisterUrl(String registerUrl) {
		this.registerUrl = registerUrl;
	}

	public Integer getStars() {
		return this.stars;
	}

	public void setStars(Integer stars) {
		this.stars = stars;
	}

	public String getUpdateContent() {
		return this.updateContent;
	}

	public void setUpdateContent(String updateContent) {
		this.updateContent = updateContent;
	}

	public Date getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getVersion() {
		return this.version;
	}

	public void setVersion(String version) {
		this.version = version;
	}
	
	public Boolean getFeatured() {
        return featured;
    }

    public void setFeatured(Boolean featured) {
        this.featured = featured;
    }

    public Boolean getLatestVersion() {
        return latestVersion;
    }

    public void setLatestVersion(Boolean latestVersion) {
        this.latestVersion = latestVersion;
    }

    public AppCategory getAppCategory() {
		return this.appCategory;
	}

	public void setAppCategory(AppCategory appCategory) {
		this.appCategory = appCategory;
	}

	public Set<AppTag> getAppTags() {
		return this.appTags;
	}

	public void setAppTags(Set<AppTag> appTags) {
		this.appTags = appTags;
	}

	public Set<Module> getModules() {
		return this.modules;
	}

	public void setModules(Set<Module> modules) {
		this.modules = modules;
	}

	public Set<UserApp> getUserApps() {
		return this.userApps;
	}

	public void setUserApps(Set<UserApp> userApps) {
		this.userApps = userApps;
	}

	public UserApp addUserApp(UserApp userApp) {
		getUserApps().add(userApp);
		userApp.setAppInfo(this);

		return userApp;
	}

	public UserApp removeUserApp(UserApp userApp) {
		getUserApps().remove(userApp);
		userApp.setAppInfo(null);

		return userApp;
	}

	public Set<AppPurchaseStrategy> getAppPurchaseStrategies() {
		return this.appPurchaseStrategies;
	}

	public void setAppPurchaseStrategies(Set<AppPurchaseStrategy> appPurchaseStrategies) {
		this.appPurchaseStrategies = appPurchaseStrategies;
	}

	public AppPurchaseStrategy addAppPurchaseStrategy(AppPurchaseStrategy appPurchaseStrategy) {
		getAppPurchaseStrategies().add(appPurchaseStrategy);
		appPurchaseStrategy.setAppInfo(this);

		return appPurchaseStrategy;
	}

	public AppPurchaseStrategy removeAppPurchaseStrategy(AppPurchaseStrategy appPurchaseStrategy) {
		getAppPurchaseStrategies().remove(appPurchaseStrategy);
		appPurchaseStrategy.setAppInfo(null);

		return appPurchaseStrategy;
	}

	public Set<PreviewPicture> getPreviewPictures() {
		return this.previewPictures;
	}

	public void setPreviewPictures(Set<PreviewPicture> previewPictures) {
		this.previewPictures = previewPictures;
	}

	public PreviewPicture addPreviewPicture(PreviewPicture previewPicture) {
		getPreviewPictures().add(previewPicture);
		previewPicture.setAppInfo(this);

		return previewPicture;
	}

	public PreviewPicture removePreviewPicture(PreviewPicture previewPicture) {
		getPreviewPictures().remove(previewPicture);
		previewPicture.setAppInfo(null);

		return previewPicture;
	}

}