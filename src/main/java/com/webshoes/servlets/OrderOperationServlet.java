package com.webshoes.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import com.webshoes.dao.CartDao;
import com.webshoes.dao.OrderDao;
import com.webshoes.dao.OrderedProductDao;
import com.webshoes.dao.ProductDao;
import com.webshoes.beans.Cart;
import com.webshoes.beans.Order;
import com.webshoes.beans.OrderedProduct;
import com.webshoes.beans.Product;
import com.webshoes.beans.User;
import com.webshoes.helper.ConnectionProvider;
import com.webshoes.helper.MailMessenger;
import com.webshoes.helper.OrderIdGenerator;
import java.security.Timestamp;
import java.time.LocalDateTime;

public class OrderOperationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String from = (String) session.getAttribute("from");
        String paymentType = request.getParameter("paymentMode");
        User user = (User) session.getAttribute("activeUser");
        String orderId = OrderIdGenerator.getOrderId();
        String status = "Đã đặt hàng";
        LocalDateTime orderDateTime = LocalDateTime.now();
        
        if (from.trim().equals("cart")) {
            try {

                Order order = new Order(orderId, status, java.sql.Timestamp.valueOf(orderDateTime), paymentType, user.getUserId());
                OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
                int id = orderDao.insertOrder(order);

                CartDao cartDao = new CartDao(ConnectionProvider.getConnection());
                List<Cart> listOfCart = cartDao.getCartListByUserId(user.getUserId());
                OrderedProductDao orderedProductDao = new OrderedProductDao(ConnectionProvider.getConnection());
                ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
                for (Cart item : listOfCart) {

                    Product prod = productDao.getProductsByProductId(item.getProductId());
                    String prodName = prod.getProductName();
                    int prodQty = item.getQuantity();
                    float price = prod.getProductPriceAfterDiscount() + (float)(29000/prodQty);
                    String image = prod.getProductImages();

                    OrderedProduct orderedProduct = new OrderedProduct(prodName, prodQty, price, image, id);
                    orderedProductDao.insertOrderedProduct(orderedProduct);
                }
                session.removeAttribute("from");
                session.removeAttribute("totalPrice");

                //removing all product from cart after successful order
                cartDao.removeAllProduct();

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if (from.trim().equals("buy")) {

            try {

                int pid = (int) session.getAttribute("pid");
                Order order = new Order(orderId, status, java.sql.Timestamp.valueOf(orderDateTime), paymentType, user.getUserId());
                OrderDao orderDao = new OrderDao(ConnectionProvider.getConnection());
                int id = orderDao.insertOrder(order);
                OrderedProductDao orderedProductDao = new OrderedProductDao(ConnectionProvider.getConnection());
                ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());

                Product prod = productDao.getProductsByProductId(pid);
                String prodName = prod.getProductName();
                int prodQty = 1;
                float price = prod.getProductPriceAfterDiscount() + 29000;
                String image = prod.getProductImages();

                OrderedProduct orderedProduct = new OrderedProduct(prodName, prodQty, price, image, id);
                orderedProductDao.insertOrderedProduct(orderedProduct);

                //updating(decreasing) quantity of product in database
                productDao.updateQuantity(pid, productDao.getProductQuantityById(pid) - 1);

                session.removeAttribute("from");
                session.removeAttribute("pid");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        session.setAttribute("order", "success");
        MailMessenger.successfullyOrderPlaced(user.getUserName(), user.getUserEmail(), orderId, new Date().toString());
        response.sendRedirect("index.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

}
