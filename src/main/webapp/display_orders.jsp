<%@page import="com.webshoes.beans.Message"%>
<%@page import="com.webshoes.dao.UserDao"%>
<%@page errorPage="error_exception.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.webshoes.beans.OrderedProduct"%>
<%@page import="com.webshoes.beans.Order"%>
<%@page import="java.util.List"%>
<%@page import="com.webshoes.dao.OrderedProductDao"%>
<%@page import="com.webshoes.dao.OrderDao"%>
<%@page import="com.webshoes.helper.ConnectionProvider"%>

<%
Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
if (activeAdmin == null) {
	Message message = new Message("Bạn chưa đăng nhập! Đăng nhập trước!!", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("adminlogin.jsp");
	return;
}
OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
OrderedProductDao ordProdDao = new OrderedProductDao(ConnectionProvider.getConnection());
List<Order> orderList = orderDao.getAllOrder();
UserDao userDao = new UserDao(ConnectionProvider.getConnection());
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Xem đơn hàng</title>
    <%@include file="Components/common_css_js.jsp"%>
    <style>
        /* General Styles */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f7fa;
        }

        h4 {
            font-weight: bold;
            color: #027a3e;
            margin: 20px 0;
        }

        .container-fluid {
            padding: 30px;
        }

        /* Card Layout */
        .order-card {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        .order-header {
            background-color: #027a3e;
            color: #ffffff;
            border-radius: 10px 10px 0 0;
            padding: 15px;
        }

        .order-header h5 {
            margin: 0;
            font-size: 18px;
        }

        .order-body {
            padding: 15px;
        }

        .order-footer {
            background-color: #f9f9f9;
            padding: 15px;
            text-align: right;
            border-radius: 0 0 10px 10px;
        }

        .order-footer button {
            font-size: 14px;
            padding: 5px 15px;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .btn-update {
            background-color: #027a3e;
            color: #ffffff;
            border: none;
        }

        .btn-update:hover {
            background-color: #025c2b;
        }

        .btn-disabled {
            background-color: #d3d3d3;
            color: #ffffff;
            border: none;
            cursor: not-allowed;
        }

        .product-info img {
            max-width: 80px;
            border-radius: 8px;
        }

        .product-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .product-info div {
            flex: 1;
        }

        .select-status {
            width: 100%;
            max-width: 200px;
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 5px;
        }

        /* Empty Orders */
        .empty-orders {
            text-align: center;
            padding: 50px;
        }

        .empty-orders img {
            max-width: 200px;
            margin-bottom: 20px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container-fluid {
                padding: 20px;
            }

            .order-header h5 {
                font-size: 16px;
            }

            .order-footer button {
                font-size: 12px;
                padding: 5px 10px;
            }
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <%@include file="Components/navbar.jsp"%>

    <!-- Main Content -->
    <div class="container-fluid">
        <% if (orderList == null || orderList.size() == 0) { %>
        <!-- Empty Orders -->
        <div class="empty-orders">
            <img src="Images/empty-cart.png" alt="No Orders">
            <h4>Không tìm thấy đơn hàng</h4>
        </div>
        <% } else { %>
        <!-- Orders List -->
        <h4 class="text-center">Danh sách đơn hàng</h4>
        <div class="row">
            <% for (Order order : orderList) {
                List<OrderedProduct> ordProdList = ordProdDao.getAllOrderedProduct(order.getId());
                for (OrderedProduct orderProduct : ordProdList) { %>
            <div class="col-md-6 mb-4">
                <div class="order-card">
                    <!-- Order Header -->
                    <div class="order-header">
                        <h5>Đơn hàng: <%=order.getOrderId()%> - Ngày: <%=order.getDate()%></h5>
                    </div>
                    <!-- Order Body -->
                    <div class="order-body">
                        <div class="product-info">
                            <img src="Product_imgs/<%=orderProduct.getImage()%>" alt="<%=orderProduct.getName()%>">
                            <div>
                                <strong><%=orderProduct.getName()%></strong><br>
                                Số lượng: <%=orderProduct.getQuantity()%><br>
                                Tổng tiền: <%=orderProduct.getPrice() * orderProduct.getQuantity()%>&#8363;
                            </div>
                        </div>
                        <div class="mt-3">
                            <strong>Khách hàng:</strong> <%=userDao.getUserName(order.getUserId())%><br>
                            <strong>Điện thoại:</strong> <%=userDao.getUserPhone(order.getUserId())%><br>
                            <strong>Địa chỉ:</strong> <%=userDao.getUserAddress(order.getUserId())%>
                        </div>
                        <div class="mt-3">
                            <strong>Thanh toán:</strong> <%=order.getPayementType()%><br>
                            <strong>Tình trạng:</strong> <%=order.getStatus()%>
                        </div>
                    </div>
                    <!-- Order Footer -->
                    <div class="order-footer">
                        <form action="UpdateOrderServlet?oid=<%=order.getId()%>" method="post" style="display: inline-block;">
                            <select name="status" class="select-status">
                                <option>--Chọn trạng thái--</option>
                                <option value="Đã đặt hàng">Đã đặt hàng</option>
                                <option value="Đã vận chuyển">Đã vận chuyển</option>
                                <option value="Hủy bỏ đơn hàng">Hủy bỏ đơn hàng</option>
                                <option value="Đã giao hàng">Đã giao hàng</option>
                            </select>
                            <% if (order.getStatus().equals("Đã giao hàng")) { %>
                            <button type="submit" class="btn btn-disabled" disabled>Cập nhật</button>
                            <% } else { %>
                            <button type="submit" class="btn btn-update">Cập nhật</button>
                            <% } %>
                        </form>
                    </div>
                </div>
            </div>
            <% } } %>
        </div>
        <% } %>
    </div>
</body>
</html>
