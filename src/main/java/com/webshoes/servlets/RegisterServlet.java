package com.webshoes.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import com.webshoes.dao.UserDao;
import com.webshoes.beans.Message;
import com.webshoes.beans.User;
import com.webshoes.helper.ConnectionProvider;
import com.webshoes.helper.MailMessenger;
import java.sql.Timestamp;
import java.time.LocalDateTime;

public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String userName = request.getParameter("user_name");
            String userEmail = request.getParameter("user_email");
            String userPassword = request.getParameter("user_password");
            String userPhone = request.getParameter("user_mobile_no");
            String userGender = request.getParameter("gender");
            LocalDateTime userDatetime = LocalDateTime.now();
            String userAddress = request.getParameter("user_address");
            String userCity = request.getParameter("city");

            User user = new User(userName, userEmail, userPassword, userPhone, userGender, Timestamp.valueOf(userDatetime), userAddress, userCity);
            UserDao userDao = new UserDao(ConnectionProvider.getConnection());
            boolean flag = userDao.saveUser(user);

            HttpSession session = request.getSession();
            Message message;
            if (flag) {
                message = new Message("Đăng ký thành công !!", "success", "alert-success");
                MailMessenger.successfullyRegister(userName, userEmail);
            } else {
                message = new Message("Đã xảy ra lỗi! Thử lại lần nữa!!", "error", "alert-danger");
            }
            session.setAttribute("message", message);
            response.sendRedirect("register.jsp");
            return;

        } catch (Exception e) {
            e.printStackTrace();
        }

    }

}
