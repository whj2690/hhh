<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>订单管理 - CRM系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        .badge.bg-new { background-color: #0d6efd; }
        .badge.bg-paid { background-color: #198754; }
        .badge.bg-delivered { background-color: #0dcaf0; }
        .badge.bg-completed { background-color: #198754; }
        .badge.bg-cancelled { background-color: #dc3545; }
        .badge.bg-unpaid { background-color: #dc3545; }
        .badge.bg-partial { background-color: #ffc107; }
    </style>
</head>
<body class="bg-light">
    <div class="container mt-4">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0">订单列表</h5>
                <button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/sales/order/add'">
                    <i class="fas fa-plus"></i> 添加订单
                </button>
            </div>
            <div class="card-body">
                <!-- 搜索表单 -->
                <form class="row g-3 mb-4" action="${pageContext.request.contextPath}/sales/order/search" method="get">
                    <div class="col-md-3">
                        <select class="form-select" name="status">
                            <option value="">订单状态</option>
                            <option value="NEW">新订单</option>
                            <option value="PAID">已支付</option>
                            <option value="DELIVERED">已发货</option>
                            <option value="COMPLETED">已完成</option>
                            <option value="CANCELLED">已取消</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" name="paymentStatus">
                            <option value="">支付状态</option>
                            <option value="UNPAID">未支付</option>
                            <option value="PARTIAL">部分支付</option>
                            <option value="PAID">已支付</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-secondary">
                            <i class="fas fa-search"></i> 搜索
                        </button>
                    </div>
                </form>

                <!-- 订单列表表格 -->
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>订单编号</th>
                                <th>客户名称</th>
                                <th>订单金额</th>
                                <th>订单状态</th>
                                <th>支付状态</th>
                                <th>交付日期</th>
                                <th>创建时间</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${orders}" var="order">
                                <tr>
                                    <td>${order.orderNo}</td>
                                    <td>${order.customer.name}</td>
                                    <td>￥<fmt:formatNumber value="${order.amount}" type="number" pattern="#,##0.00"/></td>
                                    <td>
                                        <span class="badge bg-${order.status.toLowerCase()}">
                                            ${order.status == 'NEW' ? '新订单' :
                                              order.status == 'PAID' ? '已支付' :
                                              order.status == 'DELIVERED' ? '已发货' :
                                              order.status == 'COMPLETED' ? '已完成' : '已取消'}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge bg-${order.paymentStatus.toLowerCase()}">
                                            ${order.paymentStatus == 'UNPAID' ? '未支付' :
                                              order.paymentStatus == 'PARTIAL' ? '部分支付' : '已支付'}
                                        </span>
                                    </td>
                                    <td><fmt:formatDate value="${order.deliveryDate}" pattern="yyyy-MM-dd"/></td>
                                    <td><fmt:formatDate value="${order.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                                    <td>
                                        <div class="btn-group btn-group-sm">
                                            <a href="${pageContext.request.contextPath}/sales/order/edit/${order.id}" 
                                               class="btn btn-primary">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button type="button" class="btn btn-info" 
                                                    onclick="updateStatus(${order.id})">
                                                <i class="fas fa-sync-alt"></i>
                                            </button>
                                            <button type="button" class="btn btn-warning" 
                                                    onclick="updatePayment(${order.id})">
                                                <i class="fas fa-dollar-sign"></i>
                                            </button>
                                            <button type="button" class="btn btn-danger" 
                                                    onclick="deleteOrder(${order.id})">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- 状态更新模态框 -->
    <div class="modal fade" id="statusModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">更新订单状态</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <select class="form-select" id="orderStatus">
                        <option value="NEW">新订单</option>
                        <option value="PAID">已支付</option>
                        <option value="DELIVERED">已发货</option>
                        <option value="COMPLETED">已完成</option>
                        <option value="CANCELLED">已取消</option>
                    </select>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="confirmStatusUpdate()">确定</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 支付状态更新模态框 -->
    <div class="modal fade" id="paymentModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">更新支付状态</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <select class="form-select" id="paymentStatus">
                        <option value="UNPAID">未支付</option>
                        <option value="PARTIAL">部分支付</option>
                        <option value="PAID">已支付</option>
                    </select>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="confirmPaymentUpdate()">确定</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let currentOrderId = null;
        const statusModal = new bootstrap.Modal(document.getElementById('statusModal'));
        const paymentModal = new bootstrap.Modal(document.getElementById('paymentModal'));

        function updateStatus(orderId) {
            currentOrderId = orderId;
            statusModal.show();
        }

        function updatePayment(orderId) {
            currentOrderId = orderId;
            paymentModal.show();
        }

        function confirmStatusUpdate() {
            const status = $('#orderStatus').val();
            $.ajax({
                url: '${pageContext.request.contextPath}/sales/order/status/' + currentOrderId,
                type: 'POST',
                data: { status: status },
                success: function(response) {
                    if (response.success) {
                        alert('订单状态更新成功');
                        location.reload();
                    } else {
                        alert(response.message || '更新失败');
                    }
                    statusModal.hide();
                },
                error: function() {
                    alert('系统错误，请稍后重试');
                    statusModal.hide();
                }
            });
        }

        function confirmPaymentUpdate() {
            const status = $('#paymentStatus').val();
            $.ajax({
                url: '${pageContext.request.contextPath}/sales/order/payment/' + currentOrderId,
                type: 'POST',
                data: { paymentStatus: status },
                success: function(response) {
                    if (response.success) {
                        alert('支付状态更新成功');
                        location.reload();
                    } else {
                        alert(response.message || '更新失败');
                    }
                    paymentModal.hide();
                },
                error: function() {
                    alert('系统错误，请稍后重试');
                    paymentModal.hide();
                }
            });
        }

        function deleteOrder(id) {
            if (confirm('确定要删除这个订单吗？')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/sales/order/delete/' + id,
                    type: 'POST',
                    success: function(response) {
                        if (response.success) {
                            alert('订单删除成功');
                            location.reload();
                        } else {
                            alert(response.message || '删除失败');
                        }
                    },
                    error: function() {
                        alert('系统错误，请稍后重试');
                    }
                });
            }
        }
    </script>
</body>
</html> 