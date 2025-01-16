
package com.example.eventspherefrontend.controller;

import com.example.eventspherefrontend.model.Announcement;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.*;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AnnouncementController", urlPatterns = "/pages/announcement")
public class AnnouncementController extends HttpServlet {
    private static final String ANNOUNCEMENTS_API_URL = "http://13.60.250.63:8081/Announcement/getAll";
    private static final String CREATE_ANNOUNCEMENT_API_URL = "http://13.60.250.63:8081/Announcement/add"; // Assuming you have an API for creating announcements


    private final Gson gson = new GsonBuilder()
            .create();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String jwtToken = (String) session.getAttribute("jwtToken");

        if (jwtToken == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Announcement> announcements = fetchAnnouncementsFromApi(ANNOUNCEMENTS_API_URL, jwtToken, new TypeToken<List<Announcement>>() {}.getType());

        if (announcements == null) {
            announcements = new ArrayList<>();
        }

        request.setAttribute("announcements", announcements);

        request.getRequestDispatcher("/pages/announcement.jsp").forward(request, response);
    }



    private <T> List<T> fetchAnnouncementsFromApi(String apiUrl, String jwtToken, Type type) {
        List<T> data = new ArrayList<>();
        try {
            URL url = new URL(apiUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Accept", "application/json");
            connection.setRequestProperty("Authorization", "Bearer " + jwtToken);

            if (connection.getResponseCode() == 200) {
                BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                StringBuilder jsonResponse = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    jsonResponse.append(line);
                }
                reader.close();

                data = gson.fromJson(jsonResponse.toString(), type);
            } else {
                System.out.println("Failed to fetch data. HTTP response code: " + connection.getResponseCode());
            }
            connection.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Extract form data
        String title = request.getParameter("announcementTitle");
        String content = request.getParameter("announcementContent");

        // Retrieve JWT token and session data
        String jwtToken = (String) request.getSession().getAttribute("jwtToken");
        String createdBy = (String) request.getSession().getAttribute("createdBy");
        String role = (String) request.getSession().getAttribute("role");

        // Create Announcement object
        Announcement announcement = new Announcement();
        announcement.setTitle(title);
        announcement.setContent(content);
        announcement.setCreatedBy(createdBy);
        announcement.setRole(role);

        // Convert Announcement object to JSON (you can use libraries like Gson or Jackson)
        String jsonPayload = String.format("{\"title\": \"%s\", \"content\": \"%s\", \"createdBy\": \"%s\", \"role\": \"%s\"}",
                announcement.getTitle(), announcement.getContent(), announcement.getCreatedBy(), announcement.getRole());

        // Send data to backend API
        URL url = new URL(CREATE_ANNOUNCEMENT_API_URL);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setRequestProperty("Authorization", "Bearer " + jwtToken);
        connection.setDoOutput(true);

        // Write JSON payload
        try (OutputStream os = connection.getOutputStream()) {
            byte[] input = jsonPayload.getBytes("utf-8");
            os.write(input, 0, input.length);
        }

        // Get the response code
        int responseCode = connection.getResponseCode();
        InputStream is = connection.getInputStream();
        StringBuilder responseMessage = new StringBuilder();
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(is, "utf-8"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                responseMessage.append(line.trim());
            }
        }

// Log or print the response message
        System.out.println("Backend response: " + responseMessage);

        if (responseCode == HttpURLConnection.HTTP_CREATED) {
            response.getWriter().write("Announcement successfully created!");
        } else {


            response.sendRedirect(request.getContextPath() + "/pages/Home?redirected=true&success=announcement");
        }

        connection.disconnect();
    }
}



