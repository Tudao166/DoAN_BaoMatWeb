package com.webshoes.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import com.webshoes.dao.OrderDao;
import com.webshoes.dao.UserDao;
import com.webshoes.beans.Order;
import com.webshoes.beans.Admin;
import com.webshoes.beans.Message;
import com.webshoes.helper.ConnectionProvider;
import com.webshoes.helper.MailMessenger;

public class UpdateOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	// Danh sách các trạng thái hợp lệ
	private static final List<String> VALID_STATUSES = Arrays.asList(
			"Đã đặt hàng",
			"Đã vận chuyển",
			"Hủy bỏ đơn hàng",
			"Đã giao hàng"
	);

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			// 1. Kiểm tra session và xác thực admin
			HttpSession session = request.getSession(false);
			if (session == null) {
				response.sendRedirect("adminlogin.jsp");
				return;
			}

			Admin admin = (Admin) session.getAttribute("activeAdmin");
			if (admin == null) {
				Message message = new Message("Bạn không có quyền thực hiện hành động này!", "error", "alert-danger");
				session.setAttribute("message", message);
				response.sendRedirect("adminlogin.jsp");
				return;
			}

			// 2. Validate input parameters
			String oidStr = request.getParameter("oid");
			String status = request.getParameter("status");

			if (oidStr == null || oidStr.trim().isEmpty() ||
					status == null || status.trim().isEmpty()) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Thiếu thông tin cần thiết");
				return;
			}

			// 3. Validate status hợp lệ
			if (!VALID_STATUSES.contains(status.trim())) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Trạng thái không hợp lệ");
				return;
			}

			// 4. Parse và validate order ID
			int oid;
			try {
				oid = Integer.parseInt(oidStr);
				if (oid <= 0) {
					throw new NumberFormatException("Order ID phải lớn hơn 0");
				}
			} catch (NumberFormatException e) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Order ID không hợp lệ");
				return;
			}

			// 5. Kiểm tra đơn hàng tồn tại
			OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
			Order order = orderDao.getOrderById(oid);
			if (order == null || order.getId() == 0) {
				response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy đơn hàng");
				return;
			}

			// 6. Cập nhật trạng thái
			orderDao.updateOrderStatus(oid, status.trim());

			// 7. Gửi email thông báo nếu trạng thái là "Đã vận chuyển"
			if (status.trim().equals("Đã vận chuyển")) {
				UserDao userDao = new UserDao(ConnectionProvider.getConnection());
				MailMessenger.orderShipped(
						userDao.getUserName(order.getUserId()),
						userDao.getUserEmail(order.getUserId()),
						order.getOrderId(),
						order.getDate().toString()
				);
			}

			// 8. Set success message và redirect
			Message message = new Message("Cập nhật trạng thái đơn hàng thành công!", "success", "alert-success");
			session.setAttribute("message", message);
			response.sendRedirect("display_orders.jsp");

		} catch (Exception e) {
			// 9. Log lỗi và trả về error page
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi xử lý yêu cầu");
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 10. Không cho phép truy cập qua GET
		response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "Phương thức không được hỗ trợ");
	}
}