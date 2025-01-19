package com.example.eventspherefrontend.controller;

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
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "EventController", urlPatterns = "/pages/events")
public class EventController extends HttpServlet {
    private final EventService eventService = new EventService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String jwtToken = (String) session.getAttribute("jwtToken");

        if (jwtToken == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // Retrieve form data
            String eventName = request.getParameter("eventName");
            String eventType = request.getParameter("eventType");
            String date = request.getParameter("Date");
            String time = request.getParameter("time");
            String platform = request.getParameter("platform");
            // Get the current date and time
            String currentDateTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss"));


            // Create an Event object
            Event newEvent = new Event();
            newEvent.setTitle(eventName);
            newEvent.setType(eventType);
            newEvent.setEventDate(date);
            newEvent.setTimePeriod(time);
            newEvent.setPlatform(platform);
            newEvent.setStatus("ACTIVE");
            // Set the current date and time as the createdAt value
            newEvent.setCreatedAt(currentDateTime);  // Assuming there's a setCreatedAt method in the Event class


            // Call the service to add the event
            boolean isEventAdded = eventService.addEvent(newEvent, jwtToken);

            if (isEventAdded) {
                response.sendRedirect(request.getContextPath() + "/pages/Home?redirected=true&success=addEvent");
            } else {
                request.setAttribute("error", "Failed to add event. Please try again.");
                response.sendRedirect(request.getContextPath() + "/pages/Home?redirected=true&error=addEvent");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while processing your request.");
            request.getRequestDispatcher("/pages/addEvent.jsp").forward(request, response);
        }
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

        request.setAttribute("events", events);
        request.getRequestDispatcher("/pages/events.jsp").forward(request, response);
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