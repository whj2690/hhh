<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>销售报表 - CRM系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/font-awesome.min.css">
    <script src="${pageContext.request.contextPath}/static/js/echarts.min.js"></script>
    <style>
        .chart-container {
            height: 400px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <h2 class="mt-3 mb-4">销售报表</h2>

        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        月度销售额趋势
                    </div>
                    <div class="card-body">
                        <div id="monthlySalesChart" class="chart-container"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        客户类型销售分布
                    </div>
                    <div class="card-body">
                        <div id="customerTypeSalesChart" class="chart-container"></div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        产品类型销售分布
                    </div>
                    <div class="card-body">
                        <div id="productTypeSalesChart" class="chart-container"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
    <script>
        $(function() {
            initMonthlySalesChart();
            initCustomerTypeSalesChart();
            initProductTypeSalesChart();
        });

        function initMonthlySalesChart() {
            $.get('${pageContext.request.contextPath}/report/monthly-sales', function(data) {
                const chart = echarts.init(document.getElementById('monthlySalesChart'));
                const option = {
                    title: {
                        text: '月度销售额趋势'
                    },
                    tooltip: {
                        trigger: 'axis',
                        formatter: function(params) {
                            return params[0].name + '<br/>' +
                                   '销售额: ¥' + params[0].value.toLocaleString();
                        }
                    },
                    xAxis: {
                        type: 'category',
                        data: data.map(item => item.month)
                    },
                    yAxis: {
                        type: 'value',
                        axisLabel: {
                            formatter: '¥{value}'
                        }
                    },
                    series: [{
                        data: data.map(item => item.amount),
                        type: 'line',
                        smooth: true,
                        areaStyle: {}
                    }]
                };
                chart.setOption(option);
            });
        }

        function initCustomerTypeSalesChart() {
            $.get('${pageContext.request.contextPath}/report/sales-by-customer-type', function(data) {
                const chart = echarts.init(document.getElementById('customerTypeSalesChart'));
                const option = {
                    title: {
                        text: '客户类型销售分布'
                    },
                    tooltip: {
                        trigger: 'item',
                        formatter: '{b}: ¥{c} ({d}%)'
                    },
                    series: [{
                        type: 'pie',
                        radius: '60%',
                        data: data.map(item => ({
                            name: item.type,
                            value: item.amount
                        }))
                    }]
                };
                chart.setOption(option);
            });
        }

        function initProductTypeSalesChart() {
            $.get('${pageContext.request.contextPath}/report/sales-by-product-type', function(data) {
                const chart = echarts.init(document.getElementById('productTypeSalesChart'));
                const option = {
                    title: {
                        text: '产品类型销售分布'
                    },
                    tooltip: {
                        trigger: 'item',
                        formatter: '{b}: ¥{c} ({d}%)'
                    },
                    series: [{
                        type: 'pie',
                        radius: '60%',
                        data: data.map(item => ({
                            name: item.type,
                            value: item.amount
                        }))
                    }]
                };
                chart.setOption(option);
            });
        }
    </script>
</body>
</html> 