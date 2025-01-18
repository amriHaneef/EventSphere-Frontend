package com.example.eventspherefrontend.controller;

import com.example.eventspherefrontend.model.Announcement;
import com.example.eventspherefrontend.model.StudentAnnouncement;
import com.example.eventspherefrontend.model.Batch;
import com.example.eventspherefrontend.model.User;
import com.example.eventspherefrontend.service.AnnouncementService;
import com.example.eventspherefrontend.service.BatchService;
import com.example.eventspherefrontend.service.UserService;
import com.fasterxml.jackson.databind.ObjectMapper;
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
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "AnnouncementController", urlPatterns = "/pages/announcement")
public class AnnouncementController extends HttpServlet {
    private final AnnouncementService announcementService = new AnnouncementService();
    private final BatchService batchService = new BatchService();
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String jwtToken = (String) session.getAttribute("jwtToken");

        if (jwtToken == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Type announcementListType = new TypeToken<List<Announcement>>() {}.getType();
        List<Announcement> announcements = announcementService.fetchAnnouncements(jwtToken, announcementListType);

        if (announcements == null) {
            announcements = new ArrayList<>();
        }

        Type batchListType = new TypeToken<List<Batch>>() {}.getType();
        List<Batch> batches = batchService.fetchBatches(jwtToken, batchListType);

        if (batches == null) {
            batches = new ArrayList<>();
        }

        // Fetch users using a TypeToken
        Type userListType = new TypeToken<List<User>>() {}.getType();
        List<User> users = userService.fetchUsers(jwtToken, userListType);

        if (users == null) {
            users = new ArrayList<>(); // Fallback to an empty list if the API call fails
        }


        request.setAttribute("announcements", announcements);
        request.setAttribute("batches", batches);
        request.setAttribute("users", users);
        request.getRequestDispatcher("/pages/announcement.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String jwtToken = (String) session.getAttribute("jwtToken");

        if (jwtToken == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Use an action parameter to differentiate between submissions
        String action = request.getParameter("action");

        if ("createAnnouncement".equals(action)) {
            // Handle general announcement creation
            String title = request.getParameter("announcementTitle");
            String content = request.getParameter("announcementContent");
            String createdBy = (String) session.getAttribute("createdBy");
            String role = (String) session.getAttribute("role");

            Announcement announcement = new Announcement();
            announcement.setTitle(title);
            announcement.setContent(content);
            announcement.setCreatedBy(createdBy);
            announcement.setRole(role);

            System.out.println("JWT Token: " + jwtToken);

            boolean isCreated = announcementService.createAnnouncement(announcement, jwtToken);

            if (isCreated) {
                response.sendRedirect(request.getContextPath() + "/pages/Home?redirected=true&success=announcement");
            } else {
                response.sendRedirect(request.getContextPath() + "/pages/Home?redirected=true&error=announcement");
            }

        } else if ("batchAddAnnouncement".equals(action)) {
            System.out.println("Action 'batchAddAnnouncement' initiated.");

            // Handle batch announcement creation
            String batchAnnouncementId = request.getParameter("batchAnnouncementID");
            String batchIdsParam = request.getParameter("batches");

            System.out.println("Batch Announcement ID: " + batchAnnouncementId);
            System.out.println("Batch IDs parameter: " + batchIdsParam);

            // Parse batch IDs from the form
            List<String> batchIds = Arrays.asList(batchIdsParam.split(","));
            System.out.println("Parsed Batch IDs: " + batchIds);

            // Create studentAnnouncement object
            StudentAnnouncement studentAnnouncement = new StudentAnnouncement();
            studentAnnouncement.setAnnouncementId(batchAnnouncementId);
            studentAnnouncement.setBatchIds(batchIds);

            System.out.println("Announcement object created: " + studentAnnouncement);

            System.out.println("JWT Token: " + jwtToken);

            // Call the service method
            boolean isSuccess = announcementService.sendBatchAnnouncement(studentAnnouncement, jwtToken);
            System.out.println("sendBatchAnnouncement result: " + isSuccess);

            // Handle redirection based on result
            if (isSuccess) {
                System.out.println("Announcement successfully sent. Redirecting to success page.");
                response.sendRedirect(request.getContextPath() + "/pages/Home?redirected=true&success=announcement");
            } else {
                System.out.println("Failed to send announcement. Redirecting to error page.");
                response.sendRedirect(request.getContextPath() + "/pages/Home?redirected=true&error=announcement");
            }


        } else if ("studentAddAnnouncement".equals(action)) {
            System.out.println("Action 'studentAddAnnouncement' initiated.");

            // Handle batch announcement creation
            String studentAddAnnouncementId = request.getParameter("studentAnnouncementID");
            String studentAddIdsParam = request.getParameter("students");

            System.out.println("Student Announcement ID: " + studentAddAnnouncementId);
            System.out.println("Student IDs parameter: " + studentAddIdsParam);

            // Parse batch IDs from the form
            List<String> studentIds = Arrays.asList(studentAddIdsParam.split(","));
            System.out.println("Parsed Student IDs: " + studentIds);

            // Create studentAnnouncement object
            StudentAnnouncement studentAnnouncement = new StudentAnnouncement();
            studentAnnouncement.setAnnouncementId(studentAddAnnouncementId);
            studentAnnouncement.setStudentIds(studentIds);

            // Serialize to JSON
            ObjectMapper objectMapper = new ObjectMapper();
            String jsonPayload = objectMapper.writeValueAsString(studentAnnouncement);

// Print the generated payload for debugging
            System.out.println("Generated JSON Payload: " + jsonPayload);

            System.out.println("Announcement object created: " + studentAnnouncement);

            System.out.println("JWT Token: " + jwtToken);

            // Call the service method
            boolean isSuccess = announcementService.sendStudentAnnouncement(studentAnnouncement, jwtToken);
            System.out.println("sendBatchAnnouncement result: " + isSuccess);

            // Handle redirection based on result
            if (isSuccess) {
                System.out.println("Announcement successfully sent. Redirecting to success page.");
                response.sendRedirect(request.getContextPath() + "/pages/Home?redirected=true&success=announcement");
            } else {
                System.out.println("Failed to send announcement. Redirecting to error page.");
                response.sendRedirect(request.getContextPath() + "/pages/Home?redirected=true&error=announcement");
            }

        } else {
            // Invalid action
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action parameter");
        }
    }

}

