package com.example.eventspherefrontend.controller;

import com.example.eventspherefrontend.model.Batch;
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
import java.util.List;

@WebServlet(name = "usersController", urlPatterns = "/pages/users")
public class usersController extends HttpServlet {
    private final BatchService batchService = new BatchService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        String jwtToken = (String) session.getAttribute("jwtToken");

        if (jwtToken == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Type batchListType = new TypeToken<List<Batch>>() {}.getType();
        List<Batch> batches = batchService.fetchBatches(jwtToken, batchListType);

        if (batches == null) {
            batches = new ArrayList<>();
        }

        request.setAttribute("batches", batches);


        // Prepare the list of users
        List<String[]> users = new ArrayList<>();
        users.add(new String[]{"001", "John Doe","JohnDoe@gmail.com", "24-12-2002"});
        // Adding multiple users
        users.add(new String[]{"002", "John Doe","JohnDoe@gmail.com", "03-01-2000"});

        // Add students to the request
        request.setAttribute("users", users);





        // Prepare the list of students
        List<String[]> students = new ArrayList<>();
        students.add(new String[]{"001", "John Doe","JohnDoe@gmail.com", "24-12-2002","DSE24.1","26","0987654321"});
        // Adding multiple students
        students.add(new String[]{"002", "John Doe","JohnDoe@gmail.com", "03-01-2000","GADSE21.3","22","1234567890"});

        // Add students to the request
        request.setAttribute("students", students);



        // Forward the request to students.jsp
        request.getRequestDispatcher("/pages/Users.jsp").forward(request, response);
    }
}