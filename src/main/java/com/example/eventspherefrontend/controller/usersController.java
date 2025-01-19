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
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String jwtToken = (String) session.getAttribute("jwtToken");

// Log the retrieved JWT token
        System.out.println("JWT Token from session: " + jwtToken);

        if (jwtToken == null) {
            System.out.println("JWT Token is null. Redirecting to login.jsp.");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // Extract user details from the form
            String name = request.getParameter("username");
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String birthday = request.getParameter("birthday");
            String ageStr  = request.getParameter("age");
            String password = request.getParameter("password");
            String userType = request.getParameter("userType");
            String batchId = request.getParameter("batch");

            // Log the extracted form data
            System.out.println("Received Form Data:");
            System.out.println("Name: " + name);
            System.out.println("Email: " + email);
            System.out.println("Birthday: " + birthday);
            System.out.println("Age: " + ageStr);
            System.out.println("Password: " + password);
            System.out.println("User Type: " + userType);
            System.out.println("Batch ID: " + batchId);

            int age = Integer.parseInt(ageStr);
            // Create a User object
            User newUser = new User();
            newUser.setUsername(name);
            newUser.setName(name);
            newUser.setEmail(email);
            newUser.setDob(birthday);
            newUser.setAge(age);
            newUser.setPassword(password);
            newUser.setRole(userType);
            newUser.setStatus("ACTIVE");

            // Log the created User object
            System.out.println("Created User Object: " + newUser);

            // If a batch is selected, associate the user with the batch
            if (batchId != null && !batchId.isEmpty()) {
                newUser.setRole("STUDENT");
                System.out.println("Batch selected. User role set to STUDENT.");
            }

            // Call the service to add the user
            System.out.println("Calling UserService to add user...");
            boolean isUserAdded = userService.addUser(newUser, jwtToken);

            // Log the result of the service call
            System.out.println("Is User Added: " + isUserAdded);

            if (isUserAdded) {
                System.out.println("User added successfully. Redirecting to Home with success.");
                response.sendRedirect(request.getContextPath() + "/pages/Home?redirected=true&success=addUser");
            } else {
                System.out.println("Failed to add user. Redirecting to Home with error.");
                response.sendRedirect(request.getContextPath() + "/pages/Home?redirected=true&error=addUser");
            }
        } catch (Exception e) {
            // Log the exception details
            System.out.println("Exception occurred while adding user: " + e.getMessage());
            e.printStackTrace();

            request.setAttribute("error", "Invalid input. Please check the form data.");
            request.getRequestDispatcher("/pages/Users.jsp").forward(request, response);
        }

    }



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

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String jwtToken = (String) session.getAttribute("jwtToken");
        String userId = request.getParameter("userId");

        if (jwtToken == null || userId == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("Invalid request. JWT Token or User ID is missing.");
            return;
        }

        try {
            UserService userService = new UserService();
            boolean isDeleted = userService.deleteUser(Integer.parseInt(userId), jwtToken);

            if (isDeleted) {
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("An error occurred while deleting the user.");
        }
    }



}
