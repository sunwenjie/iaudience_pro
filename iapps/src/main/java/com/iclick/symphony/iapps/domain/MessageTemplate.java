package com.iclick.symphony.iapps.domain;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the message_template database table.
 * 
 */
@Entity
@Table(name="message_template")
@NamedQuery(name="MessageTemplate.findAll", query="SELECT m FROM MessageTemplate m")
public class MessageTemplate implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;

	private String content;

	private String locale;

	private String title;
	
	@Column(name="message_code")
	private String messageCode;

	@Column(name="module_id")
	private Integer moduleId;

	public MessageTemplate() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getContent() {
		return this.content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getLocale() {
		return this.locale;
	}

	public void setLocale(String locale) {
		this.locale = locale;
	}

	public String getTitle() {
		return this.title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

    public Integer getModuleId() {
        return moduleId;
    }

    public void setModuleId(Integer moduleId) {
        this.moduleId = moduleId;
    }

    public String getMessageCode() {
        return messageCode;
    }

    public void setMessageCode(String messageCode) {
        this.messageCode = messageCode;
    }
}