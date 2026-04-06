package com.kedu.dto;

public class CateGoryDTO {
	private int cat_id;      // 카테고리 고유 번호
    private Integer parent_id; // 부모 ID (null 허용이라 Integer)
    private String cat_name; // 카테고리 이름
    
	public CateGoryDTO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CateGoryDTO(int cat_id, Integer parent_id, String cat_name) {
		super();
		this.cat_id = cat_id;
		this.parent_id = parent_id;
		this.cat_name = cat_name;
	}
	public int getCat_id() {
		return cat_id;
	}
	public void setCat_id(int cat_id) {
		this.cat_id = cat_id;
	}
	public Integer getParent_id() {
		return parent_id;
	}
	public void setParent_id(Integer parent_id) {
		this.parent_id = parent_id;
	}
	public String getCat_name() {
		return cat_name;
	}
	public void setCat_name(String cat_name) {
		this.cat_name = cat_name;
	}
    
    
    
}
