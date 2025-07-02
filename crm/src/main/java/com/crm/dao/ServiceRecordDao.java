package com.crm.dao;

import com.crm.entity.ServiceRecord;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;

@Mapper
public interface ServiceRecordDao {
    
    @Select("SELECT * FROM service_record ORDER BY create_time DESC")
    @Results({
        @Result(property = "customer", column = "customer_id", 
            one = @One(select = "com.crm.dao.CustomerDao.findById")),
        @Result(property = "createUser", column = "create_user_id",
            one = @One(select = "com.crm.dao.UserDao.findById"))
    })
    List<ServiceRecord> findAll();
    
    @Select("<script>" +
            "SELECT * FROM service_record WHERE 1=1" +
            "<if test='customerId != null'> AND customer_id = #{customerId}</if>" +
            "<if test='type != null and type != \"\"'> AND type = #{type}</if>" +
            "<if test='status != null and status != \"\"'> AND status = #{status}</if>" +
            "<if test='handleUserId != null'> AND handle_user_id = #{handleUserId}</if>" +
            "<if test='startDate != null'> AND DATE(create_time) >= #{startDate}</if>" +
            "<if test='endDate != null'> AND DATE(create_time) &lt;= #{endDate}</if>" +
            " ORDER BY create_time DESC" +
            "</script>")
    @Results({
        @Result(property = "customer", column = "customer_id", 
            one = @One(select = "com.crm.dao.CustomerDao.findById")),
        @Result(property = "createUser", column = "create_user_id",
            one = @One(select = "com.crm.dao.UserDao.findById"))
    })
    List<ServiceRecord> findByCondition(Map<String, Object> params);
    
    @Select("SELECT * FROM service_record WHERE id = #{id}")
    @Results({
        @Result(property = "customer", column = "customer_id", 
            one = @One(select = "com.crm.dao.CustomerDao.findById")),
        @Result(property = "createUser", column = "create_user_id",
            one = @One(select = "com.crm.dao.UserDao.findById"))
    })
    ServiceRecord findById(Long id);
    
    @Insert("INSERT INTO service_record(customer_id, type, status, title, content, " +
            "create_user_id, create_time) VALUES(#{customerId}, #{type}, " +
            "'待处理', #{title}, #{content}, #{createUserId}, NOW())")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(ServiceRecord record);
    
    @Update("UPDATE service_record SET type=#{type}, title=#{title}, " +
            "content=#{content} WHERE id=#{id}")
    int update(ServiceRecord record);
    
    @Delete("DELETE FROM service_record WHERE id = #{id}")
    int delete(Long id);
    
    @Update("UPDATE service_record SET status = #{status}, " +
            "<if test='status == \"处理中\"'>handle_time = NOW(),</if>" +
            "<if test='status == \"已完成\"'>finish_time = NOW(),</if>" +
            "handle_user_id = #{handleUserId} " +
            "WHERE id = #{id}")
    int updateStatus(@Param("id") Long id, 
                    @Param("status") String status, 
                    @Param("handleUserId") Long handleUserId);
    
    @Update("UPDATE service_record SET solution = #{solution}, " +
            "status = '已完成', finish_time = NOW() WHERE id = #{id}")
    int completeSolution(@Param("id") Long id, @Param("solution") String solution);
    
    @Update("UPDATE service_record SET satisfaction = #{satisfaction} WHERE id = #{id}")
    int updateSatisfaction(@Param("id") Long id, @Param("satisfaction") Integer satisfaction);
    
    // 统计相关查询
    @Select("SELECT COUNT(*) FROM service_record")
    int getServiceCount();
    
    @Select("SELECT status, COUNT(*) as count FROM service_record GROUP BY status")
    List<Map<String, Object>> countByStatus();
    
    @Select("SELECT type, COUNT(*) as count FROM service_record GROUP BY type")
    List<Map<String, Object>> countByType();
    
    @Select("SELECT satisfaction, COUNT(*) as count FROM service_record " +
            "WHERE satisfaction IS NOT NULL GROUP BY satisfaction")
    List<Map<String, Object>> countBySatisfaction();
    
    @Select("SELECT AVG(TIMESTAMPDIFF(HOUR, create_time, finish_time)) " +
            "FROM service_record WHERE status = '已完成'")
    Double getAvgHandleTime();
} 