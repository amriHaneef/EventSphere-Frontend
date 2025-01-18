package com.example.eventspherefrontend.controller;

import com.example.eventspherefrontend.model.Announcement;
import com.example.eventspherefrontend.model.Event;
import com.example.eventspherefrontend.service.AnnouncementService;
import com.example.eventspherefrontend.service.EventService;
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
    private final EventService eventService = new EventService();


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
        String selectedDate = (String) session.getAttribute("eventDate");

        if (jwtToken == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        if (selectedDate == null || selectedDate.isEmpty()) {
            selectedDate = ""; // Default date
        }

        List<Event> events = eventService.fetchEvents(selectedDate, jwtToken);
        Type announcementListType = new TypeToken<List<Announcement>>() {}.getType();
        List<Announcement> announcements = announcementService.fetchAnnouncements(jwtToken, announcementListType);

        if (announcements == null) {
            announcements = new ArrayList<>();
        }

        request.setAttribute("events", events);
        request.setAttribute("announcements", announcements);

        request.getRequestDispatcher("/pages/DashboardHome.jsp").forward(request, response);
    }
}
