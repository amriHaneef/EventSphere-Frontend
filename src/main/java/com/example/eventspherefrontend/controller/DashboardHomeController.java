package com.example.eventspherefrontend.controller;

import com.example.eventspherefrontend.model.Announcement;
import com.example.eventspherefrontend.model.Event;
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
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "DashboardHomeController", urlPatterns = "/pages/Home")
public class DashboardHomeController extends HttpServlet {


    private static final String EVENTS_API_URL = "http://13.60.250.63:8081/events/getAllEvents?eventDate=";
    private static final String ANNOUNCEMENTS_API_URL = "http://13.60.250.63:8081/Announcement/getAll";

    private final Gson gson = new GsonBuilder()
            .create();


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve the selected date from the form submission
        String selectedDate = request.getParameter("eventDate");

        // Validate and set a default date if none is selected
        if (selectedDate == null || selectedDate.isEmpty()) {
            selectedDate = "2025-02-10"; // Default date
        }

        // Store the selected date in session
        HttpSession session = request.getSession();
        session.setAttribute("eventDate", selectedDate);

        // Redirect to the same page with the selected date as a query parameter
        response.sendRedirect(request.getContextPath() + "/pages/Home?eventDate=" + selectedDate);
    }





    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String jwtToken = (String) session.getAttribute("jwtToken");
        String selectedDate = (String) session.getAttribute("eventDate");

        if (jwtToken == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }


        if (selectedDate == null || selectedDate.isEmpty()) {
            selectedDate = ""; // Default date
        }

        // Construct the API URL with the selected date
        String apiUrl_Events = EVENTS_API_URL + selectedDate;

        // Fetch events from the API (assuming fetchFromApi is a method you have for API calls)
        List<Event> events = fetchFromApi(apiUrl_Events, jwtToken, new TypeToken<List<Event>>() {}.getType());

        // Respond with the selected date
        response.setContentType("text/plain");
        response.getWriter().write("Selected Date: " + selectedDate);

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
