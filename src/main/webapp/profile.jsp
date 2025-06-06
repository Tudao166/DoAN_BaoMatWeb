<%@page import="com.webshoes.beans.Message"%>
<%@page import="com.webshoes.beans.User"%>
<%@page errorPage="error_exception.jsp"%>
<%
User activeUser = (User) session.getAttribute("activeUser");
if (activeUser == null) {
	Message message = new Message("Bạn chưa đăng nhập! Đăng nhập trước!!", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("login.jsp");
	return;  
}
%>  


<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thông tin của tôi</title>
<%@include file="Components/common_css_js.jsp"%>
<style>
.cus-active {
	background-color: #e6eefa !important;
	width: 100%;
}

.list-btn {
	font-size: 20px !important;
}

.list-btn:hover {
	color: #2874f0 !important;
}

.btn-outline-primary {
	background-color: white;
	color: #33cccc;
	border: 2px solid #33cccc;
}

.btn-outline-primary:hover {
	background-color: #33cccc;
        border: #33cccc;
	color: white;
}
</style>
</head>
<body>
	<!--navbar -->
	<%@include file="Components/navbar.jsp"%>

	<div class="container-fluid px-3 py-5">
		<div class="row">
			<div class="col-md-3">
				<div class="card">
					<div class="row mt-2 mb-2">
						<div class="col-md-4">
							<div class="container text-center">
								<img src="Images/profile.png" style="max-width: 60px;"
									class="img-fluid">
							</div>
						</div>
						<div class="col-md-8">
							Xin chào, <br>
							<h5><%=activeUser.getUserName()%></h5>
						</div>
					</div>  
				</div>

				<div class="card mt-3">
					<div class="list-group">
						<button type="button" id="profile-btn"
							class="list-group-item list-group-item-action cus-active list-btn"
							aria-current="true">Thông tin hồ sơ</button>
						<button type="button" id="wishlist-btn"
							class="list-group-item list-group-item-action list-btn">Danh sách yêu thích của tôi</button>
						<button type="button" id="order-btn"
							class="list-group-item list-group-item-action list-btn">Các đơn hàng của tôi</button>
						<button type="button" id="logout-btn"
							class="list-group-item list-group-item-action list-btn"
							onclick="window.open('LogoutServlet?user=user', '_self')">Đăng xuất</button>
					</div>
				</div>
			</div>
			<div class="col-md-9">
				<div class="card">
					<div id="profile">
						<%@include file="Components/alert_message.jsp"%>
						<%@include file="personalInfo.jsp"%>
					</div>
					<div id="wishlist" style="display: none;">
						<%@include file="wishlist.jsp"%>  
					</div>
					<div id="order" style="display: none;">
						<%@include file="order.jsp"%>    
					</div>
				</div>
			</div>  
		</div>
	</div>

	<script>
		$(document).ready(function() {

			$('#profile-btn').click(function() {

				$('#profile').show();
				$('#wishlist').hide();
				$('#order').hide();
				
				$(this).addClass('cus-active');
				$('#wishlist-btn').removeClass('cus-active');
				$('#order-btn').removeClass('cus-active');
				

			});
			$('#wishlist-btn').click(function() {

				$('#wishlist').show();
				$('#profile').hide();
				$('#order').hide();
				
				$(this).addClass('cus-active');
				$('#profile-btn').removeClass('cus-active');
				$('#order-btn').removeClass('cus-active');
				
			});
			$('#order-btn').click(function() {

				$('#order').show();
				$('#profile').hide();
				$('#wishlist').hide();
				
				$(this).addClass('cus-active');
				$('#profile-btn').removeClass('cus-active');
				$('#wishlist-btn').removeClass('cus-active');
			});
		});
	</script>
</body>
</html>