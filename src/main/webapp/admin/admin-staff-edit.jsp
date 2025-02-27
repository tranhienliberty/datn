<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html >
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="shortcut icon" type="image/png" href="assets/lightning.png"/>
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.2/css/all.css">
    <link rel="stylesheet" href="<c:url value="/resources/css/admin-main-test.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/admin-table.css"/>">
    <link rel="stylesheet" href="<c:url value="/resources/css/admin-product-form.css"/>">
    <title>Pettiny Admin</title>
</head>

<body class="bg-gray-200 custom-scrollbar">
								
    <!-- HEADER/NAVIGATION -->
    <header class="z-10 fixed flex flex-wrap items-center w-full py-3 header-bg">
        <div class="flex flex-no-wrap w-full">
            <div id="system-info" class="w-1/5 flex justify-center items-center px-3">
<%--                 <img style="width: 150px; height: auto;" class="h-10" src="<c:url value ="/resources/images/logo-removebg-preview.png"/>" alt="Logo"> --%>
                <span class="hidden lg:block ml-3 text-white text-center text-lg font-normal tracking-wider header-logo-text">Hệ thống quản lý Pettiny</span>
            </div>
            <div id="header-content" class="w-4/5 flex items-center">
                <div class="flex justify-end lg:justify-start w-full">
                    <span id="expand-and-shrink-menu" class="hidden lg:block cursor-pointer header-icon-bg rounded py-2 px-3 mr-2">
                        <i class="header-icon-text fas fa-bars"></i>
                    </span>
                    <input type="text" class="w-1/2 hidden lg:block header-input-text font-semibold tracking-wide header-icon-bg rounded py-2 px-3 focus:outline-none" placeholder="Search...">
                    <span id="openOffcanvasMenuMobile" class="block lg:hidden cursor-pointer header-icon-bg rounded py-2 px-3 mr-2">
                        <i class="header-icon-text fas fa-bars"></i>
                    </span>
                </div>
				<c:set var="isLoggedIn" value="false" />
								<c:set var="username" value="" />

								<c:if test="${not empty cookie.adminIsLoggedIn}">
									<c:set var="isLoggedIn" value="${cookie.adminIsLoggedIn.value}" />
								</c:if>
								<c:if test="${not empty cookie.adminUsername}">
									<c:set var="username" value="${cookie.adminUsername.value}" />
								</c:if>
            </div>
        </div>
    </header>
    <!-- /HEADER/NAVIGATION -->

    <!-- SIDEBAR -->
    <nav id="sidebar" class="hidden lg:block fixed w-1/5 mt-16 pt-5 pb-24 h-screen bg-gray-100 overflow-y-auto custom-scrollbar">
        <div class="flex flex-wrap justify-center items-center my-6">
            <img id="user-image" class="h-24 w-24 rounded-full shadow-md" src="<c:url value ="/resources/images/logo-removebg-preview.png"/>" alt="User">
            <div id="user-info" class="w-full block text-center mt-6 mb-6 leading-relaxed">
                <span class="block text-lg font-semibold uppercase text-indigo-900">${cookie.adminUsername.value}</span>
                <span class="block text-xs font-semibold uppercase text-indigo-800">Admin hệ thống</span>
            </div>
            <hr class="w-full border-b-0 border-gray-300">
        </div>

        <ul class="flex flex-wrap w-full">
            <li class="w-full py-3 px-5 mb-1 cursor-pointer bg-transparent hover:bg-gray-200 hover-icon-and-text hover-icon-and-text">
                <a href = "<%=request.getContextPath()%>/adminHome"> 
                    <i class="w-6 fas fa-home"></i>
                    <span class="ml-1 font-semibold text-sm tracking-wide">Home</span>
                </a>
            </li>
            <li class="w-full py-3 px-5 mb-1 cursor-pointer bg-transparent hover:bg-gray-200 hover-icon-and-text">
                <a href = "<%=request.getContextPath()%>/adminShowAllCustomer">
                    <i class="w-6 fas fa-user"></i>
                    <span class="ml-1 font-semibold text-sm tracking-wide">Quản lý thông tin khách hàng</span>
                </a>
            </li>
            <li class="w-full py-3 px-5 mb-1 cursor-pointer bg-transparent hover:bg-gray-200 hover-icon-and-text">
                <a href = "<%=request.getContextPath()%>/adminShowAllStaff">
                    <i class="w-6 fas fa-hospital-alt"></i>
                    <span class="ml-1 font-semibold text-sm tracking-wide">Quản lý thông tin bác sĩ/nhân viên</span>
                </a>
            </li>
            <li class="w-full py-3 px-5 mb-1 cursor-pointer bg-transparent hover:bg-gray-200 hover-icon-and-text">
                <a href = "<%=request.getContextPath()%>/adminShowAllAppointment">
                    <i class="w-6 fas fa-calendar"></i>
                    <span class="ml-1 font-semibold text-sm tracking-wide">Quản lý lịch hẹn</span>
                </a>
            </li>
            <li class="w-full py-3 px-5 mb-1 cursor-pointer bg-transparent hover:bg-gray-200 hover-icon-and-text">
                <a href = "<%=request.getContextPath()%>/adminShowAllProduct">
                    <i class="w-6 fas fa-warehouse"></i>
                    <span class="ml-1 font-semibold text-sm tracking-wide">Quản lý sản phẩm</span>
                </a>
            </li>
            <li class="w-full py-3 px-5 mb-1 cursor-pointer bg-transparent hover:bg-gray-200 hover-icon-and-text">
                <a href = "<%=request.getContextPath()%>/adminShowAllService">
                    <i class="w-6 fas fa-plus"></i>
                    <span class="ml-1 font-semibold text-sm tracking-wide">Quản lý dịch vụ</span>
                </a>
            </li>
            <li class="w-full py-3 px-5 mb-1 cursor-pointer bg-transparent hover:bg-gray-200 hover-icon-and-text">
                <a href = "<%=request.getContextPath()%>/adminShowAllBill">
                    <i class="w-6 fas fa-money-bill"></i>
                    <span class="ml-1 font-semibold text-sm tracking-wide">Quản lý hóa đơn</span>
                </a>
            </li>
            <li class="w-full py-3 px-5 mb-1 cursor-pointer bg-transparent hover:bg-gray-200 hover-icon-and-text">
                <a href = "<%=request.getContextPath()%>/adminShowAllAccount">
                    <i class="w-6 fas fa-key"></i>
                    <span class="ml-1 font-semibold text-sm tracking-wide">Quản lý tài khoản</span>
                </a>
            </li>
            <li class="w-full py-3 px-5 mb-1 cursor-pointer bg-transparent hover:bg-gray-200 hover-icon-and-text">
                <a>
                    <i class="w-6 far fa-chart-bar"></i>
                    <span class="ml-1 font-semibold text-sm tracking-wide">Thống kê và báo cáo</span>
                </a>
            </li>
            <li class="w-full py-3 px-5 mb-1 cursor-pointer bg-transparent hover:bg-gray-200 hover-icon-and-text">
                <a href = "<%=request.getContextPath()%>/adminShowAllBlog">
                    <i class="w-6 fas fa-paper-plane"></i>
                    <span class="ml-1 font-semibold text-sm tracking-wide">Quản lý blog</span>
                </a>
            </li>
            <li class="w-full py-3 px-5 mb-1 cursor-pointer bg-transparent hover:bg-gray-200 hover-icon-and-text">
                <a href="<%=request.getContextPath()%>/logout">
                    <i class="w-6 fas"></i>
                    <c:choose>
								<c:when test="${isLoggedIn}">
								<div class="flex flex-1 justify-end items-center">
				                    		<i class="cursor-pointer header-icon-text header-icon-bg rounded py-3 px-10 far mr-3">
				                    			<span style="display: inline-block; vertical-align: middle;"> Đăng xuất </span></i> 
				                </div>
								</c:when>
					</c:choose>
                </a>
            </li>
        </ul>
    </nav>
    <!-- /SIDEBAR -->
		
        <nav id="offcanvas-mobile" class="block lg:hidden nav-offcanvas">
        </nav>

    <div id="offcanvas-overlay" class="block lg:hidden offcanvas-overlay"></div>
    <div class="flex flex-wrap justify-end items-center w-full bg-gray-200">
        <main id="main-content" class="flex flex-wrap justify-end items-center w-full lg:w-4/5 mt-16 p-5 bg-gray-200">
			<form action="<%=request.getContextPath()%>/adminEditStaff" id = "staff-form" method = "post" onsubmit="return validates()">
			          <h2>Thông tin nhân viên</h2>
			  <input type="hidden" id="id_staff" name="id_staff" value="${staff.id_staff}">
			
			  <label for="name_staff">Tên nhân viên:<span style = "color:red">*</span></label>
			  <input type="text" id="name_staff" name="name_staff" value = "${contract.name}" required>
			  
			  <label for="gender">Giới tính:<span style = "color:red">*</span></label>
			  <input type="text" id="gender" name="gender" value = "${contract.gender}" required>
			  
			  <label for="nationality">Quốc tịch:<span style = "color:red">*</span></label>
			  <input type="text" id="nationality" name="nationality" value = "${contract.nationality}" required>
			  
			  <label for="country">Quê quán:<span style = "color:red">*</span></label>
			  <input type="text" id="country" name="country" value = "${contract.country}" required>
			  
			  <label for="identity_card">CMND/CCCD:<span style = "color:red">*</span></label>
			  <input type="text" id="identity_card" name="identity_card" value = "${contract.identity_card}" required>
			  
			  <label for="identity_date">Ngày cấp:<span style = "color:red">*</span></label>
			  <input type="date" id="identity_date" name = "identity_date" value="${contract.identity_date}" required style="padding: 12px; border: 1px solid #ccc; border-radius: 4px; font-size: 16px;">
			  
			  <label for="identity_place">Nơi cấp:<span style = "color:red">*</span></label>
			  <input type="text" id="identity_place" name="identity_place" value = "${contract.identity_place}" required>
			  
			  <label for="date_of_birth">Ngày sinh:<span style = "color:red">*</span></label>
			  <input type="date" id="date_of_birth" name = "date_of_birth" value="${contract.date_of_birth}" required style="padding: 12px; border: 1px solid #ccc; border-radius: 4px; font-size: 16px;">
			
			  <label for="phone">Số điện thoại:<span style = "color:red">*</span></label>
			  <input type="text" id="phone" name="phone" value = "${staff.phone}" required>
			
			  <label for="email">Email:</label>
			  <input type="email" id="email" name="email" value = "${staff.email}" style="padding: 12px; border: 1px solid #ccc; border-radius: 4px; font-size: 16px;">
			
			  <label for="address">Địa chỉ:</label>
			  <input type="text" id="address" name="address" value = "${staff.address}">
			  
			  <label for="certificate">Bằng cấp:<span style = "color:red">*</span></label>
			  <input type="text" id="certificate" name="certificate" value = "${staff.certificate}" required>
			  
			  <label for="date_begin">Ngày bắt đầu hợp đồng:<span style = "color:red">*</span></label>
			  <input type="date" id="date_begin" name = "date_begin" value="${contract.date_begin}" style="padding: 12px; border: 1px solid #ccc; border-radius: 4px; font-size: 16px;">
			  
			  <label for="date_end">Ngày kết thúc hợp đồng:<span style = "color:red">*</span></label>
			  <input type="date" id="date_end" name = "date_end" value="${contract.date_end}" style="padding: 12px; border: 1px solid #ccc; border-radius: 4px; font-size: 16px;">
			  
			  <label for="id_position">Vị trí làm việc:<span style = "color:red">*</span></label>
			  <select id="id_position" name="id_position" required>
			  	<option disabled selected>--Chọn vị trí--</option>
			    <c:forEach items="${positions}" var="item">
                    <option value="<c:out value="${item.id_position}"/>" ${item.id_position eq staff.id_position ? 'selected' : ''}>${item.name_position}</option>
                </c:forEach>
			  </select>
			  <small id="position-error" class="text-danger" style = "color:#FF0000; font-size:14px;"></small>
			  
			  <label for="salary">Mức lương:<span style = "color:red">*</span></label>
			  <input type="number" id="salary" name="salary" value = "${contract.salary}" required> 
			  
			  <label for="payment">Phương thức chi trả (mặc định là tiền mặt):</span></label>
			  <input type="text" id="payment" name="payment" value = "${contract.payment}">
			  			  
			  <label for="bank_number">Số tài khoản:</label>
			  <input type="text" id="bank_number" name="bank_number" value = "${staff.bank_number}">
			  
			  <label for="bank_name">Tên ngân hàng:</label>
			  <input type="text" id="bank_name" name="bank_name" value = "${staff.bank_name}">
			  
			  <label for="username">Tên tài khoản:</label>
			   <select id="username" name="username">
			   	  <option disabled selected>--Chọn tài khoản--</option>
			   	  <option value="<c:out value="${staff.username}"/>" selected>${staff.username}</option>
				  <c:forEach items="${accounts}" var="item">
				    <option value="<c:out value="${item.username}"/>">${item.username}</option>
				  </c:forEach>
				</select>
			  
			  
			  <button type="submit">Lưu</button>
			        </form>
	</main>
    </div>
    <script src="<c:url value="/resources/js/admin-main-test.js"/>"></script>
    <script>
	  function validates() {
	    var position = document.getElementById('id_position').value;
	
	    if (position=="") {
	      document.getElementById('position-error').textContent = 'Trường này không được để trống.';
	      return false; // Ngăn form submit
	    } else {
	      document.getElementById('position-error').textContent = '';
	      return true; // Cho phép form submit
	    }
	  }
	</script>
</body>
</html>