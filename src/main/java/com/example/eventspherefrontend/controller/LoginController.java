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
        System.out.println("JSON Payload: " + jsonPayload);

        // Call the backend API for authentication
        String apiEndpoint = "http://13.60.250.63:8081/user/login";
      
        URL url = new URL(apiEndpoint);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setDoOutput(true);


        try (OutputStream os = connection.getOutputStream()) {
            os.write(jsonPayload.getBytes());
            os.flush();
            System.out.println("Sent JSON payload to API.");
        }

        // Read the API response
        int responseCode = connection.getResponseCode();

        if (responseCode == HttpURLConnection.HTTP_OK) {
            // Parse the response to get the JWT token
            try (BufferedReader br = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
                StringBuilder responseBody = new StringBuilder();
                String line;
                while ((line = br.readLine()) != null) {
                    responseBody.append(line);
                }

                // Use Jackson ObjectMapper to parse the JSON response
                ObjectMapper objectMapper = new ObjectMapper();
                JsonNode responseJson = objectMapper.readTree(responseBody.toString());
                String jwtToken = responseJson.get("token").asText(); // Assume the token is under "token" field


                // Decode JWT token to get the role
                String role = decodeRoleFromJwt(jwtToken);

                // Create a session and store username, token, and role
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("jwtToken", jwtToken);
                session.setAttribute("role", role);


                // Redirect to the dashboard or another secured page
                response.sendRedirect(request.getContextPath() + "/pages/Home");
            }
        } else {
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
        }
    }

    // Method to decode JWT and extract the role
    private String decodeRoleFromJwt(String jwtToken) {

        String[] parts = jwtToken.split("\\.");
        String payload = new String(java.util.Base64.getDecoder().decode(parts[1]));


        try {
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(payload);
            String role = jsonNode.get("role").asText();
            return role;
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("Error decoding JWT: " + e.getMessage());
            return null;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
    }
}
