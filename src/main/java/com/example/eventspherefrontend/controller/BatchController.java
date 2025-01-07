
package com.example.eventspherefrontend.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "BatchController", urlPatterns = "/pages/batches")
public class BatchController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Prepare the list of batches
        List<String[]> batches = new ArrayList<>();
        batches.add(new String[]{"1", "DSE232f", "2025-12-25", "2026-12-25", "Mrs.Sandaruwani","dse23.2f-001","Amri Haneef","30"});
        batches.add(new String[]{"2", "DSE232f", "2025-12-25", "2026-12-25", "Mrs.Thilini","dse23.2f-002","Harindu da Silva","36"});
        batches.add(new String[]{"3", "DSE232f", "2025-12-25", "2026-12-25", "Mrs.Sandaruwani","dse23.2f-003","Shan Indeewa","40"});
        batches.add(new String[]{"4", "DSE232f", "2025-12-25", "2026-12-25", "Mrs.Thilini","dse23.2f-004","Adeesha Nanayakkara","35"});
        batches.add(new String[]{"4", "DSE232f", "2025-12-25", "2026-12-25", "Mrs.Sandaruwani","dse23.2f-005","Niduli Wijesiriwardana","50"});
        batches.add(new String[]{"5", "DSE232f", "2025-12-25", "2026-12-25", "Mrs.Thilini","dse23.2f-006","Induwara Bhagya","60"});


        // Add batch to the request
        request.setAttribute("batches", batches);


        // Example: Retrieve user role (e.g., from database or session)
        String userRole = "teacher"; // This should be dynamically retrieved

        // Set the role in the request or session
        HttpSession session = request.getSession();
        session.setAttribute("role", userRole);

        // Forward the request to AdminEvents.jsp (UI page)
        request.getRequestDispatcher("/pages/batch.jsp").forward(request, response);
    }



    private void submitFeedback(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String eventId = request.getParameter("batchId");
        String feedback = request.getParameter("feedback");

        if (feedback == null || feedback.trim().isEmpty()) {
            response.getWriter().write("Feedback cannot be empty.");
            return;
        }

        // Logic to save feedback in the database
        // Example: Insert feedback associated with the eventId into the database

        response.getWriter().write("Feedback submitted successfully for event ID: " + eventId);
    }
}
