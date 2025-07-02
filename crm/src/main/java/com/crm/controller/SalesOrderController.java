package com.crm.controller;

import com.crm.entity.SalesOrder;
import com.crm.entity.User;
import com.crm.service.CustomerService;
import com.crm.service.SalesOrderService;
import com.crm.service.SalesOpportunityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/sales/order")
public class SalesOrderController {
    
    @Autowired
    private SalesOrderService orderService;
    
    @Autowired
    private CustomerService customerService;
    
    @Autowired
    private SalesOpportunityService opportunityService;

    @GetMapping("/list")
    public String list(Model model) {
        List<SalesOrder> orders = orderService.getAllOrders();
        model.addAttribute("orders", orders);
        return "sales/order/list";
    }

    @GetMapping("/search")
    public String search(@RequestParam(required = false) Long customerId,
                        @RequestParam(required = false) String status,
                        @RequestParam(required = false) String paymentStatus,
                        Model model) {
        List<SalesOrder> orders = orderService.searchOrders(customerId, status, paymentStatus);
        model.addAttribute("orders", orders);
        return "sales/order/list";
    }

    @GetMapping("/add")
    public String showAddForm(Model model) {
        // 添加客户列表和销售机会列表到模型
        model.addAttribute("customers", customerService.getAllCustomers());
        model.addAttribute("opportunities", opportunityService.getAllOpportunities());
        return "sales/order/add";
    }

    @PostMapping("/add")
    @ResponseBody
    public Map<String, Object> add(@RequestBody SalesOrder order, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 设置创建人
            User user = (User) session.getAttribute("user");
            order.setCreateUserId(user.getId());
            
            // 设置默认状态
            order.setStatus("NEW");
            order.setPaymentStatus("UNPAID");
            
            // 保存订单信息
            orderService.saveOrder(order);  // 修改这里：使用saveOrder替代createOrder
            
            result.put("success", true);
            result.put("message", "订单添加成功");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "订单添加失败：" + e.getMessage());
        }
        return result;
    }

    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Long id, Model model) {
        // 添加客户列表、销售机会列表和订单信息到模型
        model.addAttribute("customers", customerService.getAllCustomers());
        model.addAttribute("opportunities", opportunityService.getAllOpportunities());
        model.addAttribute("order", orderService.getOrderById(id));
        return "sales/order/edit";
    }

    @PostMapping("/edit")
    @ResponseBody
    public Map<String, Object> edit(@RequestBody SalesOrder order) {
        Map<String, Object> result = new HashMap<>();
        try {
            orderService.updateOrder(order);
            result.put("success", true);
            result.put("message", "订单更新成功");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "订单更新失败：" + e.getMessage());
        }
        return result;
    }

    @PostMapping("/delete/{id}")
    @ResponseBody
    public Map<String, Object> delete(@PathVariable Long id) {
        Map<String, Object> result = new HashMap<>();
        try {
            orderService.deleteOrder(id);
            result.put("success", true);
            result.put("message", "订单删除成功");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "订单删除失败：" + e.getMessage());
        }
        return result;
    }

    @PostMapping("/status/{id}")
    @ResponseBody
    public Map<String, Object> updateStatus(@PathVariable Long id, @RequestParam String status) {
        Map<String, Object> result = new HashMap<>();
        try {
            orderService.updateOrderStatus(id, status);
            result.put("success", true);
            result.put("message", "订单状态更新成功");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "订单状态更新失败：" + e.getMessage());
        }
        return result;
    }

    @PostMapping("/payment/{id}")
    @ResponseBody
    public Map<String, Object> updatePaymentStatus(@PathVariable Long id, @RequestParam String paymentStatus) {
        Map<String, Object> result = new HashMap<>();
        try {
            orderService.updatePaymentStatus(id, paymentStatus);
            result.put("success", true);
            result.put("message", "支付状态更新成功");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "支付状态更新失败：" + e.getMessage());
        }
        return result;
    }
} 