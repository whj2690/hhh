package com.crm.controller;

import com.crm.entity.User;
import com.crm.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class UserController {
    
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);
    
    @Autowired
    private UserService userService;

    @GetMapping("/login")
    public String loginPage() {
        return "user/login";
    }

    @PostMapping("/login")
    @ResponseBody
    public Map<String, Object> login(String username, String password, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            logger.info("尝试登录: username={}", username);
            User user = userService.login(username, password);
            if (user != null) {
                logger.info("登录成功: username={}, userId={}", username, user.getId());
                session.setAttribute("user", user);
                result.put("success", true);
                result.put("redirect", "/index");
            } else {
                logger.warn("登录失败: username={}, 用户名或密码错误", username);
                result.put("success", false);
                result.put("message", "用户名或密码错误");
            }
        } catch (Exception e) {
            logger.error("登录异常: username={}", username, e);
            result.put("success", false);
            result.put("message", "系统错误: " + e.getMessage());
        }
        return result;
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
} 