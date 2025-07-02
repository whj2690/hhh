package com.crm.service;

import com.crm.entity.User;
import java.util.List;

public interface UserService {
    User login(String username, String password);
    
    User getUserById(Long id);
    
    void updateProfile(User user);
    
    void changePassword(Long userId, String oldPassword, String newPassword);
    
    void register(User user);
    
    void updateUser(User user);
    
    void deleteUser(Long id);
    
    User getUserByUsername(String username);
    
    List<User> getAllUsers();
    
    boolean checkUsername(String username);
    
    void updatePassword(Long id, String oldPassword, String newPassword);
} 