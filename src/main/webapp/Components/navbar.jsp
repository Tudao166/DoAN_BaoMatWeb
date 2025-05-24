<%@page import="com.webshoes.beans.Admin"%>
<%@page import="com.webshoes.beans.Cart"%>
<%@page import="com.webshoes.dao.CartDao"%>
<%@page import="com.webshoes.beans.User"%>
<%@page import="java.util.List"%>
<%@page import="com.webshoes.beans.Category"%>
<%@page import="com.webshoes.helper.ConnectionProvider"%>
<%@page import="com.webshoes.dao.CategoryDao"%>
<%@page import="com.webshoes.security.CSRFProtection"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    User user = (User) session.getAttribute("activeUser");
    Admin admin = (Admin) session.getAttribute("activeAdmin");

    CategoryDao catDao = new CategoryDao(ConnectionProvider.getConnection());
    List<Category> categoryList = catDao.getAllCategories();

    // Kiểm tra và tạo CSRF token nếu chưa có
    String navbarCsrfToken = "";
    if (session.getAttribute("csrfToken") != null) {
        navbarCsrfToken = (String) session.getAttribute("csrfToken");
    } else {
        navbarCsrfToken = CSRFProtection.getCSRFToken(session);
    }
%>

<style>
    .navbar {
        font-weight: 500;
        background: linear-gradient(109.6deg, rgb(9, 154, 151) 11.2%, rgb(21, 205, 168) 91.1%);
    }

    .nav-link {
        color: white !important;
        font-weight: bold;
        transition: color 0.3s ease;
    }

    .nav-link:hover {
        color: #add8e6 !important;
    }

    .dropdown-menu {
        background-color: #ffffff !important;
        border-color: #949494;
    }

    .dropdown-menu li a {
        color: #333 !important;
        transition: background-color 0.3s ease, color 0.3s ease;
    }

    .dropdown-menu li a:hover {
        background-color: #25e8b1 !important;
        color: white !important;
    }

    .btn-outline-light {
        color: white;
        border-color: white;
        transition: background-color 0.3s ease, color 0.3s ease;
    }

    .btn-outline-light:hover {
        background-color: #0033cc;
        color: #add8e6;
    }

    .navbar-brand {
        color: white !important;
    }

    .navbar-toggler {
        border-color: rgba(255, 255, 255, 1.2);
    }

    .navbar-toggler-icon {
        background-color: #96e0dd;
    }

    .badge {
        background-color: #FF0000;
        color: white;
    }
    .navbar {
    font-weight: 600;
    background: linear-gradient(109.6deg, #1d3557 20%, #457b9d 90%);
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.nav-link {
    color: #ffffff !important;
    font-size: 1rem;
    font-weight: 500;
    transition: color 0.3s ease, transform 0.2s ease;
}

.nav-link:hover {
    color: #a8dadc !important;
    transform: scale(1.05);
}

.dropdown-menu {
    border-radius: 0.5rem;
    padding: 0.5rem;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
}

.dropdown-menu li a {
    color: #1d3557 !important;
    font-size: 0.9rem;
}

.dropdown-menu li a:hover {
    background-color: #a8dadc !important;
    color: #ffffff !important;
}

.btn-outline-light {
    color: #ffffff;
    border-color: #ffffff;
    font-size: 0.9rem;
    padding: 0.5rem 1rem;
    border-radius: 1.5rem;
    transition: background-color 0.3s ease, color 0.3s ease;
}

.btn-outline-light:hover {
    background-color: #457b9d;
    color: #ffffff;
}

.navbar-toggler {
    border: none;
}

.navbar-toggler-icon {
    background-color: #a8dadc;
    border-radius: 0.25rem;
}

.badge {
    background-color: #e63946;
    font-size: 0.75rem;
    font-weight: bold;
    padding: 0.25rem 0.5rem;
}

.form-control {
    border-radius: 2rem;
    border: 1px solid #a8dadc;
}

.form-control:focus {
    border-color: #457b9d;
    box-shadow: 0 0 5px rgba(69, 123, 157, 0.5);
}

</style>

<nav class="navbar navbar-expand-lg">

    <%
        if (admin != null) {
    %>
    <div class="container">
        <a class="navbar-brand" href="admin.jsp"><i
                class="fa-sharp fa-solid fa-house" style="color: #ffffff;"></i>&ensp;Web Shoes</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">

            <div class="container text-end">
                <ul class="navbar-nav justify-content-end">
                    <li class="nav-item">
                        <form method="post" style="display: inline;">
                            <input type="hidden" name="csrfToken" value="<%=navbarCsrfToken%>">
                            <button type="button" class="btn nav-link" data-bs-toggle="modal"
                                    data-bs-target="#add-category">
                                <i class="fa-solid fa-plus fa-xs"></i>Thêm danh mục
                            </button>
                        </form>
                    </li>
                    <li class="nav-item">
                        <form method="post" style="display: inline;">
                            <input type="hidden" name="csrfToken" value="<%=navbarCsrfToken%>">
                            <button type="button" class="btn nav-link" data-bs-toggle="modal"
                                    data-bs-target="#add-product">
                                <i class="fa-solid fa-plus fa-xs"></i>Thêm sản phẩm
                            </button>
                        </form>
                    </li>
                    <li class="nav-item"><a class="nav-link" aria-current="page"
                                            href="admin.jsp"><%=admin.getName()%></a></li>
                    <li class="nav-item">
                        <form method="post" action="LogoutServlet" style="display: inline;">
                            <input type="hidden" name="csrfToken" value="<%=navbarCsrfToken%>">
                            <input type="hidden" name="user" value="admin">
                            <button type="submit" class="btn nav-link" style="border: none; background: transparent;">
                                <i class="fa-solid fa-user-slash fa-sm" style="color: #aaf9ff;"></i>&nbsp;Đăng xuất
                            </button>
                        </form>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <%
    } else {
    %>

    <!-- end -->

    <!-- for all -->
    <div class="container">
        <a class="navbar-brand" href="index.jsp">
            <i class="fa-sharp fa-solid fa-house"></i>&ensp;<strong>Web Shoes</strong>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarContent">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="products.jsp">Sản phẩm</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">Danh mục</a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="products.jsp?category=0">Tất cả sản phẩm</a></li>
                        <% for (Category c : categoryList) { %>
                        <li><a class="dropdown-item" href="products.jsp?category=<%= c.getCategoryId() %>">
                                <%= c.getCategoryName() %></a>
                        </li>
                        <% } %>
                    </ul>
                </li>
            </ul>

            <!-- Search form với CSRF protection -->
            <form class="d-flex pe-5" role="search" action="products.jsp" method="get">
                <input type="hidden" name="csrfToken" value="<%=navbarCsrfToken%>">
                <input name="search" class="form-control me-2" size="50"
                       type="search" placeholder="Tìm kiếm cho sản phẩm" aria-label="Search"
                       style="background-color: white !important;">
                <button class="btn btn-outline-light" type="submit">Search</button>
            </form>

            <!-- when user is logged in -->
            <%
                if (user != null) {
                    CartDao cartDao = new CartDao(ConnectionProvider.getConnection());
                    int cartCount = cartDao.getCartCountByUserId(user.getUserId());
            %>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active pe-3"><a
                        class="nav-link position-relative" aria-current="page"
                        href="cart.jsp"><i class="fa-solid fa-cart-shopping"
                                       style="color: #ffffff;"></i> &nbsp;Giỏ hàng<span
                                       class="position-absolute top-1 start-0 translate-middle badge rounded-pill bg-danger"><%=cartCount%></span></a></li>
                <li class="nav-item active pe-3"><a class="nav-link"
                                                    aria-current="page" href="profile.jsp"><%=user.getUserName()%></a></li>
                <li class="nav-item pe-3">
                    <form method="post" action="LogoutServlet" style="display: inline;">
                        <input type="hidden" name="csrfToken" value="<%=navbarCsrfToken%>">
                        <input type="hidden" name="user" value="user">
                        <button type="submit" class="btn nav-link" style="border: none; background: transparent;">
                            <i class="fa-solid fa-user-slash" style="color: #aaf9ff;"></i>&nbsp;Đăng xuất
                        </button>
                    </form>
                </li>
            </ul>
            <%
            } else {
            %>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active pe-2"><a class="nav-link"
                                                    aria-current="page" href="register.jsp"> <i
                            class="fa-solid fa-user-plus" style="color: #aaf9ff;"></i>&nbsp;Đăng ký
                    </a></li>
                <li class="nav-item pe-2"><a class="nav-link"
                                             aria-current="page" href="login.jsp"><i
                            class="fa-solid fa-user-lock" style="color: #aaf9ff;"></i>&nbsp;Đăng nhập</a></li>
                <li class="nav-item pe-2"><a class="nav-link"
                                             aria-current="page" href="adminlogin.jsp">&nbsp;Admin</a></li>
            </ul>

        </div>
    </div>
    <%
            }
        }
    %>
    <!-- end  -->
</nav>

<!-- JavaScript để xử lý CSRF token cho các modal forms -->
<script>
// Thêm CSRF token vào tất cả các form trong modal
document.addEventListener('DOMContentLoaded', function() {
    const csrfToken = '<%=navbarCsrfToken%>';

    // Tìm tất cả các form trong modal
    const modalForms = document.querySelectorAll('.modal form');

    modalForms.forEach(function(form) {
        // Kiểm tra xem form đã có CSRF token chưa
        const existingToken = form.querySelector('input[name="csrfToken"]');
        if (!existingToken) {
            // Tạo hidden input cho CSRF token
            const csrfInput = document.createElement('input');
            csrfInput.type = 'hidden';
            csrfInput.name = 'csrfToken';
            csrfInput.value = csrfToken;
            form.appendChild(csrfInput);
        }
    });
});
</script>