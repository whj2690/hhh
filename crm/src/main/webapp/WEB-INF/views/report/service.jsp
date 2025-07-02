<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>服务报表 - CRM系统</title>
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
        <h2 class="mt-3 mb-4">服务报表</h2>

        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        服务满意度分布
                    </div>
                    <div class="card-body">
                        <div id="serviceSatisfactionChart" class="chart-container"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
    <script>
        $(function() {
            initServiceSatisfactionChart();
        });

        function initServiceSatisfactionChart() {
            $.get('${pageContext.request.contextPath}/report/service-satisfaction', function(data) {
                const chart = echarts.init(document.getElementById('serviceSatisfactionChart'));
                const option = {
                    title: {
                        text: '服务满意度分布'
                    },
                    tooltip: {
                        trigger: 'axis',
                        axisPointer: {
                            type: 'shadow'
                        }
                    },
                    xAxis: {
                        type: 'category',
                        data: ['1星', '2星', '3星', '4星', '5星']
                    },
                    yAxis: {
                        type: 'value',
                        name: '工单数量'
                    },
                    series: [{
                        data: [
                            data['1'] || 0,
                            data['2'] || 0,
                            data['3'] || 0,
                            data['4'] || 0,
                            data['5'] || 0
                        ],
                        type: 'bar',
                        label: {
                            show: true,
                            position: 'top'
                        }
                    }]
                };
                chart.setOption(option);
            });
        }
    </script>
</body>
</html> 