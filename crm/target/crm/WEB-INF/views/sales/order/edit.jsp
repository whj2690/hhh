<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>编辑订单 - CRM系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        .form-container {
            max-width: 800px;
            margin: 2rem auto;
        }
        .card {
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        .card-header {
            background-color: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
        }
        .form-label {
            font-weight: 500;
            color: #495057;
        }
        .btn-toolbar {
            gap: 0.5rem;
        }
    </style>
</head>
<body class="bg-light">
    <div class="form-container">
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0">
                    <i class="fas fa-edit me-2"></i>编辑订单
                </h5>
            </div>
            <div class="card-body">
                <form id="orderForm" class="needs-validation" novalidate>
                    <input type="hidden" id="id" name="id" value="${order.id}">
                    <input type="hidden" id="status" name="status" value="${order.status}">
                    <input type="hidden" id="paymentStatus" name="paymentStatus" value="${order.paymentStatus}">
                    <input type="hidden" id="orderNo" name="orderNo" value="${order.orderNo}">
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="customerId" class="form-label">选择客户</label>
                            <select class="form-select" id="customerId" name="customerId" required>
                                <option value="">请选择客户</option>
                                <c:forEach items="${customers}" var="customer">
                                    <option value="${customer.id}" ${customer.id == order.customerId ? 'selected' : ''}>
                                        ${customer.name}
                                    </option>
                                </c:forEach>
                            </select>
                            <div class="invalid-feedback">请选择客户</div>
                        </div>
                        <div class="col-md-6">
                            <label for="opportunityId" class="form-label">关联销售机会</label>
                            <select class="form-select" id="opportunityId" name="opportunityId">
                                <option value="">请选择销售机会</option>
                                <c:forEach items="${opportunities}" var="opportunity">
                                    <option value="${opportunity.id}" ${opportunity.id == order.opportunityId ? 'selected' : ''}>
                                        ${opportunity.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="amount" class="form-label">订单金额</label>
                            <div class="input-group">
                                <span class="input-group-text">￥</span>
                                <input type="number" class="form-control" id="amount" name="amount" 
                                       value="${order.amount}" step="0.01" min="0" required>
                                <div class="invalid-feedback">请输入有效的金额</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="deliveryDate" class="form-label">预计交付日期</label>
                            <input type="date" class="form-control" id="deliveryDate" name="deliveryDate" 
                                   value="<fmt:formatDate value='${order.deliveryDate}' pattern='yyyy-MM-dd'/>" required>
                            <div class="invalid-feedback">请选择预计交付日期</div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="description" class="form-label">订单描述</label>
                        <textarea class="form-control" id="description" name="description" 
                                  rows="3" required>${order.description}</textarea>
                        <div class="invalid-feedback">请输入订单描述</div>
                    </div>

                    <div class="btn-toolbar justify-content-end">
                        <button type="button" class="btn btn-secondary" onclick="history.back()">
                            <i class="fas fa-arrow-left me-1"></i>返回
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-1"></i>保存
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        $(function() {
            // 根据客户筛选销售机会
            $('#customerId').on('change', function() {
                const customerId = $(this).val();
                if (customerId) {
                    // 可以添加AJAX请求获取该客户的销售机会
                    $('#opportunityId').prop('disabled', false);
                } else {
                    $('#opportunityId').prop('disabled', true).val('');
                }
            });

            // 表单验证和提交
            const form = document.getElementById('orderForm');
            form.addEventListener('submit', function(event) {
                event.preventDefault();
                
                if (!form.checkValidity()) {
                    event.stopPropagation();
                    form.classList.add('was-validated');
                    return;
                }
                
                // 收集表单数据
                const formData = {
                    id: $('#id').val(),
                    orderNo: $('#orderNo').val(),
                    customerId: $('#customerId').val(),
                    opportunityId: $('#opportunityId').val() || null,
                    amount: $('#amount').val(),
                    deliveryDate: $('#deliveryDate').val(),
                    description: $('#description').val(),
                    status: $('#status').val(),
                    paymentStatus: $('#paymentStatus').val()
                };
                
                // 发送AJAX请求
                $.ajax({
                    url: '${pageContext.request.contextPath}/sales/order/edit',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(formData),
                    success: function(response) {
                        if (response.success) {
                            alert('订单更新成功');
                            window.location.href = '${pageContext.request.contextPath}/sales/order/list';
                        } else {
                            alert(response.message || '更新失败，请重试');
                        }
                    },
                    error: function() {
                        alert('系统错误，请稍后重试');
                    }
                });
            });
        });
    </script>
</body>
</html> 