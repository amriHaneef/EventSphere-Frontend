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

        System.out.println("Received login request with username: " + username);

        // Prepare JSON payload
        String jsonPayload = String.format("{\"username\": \"%s\", \"password\": \"%s\"}", username, password);
        System.out.println("JSON Payload: " + jsonPayload);

        // Call the backend API for authentication
        String apiEndpoint = "http://13.60.250.63:8081/user/login";
      
        URL url = new URL(apiEndpoint);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setDoOutput(true);

        System.out.println("Connecting to API endpoint: " + apiEndpoint);

        try (OutputStream os = connection.getOutputStream()) {
            os.write(jsonPayload.getBytes());
            os.flush();
            System.out.println("Sent JSON payload to API.");
        }

        // Read the API response
        int responseCode = connection.getResponseCode();
        System.out.println("API Response Code: " + responseCode);

        if (responseCode == HttpURLConnection.HTTP_OK) {
            // Parse the response to get the JWT token
            try (BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
                StringBuilder responseBody = new StringBuilder();
                String line;
                while ((line = br.readLine()) != null) {
                    responseBody.append(line);
                }

                System.out.println("API Response Body: " + responseBody);

                // Use Jackson ObjectMapper to parse the JSON response
                ObjectMapper objectMapper = new ObjectMapper();
                JsonNode responseJson = objectMapper.readTree(responseBody.toString());
                String jwtToken = responseJson.get("token").asText(); // Assume the token is under "token" field

                System.out.println("JWT Token received: " + jwtToken);

                // Decode JWT token to get the role
                String role = decodeRoleFromJwt(jwtToken);
                System.out.println("Decoded role from JWT: " + role);

                // Create a session and store username, token, and role
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("jwtToken", jwtToken);
                session.setAttribute("role", role);

                System.out.println("Session attributes set for username: " + username);

                // Redirect to the dashboard or another secured page
                response.sendRedirect(request.getContextPath() + "/pages/Home");
                System.out.println("Redirected to Home page.");
            }
        } else {
            // If authentication fails, redirect back to the login page with an error message
            System.out.println("Authentication failed. Redirecting to login page with error message.");
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
        }
    }

    // Method to decode JWT and extract the role
    private String decodeRoleFromJwt(String jwtToken) {
        System.out.println("Decoding JWT: " + jwtToken);

        String[] parts = jwtToken.split("\\.");
        String payload = new String(java.util.Base64.getDecoder().decode(parts[1]));

        System.out.println("Decoded JWT Payload: " + payload);

        try {
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(payload);
            String role = jsonNode.get("role").asText();
            System.out.println("Extracted role from payload: " + role);
            return role;
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("Error decoding JWT: " + e.getMessage());
            return null;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("GET request received. Forwarding to login page.");
        request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
    }
}
