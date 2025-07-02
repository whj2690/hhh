package com.crm.dao;

import com.crm.entity.SalesOpportunity;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;

@Mapper
public interface SalesOpportunityDao {
    
    @Select("SELECT o.*, c.id AS c_id, c.name AS c_name FROM sales_opportunity o LEFT JOIN customer c ON o.customer_id = c.id")
    @Results({
        @Result(property = "id", column = "id"),
        @Result(property = "customerId", column = "customer_id"),
        @Result(property = "name", column = "name"),
        @Result(property = "expectedAmount", column = "expected_amount"),
        @Result(property = "stage", column = "stage"),
        @Result(property = "successRate", column = "success_rate"),
        @Result(property = "expectedClosingDate", column = "expected_closing_date"),
        @Result(property = "description", column = "description"),
        @Result(property = "status", column = "status"),
        @Result(property = "createUserId", column = "create_user_id"),
        @Result(property = "createTime", column = "create_time"),
        @Result(property = "updateTime", column = "update_time"),
        @Result(property = "customer.id", column = "c_id"),
        @Result(property = "customer.name", column = "c_name")
    })
    List<SalesOpportunity> findAll();
    
    @Select("SELECT * FROM sales_opportunity WHERE id = #{id}")
    SalesOpportunity findById(Long id);
    
    @Select("<script>" +
            "SELECT * FROM sales_opportunity WHERE 1=1" +
            "<if test='customerId != null'> AND customer_id = #{customerId}</if>" +
            "<if test='stage != null and stage != \"\"'> AND stage = #{stage}</if>" +
            "<if test='status != null and status != \"\"'> AND status = #{status}</if>" +
            " ORDER BY create_time DESC" +
            "</script>")
    List<SalesOpportunity> findByCondition(@Param("customerId") Long customerId,
                                         @Param("stage") String stage,
                                         @Param("status") String status);
    
    @Insert("INSERT INTO sales_opportunity(customer_id, name, expected_amount, stage, " +
            "success_rate, expected_closing_date, description, status, create_user_id, create_time) " +
            "VALUES(#{customerId}, #{name}, #{expectedAmount}, #{stage}, " +
            "#{successRate}, #{expectedClosingDate}, #{description}, #{status}, #{createUserId}, NOW())")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(SalesOpportunity opportunity);
    
    @Update("UPDATE sales_opportunity SET " +
            "customer_id = #{customerId}, " +
            "name = #{name}, " +
            "expected_amount = #{expectedAmount}, " +
            "stage = #{stage}, " +
            "success_rate = #{successRate}, " +
            "expected_closing_date = #{expectedClosingDate}, " +
            "description = #{description}, " +
            "status = #{status} " +
            "WHERE id = #{id}")
    int update(SalesOpportunity opportunity);
    
    @Delete("DELETE FROM sales_opportunity WHERE id = #{id}")
    int deleteById(Long id);
    
    @Update("UPDATE sales_opportunity SET status = #{status} WHERE id = #{id}")
    int updateStatus(@Param("id") Long id, @Param("status") String status);
    
    @Select("SELECT * FROM sales_opportunity WHERE customer_id = #{customerId}")
    List<SalesOpportunity> findByCustomerId(Long customerId);
    
    // 获取销售机会总数
    @Select("SELECT COUNT(*) FROM sales_opportunity")
    int getOpportunityCount();
    
    // 获取各阶段机会数量
    @Select("SELECT stage, COUNT(*) as count FROM sales_opportunity GROUP BY stage")
    List<Map<String, Object>> countByStage();
    
    // 获取本月新增机会数
    @Select("SELECT COUNT(*) FROM sales_opportunity WHERE DATE_FORMAT(create_time,'%Y%m') = DATE_FORMAT(NOW(),'%Y%m')")
    int getNewOpportunityCount();
} 