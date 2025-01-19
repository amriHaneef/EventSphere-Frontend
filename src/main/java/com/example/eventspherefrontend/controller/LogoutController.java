package com.example.eventspherefrontend.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

@WebServlet(name = "LogoutController", urlPatterns = "/pages/logout")
public class LogoutController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(); // Retrieve the existing session
        if (session == null) {
            System.out.println("No active session found. Redirecting to login page.");
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        String jwtToken = (String) session.getAttribute("jwtToken");
        if (jwtToken == null) {
            System.out.println("No JWT token found in session. Redirecting to login page.");
            response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
            return;
        }

        // Call the logout API
        String logoutApi = "http://13.60.250.63:8081/user/logout";
        URL url = new URL(logoutApi);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Authorization", "Bearer " + jwtToken);
        connection.setDoOutput(true);

        int responseCode = connection.getResponseCode();

        if (responseCode == HttpURLConnection.HTTP_OK) {
            System.out.println("Logout successful on API side.");
        } else {
            System.out.println("API logout failed. Response code: " + responseCode);
        }

        // Remove the token from the session
        session.removeAttribute("jwtToken");
        jwtToken = null;

        // Invalidate the session
        session.invalidate();

        // Redirect to login page
        response.sendRedirect(request.getContextPath() + "/pages/login.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
