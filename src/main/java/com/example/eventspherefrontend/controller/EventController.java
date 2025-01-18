package com.example.eventspherefrontend.controller;

import com.example.eventspherefrontend.model.Announcement;
import com.example.eventspherefrontend.model.Event;
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

@WebServlet(name = "EventController", urlPatterns = "/pages/events")
public class EventController extends HttpServlet {
    private final EventService eventService = new EventService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Entering doPost method.");

        String selectedDate = request.getParameter("eventPageDate");
        System.out.println("Selected date from request: " + selectedDate);

        if (selectedDate == null || selectedDate.isEmpty()) {
            selectedDate = ""; // Default date
            System.out.println("Selected date was null or empty. Defaulting to: " + selectedDate);
        }

        HttpSession session = request.getSession();
        session.setAttribute("eventPageDate", selectedDate);

        String jwtToken = (String) session.getAttribute("jwtToken");

        // Simulating an "isCreated" operation based on event fetching
        boolean isCreated = !eventService.fetchEvents(selectedDate, jwtToken).isEmpty();

        if (isCreated) {
            System.out.println("event created successfully.");
            response.sendRedirect(request.getContextPath() + "/pages/Home?redirected=true&done=eventsLoaded");
        } else {
            System.out.println("Failed to create event.");
            response.sendRedirect(request.getContextPath() + "/pages/Home?redirected=true&error=eventsLoaded");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("Entering doGet method.");

        String selectedDate = request.getParameter("eventPageDate");
        String jwtToken = (String) request.getSession().getAttribute("jwtToken");

        if (jwtToken == null || jwtToken.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/login?error=unauthorized");
            return;
        }

        if (selectedDate == null || selectedDate.isEmpty()) {
            selectedDate = "2025-02-10"; // Default date
        }

        Type eventListType = new TypeToken<List<Event>>() {}.getType();
        List<Event> allEvents = eventService.fetchAllEvents(jwtToken, eventListType);

        if (allEvents == null) {
            allEvents = new ArrayList<>();
        }

        request.setAttribute("allEvents", allEvents);

        try {
            List<Event> events = eventService.fetchEvents(selectedDate, jwtToken);

            if (events != null && !events.isEmpty()) {
                request.setAttribute("events", events);
                request.getRequestDispatcher("/pages/events.jsp").forward(request, response);
            } else {
                System.out.println("No events found for the selected date.");
                response.sendRedirect(request.getContextPath() + "/pages/events?redirected=true&error=noEvents");
            }
        } catch (Exception e) {
            System.out.println("An error occurred while fetching events.");
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/pages/events?redirected=true&error=serverError");
        }
    }
}

//    private void submitFeedback(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        System.out.println("Entering submitFeedback method.");
//
//        String eventId = request.getParameter("eventId");
//        String feedback = request.getParameter("feedback");
//
//        System.out.println("Received feedback for event ID: " + eventId);
//        System.out.println("Feedback content: " + feedback);
//
//        if (feedback == null || feedback.trim().isEmpty()) {
//            System.out.println("Feedback is empty or null. Sending error response.");
//            response.getWriter().write("Feedback cannot be empty.");
//            return;
//        }

        // Logic to submit feedback
//        try {
//            boolean isSubmitted = eventService.submitFeedback(eventId, feedback);
//            System.out.println("Feedback submission result: " + isSubmitted);
//
//            if (isSubmitted) {
//                response.getWriter().write("Feedback submitted successfully for event ID: " + eventId);
//            } else {
//                response.getWriter().write("Failed to submit feedback. Please try again.");
//            }
//        } catch (Exception e) {
//            System.out.println("An error occurred while submitting feedback.");
//            e.printStackTrace(); // Log exception
//            response.getWriter().write("An error occurred while submitting feedback.");
//        }
//    }
//}
