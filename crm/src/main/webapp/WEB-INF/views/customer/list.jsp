<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>客户管理 - CRM系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-4">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0">客户列表</h5>
                <button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/customer/add'">
                    <i class="fas fa-plus"></i> 添加客户
                </button>
            </div>
            <div class="card-body">
                <!-- 搜索表单 -->
                <form class="row g-3 mb-4" action="${pageContext.request.contextPath}/customer/search" method="get">
                    <div class="col-md-3">
                        <input type="text" class="form-control" name="name" placeholder="客户名称">
                    </div>
                    <div class="col-md-2">
                        <select class="form-select" name="status">
                            <option value="">所有状态</option>
                            <option value="1">正常</option>
                            <option value="0">禁用</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-secondary">
                            <i class="fas fa-search"></i> 搜索
                        </button>
                    </div>
                </form>

                <!-- 客户列表表格 -->
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>客户名称</th>
                                <th>联系人</th>
                                <th>联系电话</th>
                                <th>邮箱</th>
                                <th>地址</th>
                                <th>状态</th>
                                <th>创建时间</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${customers}" var="customer">
                                <tr>
                                    <td>${customer.id}</td>
                                    <td>${customer.name}</td>
                                    <td>${customer.contact}</td>
                                    <td>${customer.phone}</td>
                                    <td>${customer.email}</td>
                                    <td>${customer.address}</td>
                                    <td>
                                        <span class="badge ${customer.status == 1 ? 'bg-success' : 'bg-danger'}">
                                            ${customer.status == 1 ? '正常' : '禁用'}
                                        </span>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${customer.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                    </td>
                                    <td>
                                        <div class="btn-group btn-group-sm">
                                            <a href="${pageContext.request.contextPath}/customer/edit/${customer.id}" 
                                               class="btn btn-primary">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button type="button" class="btn btn-danger" 
                                                    onclick="deleteCustomer(${customer.id})">
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

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function deleteCustomer(id) {
            if (confirm('确定要删除这个客户吗？')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/customer/delete/' + id,
                    type: 'POST',
                    success: function(response) {
                        if (response.success) {
                            alert('删除成功');
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