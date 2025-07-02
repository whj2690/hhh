package com.crm.dao;

import com.crm.entity.SalesOrder;
import org.apache.ibatis.annotations.*;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Mapper
public interface SalesOrderDao {
    
    @Select("SELECT o.*, c.id AS c_id, c.name AS c_name FROM sales_order o LEFT JOIN customer c ON o.customer_id = c.id")
    @Results({
        @Result(property = "id", column = "id"),
        @Result(property = "orderNo", column = "order_no"),
        @Result(property = "customerId", column = "customer_id"),
        @Result(property = "opportunityId", column = "opportunity_id"),
        @Result(property = "amount", column = "amount"),
        @Result(property = "status", column = "status"),
        @Result(property = "paymentStatus", column = "payment_status"),
        @Result(property = "deliveryDate", column = "delivery_date"),
        @Result(property = "description", column = "description"),
        @Result(property = "createUserId", column = "create_user_id"),
        @Result(property = "createTime", column = "create_time"),
        @Result(property = "updateTime", column = "update_time"),
        @Result(property = "customer.id", column = "c_id"),
        @Result(property = "customer.name", column = "c_name")
    })
    List<SalesOrder> findAll();
    
    @Select("SELECT * FROM sales_order WHERE id = #{id}")
    SalesOrder findById(Long id);
    
    @Select("<script>" +
            "SELECT * FROM sales_order WHERE 1=1" +
            "<if test='customerId != null'> AND customer_id = #{customerId}</if>" +
            "<if test='status != null and status != \"\"'> AND status = #{status}</if>" +
            "<if test='paymentStatus != null and paymentStatus != \"\"'> AND payment_status = #{paymentStatus}</if>" +
            " ORDER BY create_time DESC" +
            "</script>")
    List<SalesOrder> findByCondition(@Param("customerId") Long customerId,
                                   @Param("status") String status,
                                   @Param("paymentStatus") String paymentStatus);
    
    @Insert("INSERT INTO sales_order(order_no, customer_id, opportunity_id, amount, status, " +
            "payment_status, delivery_date, description, create_user_id, create_time) " +
            "VALUES(#{orderNo}, #{customerId}, #{opportunityId}, #{amount}, #{status}, " +
            "#{paymentStatus}, #{deliveryDate}, #{description}, #{createUserId}, NOW())")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(SalesOrder order);
    
    @Update("UPDATE sales_order SET " +
            "customer_id = #{customerId}, " +
            "opportunity_id = #{opportunityId}, " +
            "amount = #{amount}, " +
            "status = #{status}, " +
            "payment_status = #{paymentStatus}, " +
            "delivery_date = #{deliveryDate}, " +
            "description = #{description} " +
            "WHERE id = #{id}")
    int update(SalesOrder order);
    
    @Delete("DELETE FROM sales_order WHERE id = #{id}")
    int deleteById(Long id);
    
    @Update("UPDATE sales_order SET status = #{status} WHERE id = #{id}")
    int updateStatus(@Param("id") Long id, @Param("status") String status);
    
    @Update("UPDATE sales_order SET payment_status = #{paymentStatus} WHERE id = #{id}")
    int updatePaymentStatus(@Param("id") Long id, @Param("paymentStatus") String paymentStatus);
    
    @Select("SELECT * FROM sales_order WHERE customer_id = #{customerId}")
    List<SalesOrder> findByCustomerId(Long customerId);
    
    @Select("SELECT * FROM sales_order WHERE opportunity_id = #{opportunityId}")
    List<SalesOrder> findByOpportunityId(Long opportunityId);
    
    // 获取订单总数
    @Select("SELECT COUNT(*) FROM sales_order")
    int getOrderCount();
    
    // 获取订单总金额
    @Select("SELECT COALESCE(SUM(amount), 0) FROM sales_order WHERE status != 'CANCELLED'")
    double getTotalAmount();
    
    // 获取各状态订单数量
    @Select("SELECT status, COUNT(*) as count FROM sales_order GROUP BY status")
    List<Map<String, Object>> countByStatus();
    
    // 获取本月新增订单数
    @Select("SELECT COUNT(*) FROM sales_order WHERE DATE_FORMAT(create_time,'%Y%m') = DATE_FORMAT(NOW(),'%Y%m')")
    int getNewOrderCount();
    
    // 生成订单编号
    @Select("SELECT CONCAT('SO', DATE_FORMAT(NOW(),'%Y%m%d'), LPAD(COALESCE(MAX(SUBSTRING(order_no,-4)),0) + 1, 4, '0')) " +
            "FROM sales_order WHERE order_no LIKE CONCAT('SO', DATE_FORMAT(NOW(),'%Y%m%d'), '%')")
    String generateOrderNo();
    
    // 获取本月订单数
    @Select("SELECT COUNT(*) FROM sales_order WHERE DATE_FORMAT(create_time,'%Y%m') = DATE_FORMAT(NOW(),'%Y%m')")
    int getMonthlyOrderCount();
    
    // 获取本月销售额
    @Select("SELECT COALESCE(SUM(amount), 0) FROM sales_order " +
            "WHERE DATE_FORMAT(create_time,'%Y%m') = DATE_FORMAT(NOW(),'%Y%m') " +
            "AND status != 'CANCELLED'")
    BigDecimal getMonthlyAmount();
    
    // 按月统计销售额
    @Select("SELECT DATE_FORMAT(create_time,'%Y-%m') as month, " +
            "COUNT(*) as count, " +
            "COALESCE(SUM(amount), 0) as amount " +
            "FROM sales_order " +
            "WHERE status != 'CANCELLED' " +
            "GROUP BY DATE_FORMAT(create_time,'%Y-%m') " +
            "ORDER BY month DESC")
    List<Map<String, Object>> getMonthlySales();
    
    // 按客户类型统计销售额
    @Select("SELECT c.type as customerType, " +
            "COUNT(*) as count, " +
            "COALESCE(SUM(o.amount), 0) as amount " +
            "FROM sales_order o " +
            "JOIN customer c ON o.customer_id = c.id " +
            "WHERE o.status != 'CANCELLED' " +
            "GROUP BY c.type")
    List<Map<String, Object>> getSalesByCustomerType();
    
    // 按产品类型统计销售额
    @Select("SELECT p.type as productType, " +
            "COUNT(*) as count, " +
            "COALESCE(SUM(od.amount), 0) as amount " +
            "FROM sales_order o " +
            "JOIN order_detail od ON o.id = od.order_id " +
            "JOIN product p ON od.product_id = p.id " +
            "WHERE o.status != 'CANCELLED' " +
            "GROUP BY p.type")
    List<Map<String, Object>> getSalesByProductType();
    
    @Select("SELECT * FROM sales_order WHERE order_no = #{orderNo}")
    SalesOrder findByOrderNo(String orderNo);
} 