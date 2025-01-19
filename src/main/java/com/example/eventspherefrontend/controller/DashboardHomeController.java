package com.example.eventspherefrontend.controller;

import com.example.eventspherefrontend.model.Announcement;
import com.example.eventspherefrontend.model.Batch;
import com.example.eventspherefrontend.model.Event;
import com.example.eventspherefrontend.model.User;
import com.example.eventspherefrontend.service.AnnouncementService;
import com.example.eventspherefrontend.service.BatchService;
import com.example.eventspherefrontend.service.EventService;
import com.example.eventspherefrontend.service.UserService;
import com.google.gson.reflect.TypeToken;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "DashboardHomeController", urlPatterns = "/pages/Home")
public class DashboardHomeController extends HttpServlet {
    private final AnnouncementService announcementService = new AnnouncementService();
    private final BatchService batchService = new BatchService();
    private final EventService eventService = new EventService();
    private final UserService userService = new UserService();


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String selectedDate = request.getParameter("eventDate");

        if (selectedDate == null || selectedDate.isEmpty()) {
            selectedDate = "2025-02-10"; // Default date
        }

        HttpSession session = request.getSession();
        session.setAttribute("eventDate", selectedDate);

        response.sendRedirect(request.getContextPath() + "/pages/Home?eventDate=" + selectedDate);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String jwtToken = (String) session.getAttribute("jwtToken");


        Type eventListType = new TypeToken<List<Event>>() {}.getType();
        List<Event> events = eventService.fetchAllEvents(jwtToken, eventListType);

        if (events == null) {
            events = new ArrayList<>();
        }

        Type batchListType = new TypeToken<List<Batch>>() {}.getType();
        List<Batch> batches = batchService.fetchBatches(jwtToken, batchListType);

        if (batches == null) {
            batches = new ArrayList<>();
        }

        Type announcementListType = new TypeToken<List<Announcement>>() {}.getType();
        List<Announcement> announcements = announcementService.fetchAnnouncements(jwtToken, announcementListType);

        if (announcements == null) {
            announcements = new ArrayList<>();
        }

        // Fetch users using a TypeToken
        Type userListType = new TypeToken<List<User>>() {}.getType();
        List<User> users = userService.fetchUsers(jwtToken, userListType);

        if (users == null) {
            users = new ArrayList<>(); // Fallback to an empty list if the API call fails
        }

        request.setAttribute("events", events);
        request.setAttribute("batches", batches);
        request.setAttribute("announcements", announcements);
        request.setAttribute("users", users);

        request.getRequestDispatcher("/pages/DashboardHome.jsp").forward(request, response);
    }
}
