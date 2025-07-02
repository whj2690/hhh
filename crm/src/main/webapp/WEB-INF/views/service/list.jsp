<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>客户服务管理 - CRM系统</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
    <style>
        .overview-card {
            background: #fff;
            padding: 1rem;
            border-radius: 0.25rem;
            border: 1px solid #dee2e6;
        }
        .overview-card .icon {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
        }
        .overview-card .number {
            font-size: 1.5rem;
            font-weight: 600;
        }
        .overview-card .label {
            color: #6c757d;
            font-size: 0.875rem;
        }
    </style>
</head>
<body class="bg-light">
    <div class="container mt-4">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0">客户服务列表</h5>
                <button class="btn btn-primary" onclick="location.href='${pageContext.request.contextPath}/service/add'">
                    <i class="fas fa-plus"></i> 新建工单
                </button>
            </div>
            <div class="card-body">
                <!-- 概览卡片 -->
                <div class="row mb-3">
                    <div class="col-md-3 col-sm-6">
                        <div class="overview-card text-center">
                            <div class="icon text-primary"><i class="fas fa-folder"></i></div>
                            <div class="number">${stats.total}</div>
                            <div class="label">总工单数</div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="overview-card text-center">
                            <div class="icon text-warning"><i class="fas fa-clock"></i></div>
                            <div class="number">${stats.pending}</div>
                            <div class="label">待处理工单</div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="overview-card text-center">
                            <div class="icon text-info"><i class="fas fa-cogs"></i></div>
                            <div class="number">${stats.processing}</div>
                            <div class="label">处理中工单</div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="overview-card text-center">
                            <div class="icon text-success"><i class="fas fa-check-circle"></i></div>
                            <div class="number">${stats.completed}</div>
                            <div class="label">已完成工单</div>
                        </div>
                    </div>
                </div>
                <!-- 筛选表单 -->
                <form class="row g-3 mb-4" id="searchForm">
                    <div class="col-md-3">
                        <select class="form-select" name="customerId" id="customerSelect">
                            <option value="">选择客户</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <select class="form-select" name="type">
                            <option value="">服务类型</option>
                            <option value="咨询">咨询</option>
                            <option value="投诉">投诉</option>
                            <option value="建议">建议</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <select class="form-select" name="status">
                            <option value="">处理状态</option>
                            <option value="待处理">待处理</option>
                            <option value="处理中">处理中</option>
                            <option value="已完成">已完成</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <div class="input-group">
                            <input type="date" class="form-control" name="startDate">
                            <input type="date" class="form-control" name="endDate">
                        </div>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-secondary w-100">
                            <i class="fas fa-search"></i> 搜索
                        </button>
                    </div>
                </form>
                <!-- 工单表格 -->
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>工单编号</th>
                                <th>客户名称</th>
                                <th>服务类型</th>
                                <th>内容摘要</th>
                                <th>状态</th>
                                <th>创建时间</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody id="serviceList">
                            <c:forEach items="${records}" var="service">
                                <tr>
                                    <td>${service.id}</td>
                                    <td>${service.customer.name}</td>
                                    <td>${service.type}</td>
                                    <td>${service.content}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${service.status == '待处理'}">
                                                <span class="badge bg-warning">待处理</span>
                                            </c:when>
                                            <c:when test="${service.status == '处理中'}">
                                                <span class="badge bg-info">处理中</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-success">已完成</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><fmt:formatDate value="${service.createTime}" pattern="yyyy-MM-dd HH:mm"/></td>
                                    <td>
                                        <div class="btn-group btn-group-sm">
                                            <button class="btn btn-info" onclick="handleService('${service.id}')"><i class="fas fa-tools"></i></button>
                                            <button class="btn btn-danger" onclick="deleteService('${service.id}')"><i class="fas fa-trash"></i></button>
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
    <!-- 处理工单弹窗 -->
    <div class="modal fade" id="handleModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">处理工单</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="handleForm">
                        <input type="hidden" id="serviceId">
                        <div class="mb-3">
                            <label class="form-label">解决方案</label>
                            <textarea class="form-control" id="solution" rows="4" required></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="submitSolution()">提交</button>
                </div>
            </div>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const handleModal = new bootstrap.Modal(document.getElementById('handleModal'));
        $(function() {
            $.get('${pageContext.request.contextPath}/customer/list/simple', function(data) {
                const options = data.map(customer => `<option value="${customer.id}">${customer.name}</option>`).join('');
                $('#customerSelect').append(options);
            });
        });
        function handleService(id) {
            $('#serviceId').val(id);
            $('#solution').val('');
            handleModal.show();
        }
        function submitSolution() {
            const id = $('#serviceId').val();
            const solution = $('#solution').val().trim();
            if (!solution) {
                alert('请输入解决方案');
                return;
            }
            $.post('${pageContext.request.contextPath}/service/complete/' + id, { solution: solution })
                .done(response => {
                    if (response.success) {
                        handleModal.hide();
                        location.reload();
                    } else {
                        alert(response.message || '处理失败');
                    }
                })
                .fail(() => alert('系统错误，请稍后重试'));
        }
        function deleteService(id) {
            if (!confirm('确定要删除这个服务工单吗？')) return;
            $.post('${pageContext.request.contextPath}/service/delete/' + id)
                .done(response => {
                    if (response.success) {
                        location.reload();
                    } else {
                        alert(response.message || '删除失败');
                    }
                })
                .fail(() => alert('系统错误，请稍后重试'));
        }
        // 搜索防抖
        let searchTimeout;
        $('#searchForm').on('submit', function(e) {
            e.preventDefault();
            clearTimeout(searchTimeout);
            searchTimeout = setTimeout(() => {
                const $list = $('#serviceList');
                $list.addClass('loading');
                $.get('${pageContext.request.contextPath}/service/search', $(this).serialize())
                    .done(data => {
                        $list.html(data);
                    })
                    .fail(() => alert('搜索失败，请重试'))
                    .always(() => $list.removeClass('loading'));
            }, 300);
        });
    </script>
</body>
</html> 