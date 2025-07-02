<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>销售机会管理 - CRM系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-4">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0">销售机会列表</h5>
                <button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/sales/opportunity/add'">
                    <i class="fas fa-plus"></i> 添加机会
                </button>
            </div>
            <div class="card-body">
                <!-- 搜索表单 -->
                <form class="row g-3 mb-4" action="${pageContext.request.contextPath}/sales/opportunity/search" method="get">
                    <div class="col-md-3">
                        <select class="form-select" name="stage">
                            <option value="">所有阶段</option>
                            <option value="初步接触">初步接触</option>
                            <option value="需求确定">需求确定</option>
                            <option value="方案制定">方案制定</option>
                            <option value="商务谈判">商务谈判</option>
                            <option value="成交">成交</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select" name="status">
                            <option value="">所有状态</option>
                            <option value="OPEN">进行中</option>
                            <option value="WON">已成交</option>
                            <option value="LOST">已失败</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-secondary">
                            <i class="fas fa-search"></i> 搜索
                        </button>
                    </div>
                </form>

                <!-- 机会列表表格 -->
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>机会名称</th>
                                <th>客户</th>
                                <th>预期金额</th>
                                <th>阶段</th>
                                <th>成功率</th>
                                <th>预计成交日期</th>
                                <th>状态</th>
                                <th>创建时间</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${opportunities}" var="opportunity">
                                <tr>
                                    <td>${opportunity.id}</td>
                                    <td>${opportunity.name}</td>
                                    <td>${opportunity.customer.name}</td>
                                    <td>￥<fmt:formatNumber value="${opportunity.expectedAmount}" type="number" pattern="#,##0.00"/></td>
                                    <td>${opportunity.stage}</td>
                                    <td>${opportunity.successRate}%</td>
                                    <td><fmt:formatDate value="${opportunity.expectedClosingDate}" pattern="yyyy-MM-dd"/></td>
                                    <td>
                                        <span class="badge ${opportunity.status == 'OPEN' ? 'bg-primary' : 
                                                           opportunity.status == 'WON' ? 'bg-success' : 'bg-danger'}">
                                            ${opportunity.status == 'OPEN' ? '进行中' : 
                                              opportunity.status == 'WON' ? '已成交' : '已失败'}
                                        </span>
                                    </td>
                                    <td><fmt:formatDate value="${opportunity.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                                    <td>
                                        <div class="btn-group btn-group-sm">
                                            <a href="${pageContext.request.contextPath}/sales/opportunity/edit/${opportunity.id}" 
                                               class="btn btn-primary">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button type="button" class="btn btn-danger" 
                                                    onclick="deleteOpportunity(${opportunity.id})">
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
        function deleteOpportunity(id) {
            if (confirm('确定要删除这个销售机会吗？')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/sales/opportunity/delete/' + id,
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