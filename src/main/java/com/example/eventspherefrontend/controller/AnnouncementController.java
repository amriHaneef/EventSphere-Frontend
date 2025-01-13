package com.example.eventspherefrontend.controller;

import com.example.eventspherefrontend.model.Announcement;
import com.google.gson.Gson;
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
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "AnnouncementController", urlPatterns = "/pages/announcement")
public class AnnouncementController extends HttpServlet {
    private static final String API_URL = "http://13.60.250.63:8081/Announcement/getAll";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Announcement> announcements = fetchAnnouncementsFromApi();

        if (announcements == null) {
            announcements = new ArrayList<>();
        }

        request.setAttribute("announcements", announcements);

        String userRole = "admin";
        HttpSession session = request.getSession();
        session.setAttribute("role", userRole);

        request.getRequestDispatcher("/pages/announcement.jsp").forward(request, response);
    }

    private List<Announcement> fetchAnnouncementsFromApi() {
        List<Announcement> announcements = new ArrayList<>();
        try {
            // Step 1: Define the URL and open a connection
            URL url = new URL(API_URL);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();

            // Step 2: Set the request method and headers
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Accept", "application/json");

            // Step 3: Add the JWT token to the Authorization header
            String jwtToken = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzdXJlc2hfZmVybmFuZG8iLCJyb2xlIjoic3R1ZGVudCIsImlhdCI6MTczNjc2NjQ0OCwiZXhwIjoxNzM2NzcwMDQ4fQ.llD1VanSo4LsOnFqJjBhYdZB9DpgJPwDkoPEtrh3UJY"; // Replace with the actual token
            connection.setRequestProperty("Authorization", "Bearer " + jwtToken);

            // Step 4: Check the response code and process the response
            if (connection.getResponseCode() == 200) {
                BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                StringBuilder jsonResponse = new StringBuilder();
                String line;

                while ((line = reader.readLine()) != null) {
                    jsonResponse.append(line);
                }
                reader.close();

                // Step 5: Parse the JSON response into a list of Announcement objects
                Gson gson = new Gson();
                Type listType = new TypeToken<List<Announcement>>() {}.getType();
                announcements = gson.fromJson(jsonResponse.toString(), listType);
            } else {
                System.out.println("Failed to fetch announcements. HTTP response code: " + connection.getResponseCode());
            }
            connection.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return announcements;
    }

}
