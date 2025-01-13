package com.example.eventspherefrontend.controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

@WebServlet(name = "LoginController", urlPatterns = "/pages/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the username and password from the form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Prepare JSON payload
        String jsonPayload = String.format("{\"username\": \"%s\", \"password\": \"%s\"}", username, password);

        // API endpoint
        String apiEndpoint = "http://13.60.250.63:8081/auth/login"; // Replace with your actual API URL
        HttpURLConnection connection = null;
        StringBuilder responseBody = new StringBuilder();

        try {
            URL url = new URL(apiEndpoint);
            connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setDoOutput(true);

            // Send the JSON payload
            try (OutputStream os = connection.getOutputStream()) {
                os.write(jsonPayload.getBytes());
                os.flush();
            }

            // Read the API response
            int responseCode = connection.getResponseCode();
            try (BufferedReader br = new BufferedReader(new InputStreamReader(
                    connection.getInputStream()))) {
                String line;
                while ((line = br.readLine()) != null) {
                    responseBody.append(line);
                }
            }

            System.out.println("API Response Code: " + responseCode);
            System.out.println("API Response Body: " + responseBody);

            if (responseCode == HttpURLConnection.HTTP_OK) {
                // Parse the JSON response
                ObjectMapper objectMapper = new ObjectMapper();
                JsonNode responseJson = objectMapper.readTree(responseBody.toString());
                String jwtToken = responseJson.get("token").asText(); // Adjust field based on API response

                // Create a session and store username and token
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("jwtToken", jwtToken);

                // Redirect to the dashboard
                response.sendRedirect(request.getContextPath() + "/pages/Home");
            } else {
                // Handle non-200 responses
                request.setAttribute("errorMessage", "Invalid username or password");
                request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
        } finally {
            if (connection != null) {
                connection.disconnect();
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Forward the request to the login page
        request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
    }
}
