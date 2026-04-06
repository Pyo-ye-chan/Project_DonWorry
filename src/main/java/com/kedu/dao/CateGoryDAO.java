package com.kedu.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kedu.dto.CateGoryDTO;

@Repository
public class CateGoryDAO {

	
	@Autowired
    private JdbcTemplate jdbc;
	
	public List<CateGoryDTO> getUpperCategories() {
        String sql = "SELECT * FROM job_categories WHERE parent_id IS NULL ORDER BY cat_id";
        
        return jdbc.query(sql, (rs, rowNum) -> {
            CateGoryDTO dto = new CateGoryDTO();
            dto.setCat_id(rs.getInt("cat_id"));
            dto.setParent_id(rs.getObject("parent_id") != null ? rs.getInt("parent_id") : null);
            dto.setCat_name(rs.getString("cat_name"));
            return dto;
        });
    }
	
	public List<CateGoryDTO> getSubCategories(int parentId) {
	    String sql = "SELECT * FROM job_categories WHERE parent_id = ? ORDER BY cat_id";
	    
	    return jdbc.query(sql, (rs, rowNum) -> {
	        CateGoryDTO dto = new CateGoryDTO();
	        dto.setCat_id(rs.getInt("cat_id"));
	        dto.setParent_id(rs.getInt("parent_id"));
	        dto.setCat_name(rs.getString("cat_name"));
	        return dto;
	    }, parentId);
	}
	
}
