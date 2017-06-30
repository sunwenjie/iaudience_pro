package com.iclick.symphony.iaudience.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "interest_structure")
public class InterestStructure{
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	
	@Column(name="name_en",nullable=false)
	private String nameEn;
	
	@Column(name="name_cn",nullable=false)
	private String nameCn;
	
	@Column(name="status",nullable=false)
	private int status;
//	
//	private int childId ;
//	
//	private String childNameCn;
//	
//	private String childNameEn;
	
	
	public Integer getId() {
		return id;
	}

	public InterestStructure() {
		super();
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	public String getNameEn() {
		return nameEn;
	}

	public void setNameEn(String nameEn) {
		this.nameEn = nameEn;
	}

	public String getNameCn() {
		return nameCn;
	}

	public void setNameCn(String nameCn) {
		this.nameCn = nameCn;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
//
//	public int getChildId() {
//		return childId;
//	}
//
//	public void setChildId(int childId) {
//		this.childId = childId;
//	}
//
//	public String getChildNameCn() {
//		return childNameCn;
//	}
//
//	public void setChildNameCn(String childNameCn) {
//		this.childNameCn = childNameCn;
//	}
//
//	public String getChildNameEn() {
//		return childNameEn;
//	}
//
//	public void setChildNameEn(String childNameEn) {
//		this.childNameEn = childNameEn;
//	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		InterestStructure other = (InterestStructure) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "audiencePlan [id=" + id + ", nameEn=" + nameEn + ", nameCn=" + nameCn 
				+ ", status=" + status + "]";
	}
}
