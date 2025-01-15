
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

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.IOException;
import java.io.OutputStream;
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
        HttpSession session = request.getSession();
        String jwtToken = (String) session.getAttribute("jwtToken");

        if (jwtToken == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Capture the form data
        String title = request.getParameter("announcementTitle");
        String content = request.getParameter("announcementContent");
        String date = request.getParameter("announcementDate");
        String[] studentIds = request.getParameterValues("studentIds"); // Multiple student IDs can be selected
        String[] batchIds = request.getParameterValues("batchIds"); // Multiple batch IDs can be selected

        // Create an Announcement object
        Announcement announcement = new Announcement();
        announcement.setTitle(title);
        announcement.setContent(content);
        announcement.setContent(date);
        announcement.setStudentIds(List.of(studentIds)); // Convert array to list
        announcement.setBatchIds(List.of(batchIds)); // Convert array to list

        // Get the createdBy and role from session or user info
        String createdBy = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        announcement.setCreatedBy(createdBy);
        announcement.setRole(role);

        // Send the announcement data to the API for creation
        boolean isSuccess = createAnnouncement(announcement, jwtToken);

        if (isSuccess) {
            // Redirect or forward to a success page
            response.sendRedirect(request.getContextPath() + "/pages/announcement.jsp?status=success");
        } else {
            // Show an error message or handle failure
            request.setAttribute("errorMessage", "Failed to create announcement.");
            request.getRequestDispatcher("/pages/announcement.jsp").forward(request, response);
        }
    }


    private boolean createAnnouncement(Announcement announcement, String jwtToken) {
        try {
            URL url = new URL(CREATE_ANNOUNCEMENT_API_URL);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestProperty("Authorization", "Bearer " + jwtToken);
            connection.setDoOutput(true);

            String jsonInputString = gson.toJson(announcement);

            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = jsonInputString.getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            if (connection.getResponseCode() == 201) { // Created status code
                return true;
            } else {
                System.out.println("Failed to create announcement. HTTP response code: " + connection.getResponseCode());
            }

            connection.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


}
