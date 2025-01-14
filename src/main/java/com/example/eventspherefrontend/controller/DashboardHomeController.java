package com.example.eventspherefrontend.controller;

import com.example.eventspherefrontend.model.Announcement;
import com.example.eventspherefrontend.model.Event;
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

@WebServlet(name = "DashboardHomeController", urlPatterns = "/pages/Home")
public class DashboardHomeController extends HttpServlet {

    private static final String EVENTS_API_URL = "http://13.60.250.63:8081/events/getAllEvents?eventDate=2025-02-10";
    private static final String ANNOUNCEMENTS_API_URL = "http://13.60.250.63:8081/Announcement/getAll";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String jwtToken = (String) session.getAttribute("jwtToken");

        if (jwtToken == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Fetch events and announcements
        List<Event> events = fetchFromApi(EVENTS_API_URL, jwtToken, new TypeToken<List<Event>>() {}.getType());
        List<Announcement> announcements = fetchFromApi(ANNOUNCEMENTS_API_URL, jwtToken, new TypeToken<List<Announcement>>() {}.getType());

        if (events == null) events = new ArrayList<>();
        if (announcements == null) announcements = new ArrayList<>();

        // Set attributes for forwarding to JSP
        request.setAttribute("events", events);
        request.setAttribute("announcements", announcements);

        // Forward to DashboardHome.jsp
        request.getRequestDispatcher("/pages/DashboardHome.jsp").forward(request, response);
    }

    private <T> List<T> fetchFromApi(String apiUrl, String jwtToken, Type type) {
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

                Gson gson = new Gson();
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
}
