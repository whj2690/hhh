package com.crm.controller;

import com.crm.entity.ServiceRecord;
import com.crm.entity.User;
import com.crm.service.CustomerService;
import com.crm.service.ServiceRecordService;
import com.crm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/service")
public class ServiceRecordController {
    
    @Autowired
    private ServiceRecordService serviceRecordService;
    
    @Autowired
    private CustomerService customerService;
    
    @Autowired
    private UserService userService;

    @GetMapping("/list")
    public String list(Model model) {
        List<ServiceRecord> records = serviceRecordService.getAllServiceRecords();
        model.addAttribute("records", records);
        return "service/list";
    }

    @GetMapping("/search")
    public String search(@RequestParam(required = false) Long customerId,
                        @RequestParam(required = false) String type,
                        @RequestParam(required = false) String status,
                        @RequestParam(required = false) Long handleUserId,
                        Model model) {
        List<ServiceRecord> records = serviceRecordService.searchServiceRecords(customerId, type, status, handleUserId);
        model.addAttribute("records", records);
        return "service/list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        model.addAttribute("customers", customerService.getAllCustomers());
        model.addAttribute("handlers", userService.getAllUsers());
        return "service/add";
    }

    @PostMapping("/add")
    @ResponseBody
    public Map<String, Object> add(@RequestBody ServiceRecord record, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 设置创建人
            User user = (User) session.getAttribute("user");
            record.setCreateUserId(user.getId());
            
            // 保存服务记录
            serviceRecordService.saveServiceRecord(record);
            
            result.put("success", true);
            result.put("message", "服务记录添加成功");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "服务记录添加失败：" + e.getMessage());
        }
        return result;
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        model.addAttribute("customers", customerService.getAllCustomers());
        model.addAttribute("handlers", userService.getAllUsers());
        model.addAttribute("record", serviceRecordService.getServiceRecordById(id));
        return "service/edit";
    }

    @PostMapping("/edit")
    @ResponseBody
    public Map<String, Object> edit(@RequestBody ServiceRecord record) {
        Map<String, Object> result = new HashMap<>();
        try {
            serviceRecordService.updateServiceRecord(record);
            result.put("success", true);
            result.put("message", "服务记录更新成功");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "服务记录更新失败：" + e.getMessage());
        }
        return result;
    }

    @PostMapping("/delete/{id}")
    @ResponseBody
    public Map<String, Object> delete(@PathVariable Long id) {
        Map<String, Object> result = new HashMap<>();
        try {
            serviceRecordService.deleteServiceRecord(id);
            result.put("success", true);
            result.put("message", "服务记录删除成功");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "服务记录删除失败：" + e.getMessage());
        }
        return result;
    }

    @PostMapping("/status/{id}")
    @ResponseBody
    public Map<String, Object> updateStatus(@PathVariable Long id, @RequestParam String status) {
        Map<String, Object> result = new HashMap<>();
        try {
            serviceRecordService.updateStatus(id, status);
            result.put("success", true);
            result.put("message", "服务状态更新成功");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "服务状态更新失败：" + e.getMessage());
        }
        return result;
    }

    @PostMapping("/assign/{id}")
    @ResponseBody
    public Map<String, Object> assignHandler(@PathVariable Long id, @RequestParam Long handleUserId) {
        Map<String, Object> result = new HashMap<>();
        try {
            serviceRecordService.assignHandler(id, handleUserId);
            result.put("success", true);
            result.put("message", "处理人分配成功");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "处理人分配失败：" + e.getMessage());
        }
        return result;
    }

    @PostMapping("/complete/{id}")
    @ResponseBody
    public Map<String, Object> completeSolution(@PathVariable Long id, @RequestParam String solution) {
        Map<String, Object> result = new HashMap<>();
        try {
            serviceRecordService.completeSolution(id, solution);
            result.put("success", true);
            result.put("message", "服务完成处理");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "服务处理失败：" + e.getMessage());
        }
        return result;
    }

    @PostMapping("/satisfaction/{id}")
    @ResponseBody
    public Map<String, Object> updateSatisfaction(@PathVariable Long id, @RequestParam Integer satisfaction) {
        Map<String, Object> result = new HashMap<>();
        try {
            serviceRecordService.updateSatisfaction(id, satisfaction);
            result.put("success", true);
            result.put("message", "满意度评价成功");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "满意度评价失败：" + e.getMessage());
        }
        return result;
    }
} 