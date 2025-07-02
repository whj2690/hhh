package com.crm.dao;

import com.crm.entity.User;
import org.apache.ibatis.annotations.*;
import java.util.List;

@Mapper
public interface UserDao {
    
    @Select("SELECT * FROM user WHERE username = #{username} AND password = #{password}")
    User findByUsernameAndPassword(@Param("username") String username, @Param("password") String password);
    
    @Select("SELECT * FROM user WHERE username = #{username}")
    User findByUsername(String username);
    
    @Select("SELECT * FROM user WHERE id = #{id}")
    User findById(Long id);
    
    @Insert("INSERT INTO user(username, password, real_name, email, phone, role, status) " +
            "VALUES(#{username}, #{password}, #{realName}, #{email}, #{phone}, #{role}, #{status})")
    int insert(User user);
    
    @Update("UPDATE user SET real_name=#{realName}, email=#{email}, phone=#{phone}, " +
            "status=#{status} WHERE id=#{id}")
    int update(User user);
    
    @Update("UPDATE user SET password = #{newPassword} WHERE id = #{id}")
    int updatePassword(@Param("id") Long id, @Param("newPassword") String newPassword);

    @Select("SELECT * FROM user")
    List<User> findAll();
} 