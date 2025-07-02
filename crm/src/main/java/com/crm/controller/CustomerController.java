package com.crm.controller;

import com.crm.entity.Customer;
import com.crm.entity.User;
import com.crm.service.CustomerService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;

@Controller
@RequestMapping("/customer")
public class CustomerController {
    
    private static final Logger logger = LoggerFactory.getLogger(CustomerController.class);

    @Autowired
    private CustomerService customerService;

    @GetMapping("/list")
    public String list(Model model) {
        List<Customer> customers = customerService.getAllCustomers();
        model.addAttribute("customers", customers);
        return "customer/list";
    }

    @GetMapping("/search")
    public String search(@RequestParam(required = false) String name,
                        @RequestParam(required = false) String level,
                        @RequestParam(required = false) String status,
                        Model model) {
        List<Customer> customers = customerService.searchCustomers(name, level, status);
        model.addAttribute("customers", customers);
        return "customer/list";
    }

    @GetMapping("/add")
    public String showAddForm() {
        return "customer/add";
    }

    @PostMapping("/add")
    @ResponseBody
    public Map<String, Object> add(@RequestBody Customer customer, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 基本验证
            if (customer.getName() == null || customer.getName().trim().isEmpty()) {
                throw new IllegalArgumentException("客户名称不能为空");
            }
            
            // 设置默认值
            customer.setStatus(1);  // 1: 正常
            
            // 设置创建人ID
            User currentUser = (User) session.getAttribute("user");
            if (currentUser != null) {
                customer.setCreateUserId(currentUser.getId());
            }
            
            // 设置创建时间
            customer.setCreateTime(new Date());
            
            // 打印日志，便于调试
            logger.info("Adding new customer: {}", customer);
            
            // 保存客户信息
            customerService.saveCustomer(customer);
            
            result.put("success", true);
            result.put("message", "客户添加成功");
        } catch (IllegalArgumentException e) {
            logger.warn("Invalid customer data: {}", e.getMessage());
            result.put("success", false);
            result.put("message", e.getMessage());
        } catch (Exception e) {
            logger.error("Failed to add customer", e);
            result.put("success", false);
            result.put("message", "客户添加失败：" + e.getMessage());
        }
        return result;
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        Customer customer = customerService.getCustomerById(id);
        model.addAttribute("customer", customer);
        return "customer/edit";
    }

    @PostMapping("/edit")
    @ResponseBody
    public Map<String, Object> edit(@RequestBody Customer customer) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 基本验证
            if (customer == null || customer.getId() == null) {
                throw new IllegalArgumentException("客户信息不完整");
            }
            
            if (customer.getName() == null || customer.getName().trim().isEmpty()) {
                throw new IllegalArgumentException("客户名称不能为空");
            }
            
            // 打印日志，便于调试
            logger.info("Updating customer: {}", customer);
            
            customerService.update(customer);
            result.put("success", true);
            result.put("message", "更新成功");
        } catch (IllegalArgumentException e) {
            logger.warn("Invalid customer data: {}", e.getMessage());
            result.put("success", false);
            result.put("message", e.getMessage());
        } catch (Exception e) {
            logger.error("Failed to update customer", e);
            result.put("success", false);
            result.put("message", "更新失败：" + e.getMessage());
        }
        return result;
    }

    @PostMapping("/delete/{id}")
    @ResponseBody
    public Map<String, Object> delete(@PathVariable Long id) {
        Map<String, Object> result = new HashMap<>();
        try {
            customerService.deleteCustomer(id);
            result.put("success", true);
            result.put("message", "客户删除成功");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "客户删除失败：" + e.getMessage());
        }
        return result;
    }

    @PostMapping("/status/{id}")
    @ResponseBody
    public Map<String, Object> updateStatus(@PathVariable Long id, @RequestParam String status) {
        Map<String, Object> result = new HashMap<>();
        try {
            customerService.updateCustomerStatus(id, status);
            result.put("success", true);
            result.put("message", "客户状态更新成功");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "客户状态更新失败：" + e.getMessage());
        }
        return result;
    }

    // 返回所有客户的id和name，供前端下拉使用
    @GetMapping("/list/simple")
    @ResponseBody
    public List<Map<String, Object>> getSimpleCustomerList() {
        List<Customer> customers = customerService.getAllCustomers();
        List<Map<String, Object>> result = new ArrayList<>();
        for (Customer c : customers) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", c.getId());
            map.put("name", c.getName());
            result.add(map);
        }
        return result;
    }
} 