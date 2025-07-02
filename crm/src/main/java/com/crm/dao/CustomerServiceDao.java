package com.crm.dao;

import com.crm.entity.CustomerService;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;

@Mapper
public interface CustomerServiceDao {
    List<CustomerService> findAll();
    
    List<CustomerService> findByCondition(@Param("customerId") Long customerId,
                                        @Param("type") String type,
                                        @Param("status") String status);
    
    CustomerService findById(Long id);
    
    int insert(CustomerService service);
    
    int update(CustomerService service);
    
    int delete(Long id);
    
    int updateStatus(@Param("id") Long id, @Param("status") String status);
    
    int updateHandler(@Param("id") Long id, @Param("handler") String handler);
    
    int updateResult(@Param("id") Long id, 
                    @Param("result") String result, 
                    @Param("satisfaction") Integer satisfaction);
    
    // 获取服务工单总数
    @Select("SELECT COUNT(*) FROM service_record")
    int getServiceCount();
    
    // 获取待处理工单数
    @Select("SELECT COUNT(*) FROM service_record WHERE status = '待处理'")
    int getPendingCount();
    
    // 获取本月工单数
    @Select("SELECT COUNT(*) FROM service_record WHERE DATE_FORMAT(create_time,'%Y%m') = DATE_FORMAT(NOW(),'%Y%m')")
    int getMonthlyServiceCount();
    
    // 统计服务满意度分布
    @Select("SELECT satisfaction, COUNT(*) as count FROM service_record WHERE satisfaction IS NOT NULL GROUP BY satisfaction")
    Map<String, Integer> countBySatisfaction();
} 