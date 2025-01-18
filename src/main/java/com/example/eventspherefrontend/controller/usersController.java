package com.example.eventspherefrontend.controller;

import com.example.eventspherefrontend.model.Batch;
import com.example.eventspherefrontend.model.User;
import com.example.eventspherefrontend.service.BatchService;
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

@WebServlet(name = "usersController", urlPatterns = "/pages/users")
public class usersController extends HttpServlet {
    private final BatchService batchService = new BatchService();
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        String jwtToken = (String) session.getAttribute("jwtToken");
        String batchId = request.getParameter("batchId");

        if (jwtToken == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }


        // Fetch users using a TypeToken
        Type userListType = new TypeToken<List<User>>() {}.getType();
        List<User> users = userService.fetchUsers(jwtToken, userListType);

        if (users == null) {
            users = new ArrayList<>(); // Fallback to an empty list if the API call fails
        }

        // Fetch batches using a TypeToken
        Type batchListType = new TypeToken<List<Batch>>() {}.getType();
        List<Batch> batches = batchService.fetchBatches(jwtToken, batchListType);

        if (batches == null) {
            batches = new ArrayList<>();
        }

        // Fetch batch-related students using the BatchService
        Type studentListType = new TypeToken<List<User>>() {}.getType();
        List<User> students = batchService.fetchBatchStudents(jwtToken, batchId, studentListType);

        if (students == null) {
            students = new ArrayList<>();
        }

        // Add fetched data to the request attributes
        request.setAttribute("batches", batches);
        request.setAttribute("users", users);
        request.setAttribute("students", students);

        // Forward the request to Users.jsp
        request.getRequestDispatcher("/pages/Users.jsp").forward(request, response);
    }
}
