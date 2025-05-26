<%@page import="com.webshoes.beans.Message"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page errorPage="error_exception.jsp"%>
<%
    Admin activeAdmin = (Admin) session.getAttribute("activeAdmin");
    if (activeAdmin == null) {
        Message message = new Message("Bạn chưa đăng nhập! Đăng nhập trước!!", "error", "alert-danger");
        session.setAttribute("message", message);
        response.sendRedirect("adminlogin.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Trang Admin</title>
    <%@include file="Components/common_css_js.jsp"%>
    <style>
        /* General Styles */
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f5f7fa;
            margin: 0;
        }

        h3 {
            font-weight: bold;
            color: #34495e;
        }

        a {
            text-decoration: none;
            transition: color 0.3s ease;
        }

        /* Navbar */
        .navbar {
            background: linear-gradient(to right, #6a11cb, #2575fc);
            color: white;
        }

        /* Dashboard Header */
        .dashboard-header {
            background-color: #ffffff;
            border-radius: 10px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }

        .dashboard-header h3 {
            margin: 0;
            color: #34495e;
        }

        .dashboard-header p {
            font-size: 16px;
            color: #7f8c8d;
        }

        /* Card Layout */
        .dashboard-card {
            background: #ffffff;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            padding: 20px;
            margin-bottom: 20px;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }

        .dashboard-card img {
            max-width: 70px;
            margin-bottom: 10px;
        }

        .dashboard-card h4 {
            font-size: 20px;
            margin-top: 15px;
            color: #2c3e50;
        }

        .dashboard-card a {
            display: inline-block;
            color: #3498db;
            font-weight: bold;
            margin-top: 10px;
            transition: color 0.3s ease;
        }

        .dashboard-card a:hover {
            color: #1abc9c;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .dashboard-header {
                padding: 20px;
            }

            .dashboard-card {
                padding: 15px;
            }

            .dashboard-card h4 {
                font-size: 18px;
            }
        }
    </style>
</head>
    <body>
    <!-- Navbar -->
    <%@include file="Components/navbar.jsp"%>

    <!-- Dashboard Header -->
    <div class="container-fluid">
        <div class="dashboard-header">
            <h3>Chào mừng đến với Trang Admin</h3>
            <p>Quản lý danh mục, sản phẩm, đơn hàng, người dùng và nhiều hơn nữa.</p>
        </div>

        <!-- Dashboard Cards -->
        <div class="row">
            <div class="col-md-4">
                <div class="dashboard-card">
                    <img src="Images/Category_icon.png" alt="Danh mục">
                    <h4>Danh mục</h4>
                    <a href="display_category.jsp">Quản lý danh mục</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="dashboard-card">
                    <img src="Images/Product_icon.png" alt="Sản phẩm">
                    <h4>Sản phẩm</h4>
                    <a href="display_products.jsp">Quản lý sản phẩm</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="dashboard-card">
                    <img src="Images/Order_icon.png" alt="Đơn hàng">
                    <h4>Đơn hàng</h4>
                    <a href="display_orders.jsp">Quản lý đơn hàng</a>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-4">
                <div class="dashboard-card">
                    <img src="Images/statistical_icon.png" alt="Thống kê">
                    <h4>Thống kê</h4>
                    <a href="statistical.jsp">Xem báo cáo</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="dashboard-card">
                    <img src="Images/User_icon.png" alt="Người dùng">
                    <h4>Người dùng</h4>
                    <a href="display_users.jsp">Quản lý người dùng</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="dashboard-card">
                    <img src="Images/Admin_icon.png" alt="Admin">
                    <h4>Admin</h4>
                    <a href="display_admin.jsp">Quản lý Admin</a>
                </div>
            </div>
        </div>
    </div>
</body>

        <!-- add category modal-->
        <div class="modal fade" id="add-category" tabindex="-1"
             aria-labelledby="addCategoryModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="addCategoryModalLabel">Thêm danh mục ở đây</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                    </div>
                    <form action="AddOperationServlet" method="post"
                          enctype="multipart/form-data">
                        <div class="modal-body">
                            <input type="hidden" name="operation" value="addCategory">

                            <div class="mb-3">
                                <label class="form-label"><b>Tên danh mục</b></label> <input
                                    type="text" name="category_name"
                                    placeholder="Nhập tên danh mục ở đây" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="formFile" class="form-label"><b>Ảnh danh mục</b></label> <input class="form-control" type="file"
                                                                                                            name="category_img" id="formFile">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary"
                                    data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary me-3">Thêm danh mục</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- end of modal -->

        <!-- add product modal-->
        <div class="modal fade" id="add-product" tabindex="-1"
             aria-labelledby="addProductModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="addProductModalLabel">Thêm sản phẩm ở đây</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                aria-label="Close"></button>
                    </div>
                    <form action="AddOperationServlet" method="post"
                          name="addProductForm" enctype="multipart/form-data">
                        <div class="modal-body">
                            <input type="hidden" name="operation" value="addProduct">
                            <div>
                                <label class="form-label"><b>Tên sản phẩm</b></label> <input
                                    type="text" name="name" placeholder="Nhập tên sản phẩm"
                                    class="form-control" required>
                            </div>
                            <div class="mb-2">
                                <label class="form-label"><b>Mô tả sản phẩm</b></label>
                                <textarea class="form-control" name="description" rows="4"
                                          placeholder="Nhập mô tả sản phẩm"></textarea>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-2">
                                    <label class="form-label"><b>Giá sản phẩm</b></label> <input
                                        type="number" name="price" placeholder="Nhập giá"
                                        class="form-control" required>
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label class="form-label"><b>Giảm giá</b></label> <input
                                        type="number" name="discount" onblur="validate()"
                                        placeholder="Nhập giảm giá!" class="form-control">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-2">
                                    <label class="form-label"><b>Số lượng sản phẩm</b></label> <input
                                        type="number" name="quantity"
                                        placeholder="Nhập số lượng sản phẩm" class="form-control">
                                </div>
                                <div class="col-md-6 mb-2">
                                    <label class="form-label"><b>Chọn thể loại danh mục</b></label> <select
                                        name="categoryType" class="form-control">
                                        <option value="0">--Chọn danh mục--</option>
                                        <%
                                            for (Category c : categoryList) {
                                        %>
                                        <option value="<%=c.getCategoryId()%>">
                                            <%=c.getCategoryName()%></option>
                                            <%
                                                }
                                            %>
                                    </select>
                                </div>
                            </div>
                            <div class="mb-2">
                                <label class="form-label"><b>Ảnh sản phẩm</b></label> <input
                                    type="file" name="photo" class="form-control" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary"
                                    data-bs-dismiss="modal">Đóng</button>
                            <button type="submit" class="btn btn-primary me-3">Thêm sản phẩm</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- end of modal -->

        <script type="text/javascript">
            function validate() {
                var dis = document.addProductForm.discount.value;
                if (dis > 100 || dis < 0) {
                    alert("Mã giảm giá phải từ 0 - 100!!");
                    return false;
                }
            }
        </script>
    </body>
</html>