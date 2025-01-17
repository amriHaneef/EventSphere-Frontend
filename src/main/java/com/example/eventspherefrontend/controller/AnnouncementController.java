package com.example.eventspherefrontend.controller;

import com.example.eventspherefrontend.model.Announcement;
import com.example.eventspherefrontend.model.Batch;
import com.example.eventspherefrontend.service.AnnouncementService;
import com.example.eventspherefrontend.service.BatchService;
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


        request.setAttribute("announcements", announcements);
        request.setAttribute("batches", batches);
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

            boolean isCreated = announcementService.createAnnouncement(announcement, jwtToken);

            if (isCreated) {
                response.sendRedirect(request.getContextPath() + "/pages/Home?redirected=true&success=announcement");
            } else {
                response.sendRedirect(request.getContextPath() + "/pages/Home?redirected=true&error=announcement");
            }

        } else if ("batchAddAnnouncement".equals(action)) {
            // Handle batch announcement creation
            String batchAnnouncementId = request.getParameter("batchAnnouncementID");
            String batchIdsParam = request.getParameter("batches");

            // Parse batch IDs from the form
            List<String> batchIds = Arrays.asList(batchIdsParam.split(","));

            Announcement announcement = new Announcement();
            announcement.setId(batchAnnouncementId);
            announcement.setBatchIds(batchIds);

            boolean isSuccess = announcementService.sendBatchAnnouncement(announcement, jwtToken);

            if (isSuccess) {
                response.sendRedirect(request.getContextPath() + "/pages/Home?redirected=true&success=announcement");
            } else {
                response.sendRedirect(request.getContextPath() + "/pages/Home?redirected=true&error=announcement");
            }
        } else {
            // Invalid action
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action parameter");
        }
    }

}

