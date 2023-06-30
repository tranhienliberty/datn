package com.petshop.Controller;


import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.petshop.Entity.Account;
import com.petshop.Entity.Customer;
import com.petshop.Service.AccountService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class AccountController {
    @Autowired
    private AccountService accountService;
    
    @RequestMapping("/admin_home")
    public String admin_home() {
        // Xử lý logic và trả về tên của view để hiển thị
        return "admin/admin-home";
    }

    @GetMapping("/login")
    public String showLoginForm(Model model, @RequestHeader(value = "Referer", required = false) String previousUrl) {
        model.addAttribute("previousUrl", previousUrl);
        return "customer/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam("Username") String username, @RequestParam("Password") String password,
                        Model model, HttpServletResponse response, @RequestParam(value = "previousUrl", defaultValue = "/") String previousUrl) {
    	//String encodePass = hashPassword(password);
        try {
            boolean isAuthenticated = accountService.authenticate(username, password);
            String role = accountService.getRole(username);

            if (isAuthenticated) {
                model.addAttribute("success", "Login successful");

                if ("admin".equals(role) || "staff".equals(role)) {
                    addLoggedInCookie(response, "adminIsLoggedIn");
                    addUsernameCookie(response, "adminUsername", username);
                    return "redirect:/admin_home";
                } else {
                    addLoggedInCookie(response, "userIsLoggedIn");
                    addUsernameCookie(response, "userUsername", username);
                    return "redirect:" + previousUrl;
                }
            } else {
                model.addAttribute("error", "Invalid username or password");
                return "customer/login";
            }
        } catch (UsernameNotFoundException e) {
            model.addAttribute("error", e.getMessage());
            return "customer/login";
        }
    }
    
    @RequestMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        // Xóa cookie và trở về trang chủ
        deleteCookie(request, response, "adminIsLoggedIn");
        deleteCookie(request, response, "adminUsername");
        deleteCookie(request, response, "userIsLoggedIn");
        deleteCookie(request, response, "userUsername");

        return "redirect:/";
    }
    
    public static String hashPassword(String pass) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = digest.digest(pass.getBytes());
            StringBuilder stringBuilder = new StringBuilder();
            for (byte b : hashedBytes) {
                stringBuilder.append(String.format("%02x", b));
            }
            return stringBuilder.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return null;
    }
 
	private boolean checkExistUsername(String username) {
		return accountService.checkExistUsername(username);
	}
    
    @RequestMapping(value = "/register")
    public String register(@RequestParam("username") String username, @RequestParam("email") String email,
			@RequestParam("password") String password, Model model) {
    	String encodePass = hashPassword(password);
		if (checkExistUsername(username)) {
			accountService.register(username, email, encodePass);
			
			return "redirect:login";
		}
		else {
			model.addAttribute("failed", "failed");
			return "customer/login";
		}
		
	}
    
    private void deleteCookie(HttpServletRequest request, HttpServletResponse response, String cookieName) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals(cookieName)) {
                    cookie.setMaxAge(0);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                    break;
                }
            }
        }
    }

    private void addLoggedInCookie(HttpServletResponse response, String cookieName) {
        Cookie isLoggedInCookie = new Cookie(cookieName, "true");
        isLoggedInCookie.setMaxAge(30 * 24 * 60 * 60); // Số giây trong 30 ngày
        isLoggedInCookie.setPath("/");
        response.addCookie(isLoggedInCookie);
    }

    private void addUsernameCookie(HttpServletResponse response, String cookieName, String username) {
        Cookie usernameCookie = new Cookie(cookieName, username);
        usernameCookie.setMaxAge(30 * 24 * 60 * 60); // Số giây trong 30 ngày
        usernameCookie.setPath("/");
        response.addCookie(usernameCookie);
    }
    
    @RequestMapping(value = "/adminShowAllAccount")
	public String showAllAccount(Model model) {
		List<Account> accounts = accountService.getAllAccount();
		model.addAttribute("accounts", accounts);
		return "admin/admin-account";
	}
}
