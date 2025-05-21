package com.webshoes.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Random;
import com.webshoes.dao.UserDao;
import com.webshoes.beans.Message;
import com.webshoes.helper.ConnectionProvider;
import com.webshoes.helper.MailMessenger;

public class ChangePasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String referrer = request.getHeader("referer");
        UserDao userDao = new UserDao(ConnectionProvider.getConnection());
        HttpSession session = request.getSession();

        if (referrer.contains("forgot_password")) {
            String email = request.getParameter("email").trim();
            List<String> list = userDao.getAllEmail();
            if (list.contains(email)) {
                Random rand = new Random();
                int max = 99999, min = 10000;
                int otp = rand.nextInt(max - min + 1) + min;
                session.setAttribute("otp", otp);
                session.setAttribute("email", email);
                MailMessenger.sendOtp(email, otp);

                Message message = new Message("Chúng tôi đã gửi mã đặt lại mật khẩu tới " + email, "success", "alert-success");
                session.setAttribute("message", message);
                response.sendRedirect("otp_code.jsp");
            } else {
                Message message = new Message("Email không tồn tại! Thử lại với Email khác!", "error", "alert-danger");
                session.setAttribute("message", message);
                response.sendRedirect("forgot_password.jsp");
                return;
            }
        } else if (referrer.contains("otp_code")) {
            int code = Integer.parseInt(request.getParameter("code"));
            int otp = (int) session.getAttribute("otp");
            if (code == otp) {
                session.removeAttribute("otp");
                response.sendRedirect("change_password.jsp");
            } else {
                Message message = new Message("Mã xác minh đã nhập không hợp lệ!", "error", "alert-danger");
                session.setAttribute("message", message);
                response.sendRedirect("otp_code.jsp");
                return;
            }
        } else if (referrer.contains("change_password")) {
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirm_password");
            if (password.equals(confirmPassword)) {
                String email = (String) session.getAttribute("email");
                userDao.updateUserPasswordByEmail(password, email);
                session.removeAttribute("email");

                Message message = new Message("Mật khẩu đã được cập nhật thành công!", "error", "alert-success");
                session.setAttribute("message", message);
                response.sendRedirect("login.jsp");
            } else {
                Message message = new Message("Mật khẩu đã được nhập không khớp!", "error", "alert-danger");
                session.setAttribute("message", message);
                response.sendRedirect("change_password.jsp");
            }
        }
    }

}
