package com.iclick.symphony.iaudience.model.remote;

public class SuggestionKey {
	public SuggestionKey() {
		super();
	}

	private Float score;
	private String key;
	
	public SuggestionKey(String key) {
		this.key = key;
	}

	
	public SuggestionKey(String key, Float score) {
		this.score = score;
		this.key = key;
	}

	public Float getScore() {
		return score;
	}

	public void setScore(Float score) {
		this.score = score;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	@Override
	public String toString() {
		return key + "->" + score;
	}
	
}
