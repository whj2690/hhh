package com.crm.dao;

import com.crm.entity.Customer;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;

@Mapper
public interface CustomerDao {
    
    @Select("SELECT * FROM customer")
    List<Customer> findAll();
    
    @Select("<script>" +
            "SELECT * FROM customer WHERE 1=1" +
            "<if test='name != null and name != \"\"'> AND name LIKE CONCAT('%', #{name}, '%')</if>" +
            "<if test='level != null and level != \"\"'> AND level = #{level}</if>" +
            "<if test='status != null and status != \"\"'> AND status = #{status}</if>" +
            "</script>")
    List<Customer> findByCondition(@Param("name") String name, 
                                 @Param("level") String level,
                                 @Param("status") String status);
    
    @Select("SELECT * FROM customer WHERE id = #{id}")
    Customer findById(Long id);
    
    @Insert("INSERT INTO customer(name, contact, phone, email, address, level, industry, source, status, create_user_id, create_time) " +
            "VALUES(#{name}, #{contact}, #{phone}, #{email}, #{address}, #{level}, #{industry}, #{source}, #{status}, #{createUserId}, NOW())")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(Customer customer);
    
    @Update("UPDATE customer SET " +
            "name = #{name}, " +
            "contact = #{contact}, " +
            "phone = #{phone}, " +
            "email = #{email}, " +
            "address = #{address}, " +
            "level = #{level}, " +
            "industry = #{industry}, " +
            "source = #{source}, " +
            "status = #{status}, " +
            "update_time = #{updateTime} " +
            "WHERE id = #{id}")
    int update(Customer customer);
    
    @Delete("DELETE FROM customer WHERE id = #{id}")
    int deleteById(Long id);
    
    @Update("UPDATE customer SET status = #{status} WHERE id = #{id}")
    int updateStatus(@Param("id") Long id, @Param("status") String status);
    
    // 获取客户总数
    @Select("SELECT COUNT(*) FROM customer")
    int getCustomerCount();
    
    // 按客户类型统计数量
    @Select("SELECT industry as type, COUNT(*) as count FROM customer GROUP BY industry")
    List<Map<String, Object>> countByType();
    
    // 获取本月新增客户数
    @Select("SELECT COUNT(*) FROM customer WHERE DATE_FORMAT(create_time,'%Y%m') = DATE_FORMAT(NOW(),'%Y%m')")
    int getNewCustomerCount();
} 