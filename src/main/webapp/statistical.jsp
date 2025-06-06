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
List<Order> orderList = orderDao.getAllOrderByStatus();
UserDao userDao = new UserDao(ConnectionProvider.getConnection());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Xem đơn hàng</title>
<%@include file="Components/common_css_js.jsp"%>
</head>
<body>
	<%@include file="Components/navbar.jsp"%>
	<div class="container-fluid px-3 py-3">
		<%
		if (orderList == null || orderList.size() == 0) {
		%>
		<div class="container mt-5 mb-5 text-center">
			<img src="Images/empty-cart.png" style="max-width: 200px;"
				class="img-fluid">
			<h4 class="mt-3">Không tìm thấy đơn hàng</h4>
		</div>
		<%
		} else {
		%>
		<div class="container-fluid">
			<table class="table table-hover">
				<tr class="table-primary" style="font-size: 18px;">
					<th class="text-center">Sản phẩm</th>
					<th>ID Đơn hàng</th>
					<th>Chi tiết sản phẩm</th>
					<th>Địa chỉ vận chuyển</th>
					<th>Ngày & Giờ</th>
					<th>Thanh toán</th>
					<th>Tình trạng</th>
				</tr>
				<%
				for (Order order : orderList) {
					List<OrderedProduct> ordProdList = ordProdDao.getAllOrderedProduct(order.getId());
					for (OrderedProduct orderProduct : ordProdList) {
				%>
				<form action="UpdateOrderServlet?oid=<%=order.getId()%>"
					method="post">
				<tr>
					<td class="text-center"><img
						src="Product_imgs\<%=orderProduct.getImage()%>"
						style="width: 50px; height: 50px; width: auto;"></td>
					<td><%=order.getOrderId()%></td>
					<td><%=orderProduct.getName()%><br>Số lượng: <%=orderProduct.getQuantity()%><br>Tổng tiền:
                                            <%=orderProduct.getPrice() * orderProduct.getQuantity()%>&#8363;</td>
					<td><%=userDao.getUserName(order.getUserId())%><br>Số điện thoại: <%=userDao.getUserPhone(order.getUserId())%><br><%=userDao.getUserAddress(order.getUserId())%></td>
					<td><%=order.getDate()%></td>
					<td><%=order.getPayementType()%></td>
					<td><%=order.getStatus()%></td>
				</tr>
				</form>
				<%
				}
				}
				%>
			</table>
		</div>
		<%
		}
		%>
	</div>
</body>
</html>