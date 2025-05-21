<%@page import="com.webshoes.beans.Message"%>
<%@page import="com.webshoes.dao.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page import="com.webshoes.dao.CartDao"%>
<%@page errorPage="error_exception.jsp"%>
<%
    User activeUser = (User) session.getAttribute("activeUser");
    if (activeUser == null) {
        Message message = new Message("Bạn chưa đăng nhập! Đăng nhập trước!!", "error", "alert-danger");
        session.setAttribute("message", message);
        response.sendRedirect("login.jsp");
        return;
    }
    String from = (String) session.getAttribute("from");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thanh toán</title>
        <%@include file="Components/common_css_js.jsp"%>
    </head>
    <body>
        <!--navbar -->
        <%@include file="Components/navbar.jsp"%>

        <div class="container mt-5" style="font-size: 17px;">
            <div class="row">

                <!-- left column -->
                <div class="col-md-8">
                    <div class="card">
                        <div class="container px-3 py-3">
                            <div class="card">
                                <div class="container-fluid text-white"
                                     style="background-color: #389aeb;">
                                    <h4>Địa chỉ vận chuyển</h4>
                                </div>
                            </div>
                            <div class="mt-3 mb-3">
                                <h5><%=user.getUserName()%>
                                    &nbsp;
                                    <%=user.getUserPhone()%></h5>
                                    <%
                                        StringBuilder str = new StringBuilder();
                                        str.append(user.getUserAddress() + ", ");
                                        str.append(user.getUserCity());
                                        out.println(str);
                                    %>
                                <br>
                            </div>
                            <hr>
                            <div class="card">
                                <div class="container-fluid text-white"
                                     style="background-color: #389aeb;">
                                    <h4>Phương thức thanh toán</h4>
                                </div>
                            </div>
                            <form action="OrderOperationServlet" method="post">
                                <div class="form-check mt-2">

                                    <input class="form-check-input" type="radio" name="paymentMode"
                                           value="Tiền mặt"><label
                                           class="form-check-label">Tiền mặt</label>
                                </div>
                                <div id="paymentErrorMessage" class="mt-2"></div>
                                <div class="text-end">
                                    <button type="submit"
                                            class="btn btn-lg btn-outline-primary mt-3" onclick="validatePayment(event)">Đặt hàng</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- end of column -->

                <!-- right column -->
                <div class="col-md-4">
                    <div class="card">
                        <div class="container px-3 py-3">
                            <h4>Chi tiết giá</h4>
                            <hr>
                            <%
                                if (from.trim().equals("cart")) {
                                    CartDao cartDao = new CartDao(ConnectionProvider.getConnection());
//                                    int totalProduct = cartDao.getCartCountByUserId(user.getUserId());
                                    int totalProduct = (int) session.getAttribute("totalQuantity");
                                    float totalPrice = (float) session.getAttribute("totalPrice");
                            %>
                            <table class="table table-borderless">
                                <tr>
                                    <td>Tổng sản phẩm</td>
                                    <td><%=totalProduct%></td>
                                </tr>
                                <tr>
                                    <td>Tổng tiền</td>
                                    <td> <%=totalPrice%>&#8363;</td>
                                </tr>
                                <tr>
                                    <td>Phí vận chuyển</td>
                                    <td>20000&#8363;</td>
                                </tr>
                                <tr>
                                    <td>Phí đóng gói</td>
                                    <td>9000&#8363;</td>
                                </tr>
                                <tr>
                                    <td><h5>Số tiền phải trả :</h5></td>
                                    <td><h5><%=totalPrice + 29000%>&#8363;</h5></td>
                                </tr>
                            </table>
                            <%
                            } else {
                                ProductDao productDao = new ProductDao(ConnectionProvider.getConnection());
                                int pid = (int) session.getAttribute("pid");
                                float price = productDao.getProductPriceById(pid);
                            %>
                            <table class="table table-borderless">
                                <tr>
                                    <td>Tổng sản phẩm</td>
                                    <td>1</td>
                                </tr>
                                <tr>
                                    <td>Tổng tiền</td>
                                    <td><%=price%>&#8363;</td>
                                </tr>
                                <tr>
                                    <td>Phí vận chuyển</td>
                                    <td>20000&#8363;</td>
                                </tr>
                                <tr>
                                    <td>Phí đóng gói</td>
                                    <td>9000&#8363;</td>
                                </tr>
                                <tr>
                                    <td><h5>Số tiền phải trả :</h5></td>
                                    <td><h5><%=price + 29000%>&#8363;</h5></td>
                                </tr>
                            </table>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>
                <!-- end of column -->
            </div>
        </div>

        <script>
            function validatePayment(event) {
                const paymentMethods = document.getElementsByName("paymentMode");
                let isSelected = false;

                for (let i = 0; i < paymentMethods.length; i++) {
                    if (paymentMethods[i].checked) {
                        isSelected = true;
                        break;
                    }
                }

                const errorMessage = document.getElementById('paymentErrorMessage');
                if (!isSelected) {
                    event.preventDefault();
                    errorMessage.textContent = "Bạn vui lòng chọn phương thức thanh toán trước";
                    errorMessage.style.color = "red";
                } else {
                    errorMessage.textContent = "";
                }
            }
        </script>

    </body>
</html>