<%@page import="com.webshoes.beans.Message"%>
<%@page import="com.webshoes.beans.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
User user1 = (User) session.getAttribute("activeUser");
if (user1 == null) {
	Message message = new Message("Bạn chưa đăng nhập! Đăng nhập trước!!", "error", "alert-danger");
	session.setAttribute("message", message);
	response.sendRedirect("login.jsp");
	return;
}
%>

<style>
label {
	font-weight: bold;
}
</style>
<div class="container px-3 py-3">
	<h3>Thông tin cá nhân</h3>
	<form id="update-user" action="UpdateUserServlet" method="post">
		<input type="hidden" name="operation" value="updateUser">
		<div class="row">
			<div class="col-md-6 mt-2">
				<label class="form-label">Tên của bạn</label> <input type="text"
					name="name" class="form-control" placeholder="Nhập họ và tên của bạn"
					value="<%=user1.getUserName()%>">
			</div>
			<div class="col-md-6 mt-2">
				<label class="form-label">Email</label> <input type="email"
					name="email" placeholder="Địa chỉ Email" class="form-control"
					value="<%=user1.getUserEmail()%>">
			</div>
		</div>
		<div class="row">
			<div class="col-md-6 mt-2">
				<label class="form-label">Số điện thoại</label> <input type="number"
					name="mobile_no" placeholder="Số điện thoại" class="form-control"
					value="<%=user1.getUserPhone()%>">
			</div>
			<div class="col-md-6 mt-5">
				<label class="form-label pe-3">Giới tính</label>
				<%
				String gender = user1.getUserGender();
				if (gender.trim().equals("Nam")) {
				%>
				<input class="form-check-input" type="radio" name="gender"
					value="Nam" checked> <span
					class="form-check-label pe-3 ps-1"> Nam </span> <input
					class="form-check-input" type="radio" name="gender" value="Nữ">
				<span class="form-check-label ps-1"> Nữ </span>

				<%
				} else {
				%>
				<input class="form-check-input" type="radio" name="gender"
					value="Nam"> <span class="form-check-label pe-3 ps-1">
					Nam </span> <input class="form-check-input" type="radio" name="gender"
					value="Nữ" checked> <span class="form-check-label ps-1">
					Nữ </span>
				<%
				}
				%>

			</div>
		</div>
		<div class="mt-2">
			<label class="form-label">Địa chỉ</label> <input type="text"
				name="address" placeholder="Nhập địa chỉ (khu vực, thành phố)"
				class="form-control" value="<%=user1.getUserAddress()%>">
		</div>
		<div class="row">
			<div class="col-md-6 mt-2">
				<label class="form-label">Thành phố</label> <input class="form-control"
					type="text" name="city" placeholder="Thành phố/Tỉnh/Thị trấn"
					value="<%=user1.getUserCity()%>">
			</div>
		</div>
		<div id="submit-btn" class="container text-center mt-3">
			<button type="submit" class="btn btn-outline-primary me-3">Cập nhật</button>
			<button type="reset" class="btn btn-outline-primary">Khôi phục</button>
		</div>
	</form>
</div>

















