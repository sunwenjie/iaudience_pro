package com.iclick.symphony.iaudience.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "iau_event_info")
@NamedQuery(name = "EventInfo.findAll", query = "SELECT i FROM EventInfo i")
public class EventInfo {

    @Id
    private int id;

    @Column(name = "event_name")
    private String eventName;
    
    @Column(name = "client_id")
    private int clientId;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEventName() {
		return eventName;
	}

	public void setEventName(String eventName) {
		this.eventName = eventName;
	}

	public int getClientId() {
		return clientId;
	}

	public void setClientId(int clientId) {
		this.clientId = clientId;
	}
}
