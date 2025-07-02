package com.crm.service.impl;

import com.crm.dao.UserDao;
import com.crm.entity.User;
import com.crm.service.UserService;
import com.crm.util.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    
    @Autowired
    private UserDao userDao;

    @Override
    public User login(String username, String password) {
        String encryptedPassword = MD5Util.encrypt(password);
        return userDao.findByUsernameAndPassword(username, encryptedPassword);
    }

    @Override
    public User getUserById(Long id) {
        return userDao.findById(id);
    }

    @Override
    public void updateProfile(User user) {
        userDao.update(user);
    }

    @Override
    public void changePassword(Long userId, String oldPassword, String newPassword) {
        User user = userDao.findById(userId);
        if (user != null && user.getPassword().equals(MD5Util.encrypt(oldPassword))) {
            userDao.updatePassword(userId, MD5Util.encrypt(newPassword));
        } else {
            throw new RuntimeException("原密码错误");
        }
    }

    @Override
    public void register(User user) {
        user.setPassword(MD5Util.encrypt(user.getPassword()));
        user.setRole("USER");
        user.setStatus(1);
        userDao.insert(user);
    }

    @Override
    public void updateUser(User user) {
        userDao.update(user);
    }

    @Override
    public void deleteUser(Long id) {
        // 可以添加逻辑删除的实现
        throw new UnsupportedOperationException("用户删除功能暂未实现");
    }

    @Override
    public User getUserByUsername(String username) {
        return userDao.findByUsername(username);
    }

    @Override
    public List<User> getAllUsers() {
        return userDao.findAll();
    }

    @Override
    public boolean checkUsername(String username) {
        return userDao.findByUsername(username) == null;
    }

    @Override
    public void updatePassword(Long id, String oldPassword, String newPassword) {
        User user = userDao.findById(id);
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }
        
        String encryptedOldPassword = MD5Util.encrypt(oldPassword);
        if (!user.getPassword().equals(encryptedOldPassword)) {
            throw new RuntimeException("原密码错误");
        }
        
        String encryptedNewPassword = MD5Util.encrypt(newPassword);
        userDao.updatePassword(id, encryptedNewPassword);
    }
} 