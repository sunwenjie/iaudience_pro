package com.iclick.symphony.iaudience.model.remote;

public class Keyword {
	private String key;
	private float score;
	public float getScore() {
		return score;
	}

	public void setScore(float score) {
		this.score = score;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

    public Keyword(String key) {
        super();
        this.key = key;
    }
	
	public Keyword(){
		
	}
	
}
