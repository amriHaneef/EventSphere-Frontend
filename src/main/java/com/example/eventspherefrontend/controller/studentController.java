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

@WebServlet(name = "studentController", urlPatterns = "/pages/students")
public class studentController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        // Prepare the list of students
        List<String[]> students = new ArrayList<>();
        students.add(new String[]{"001", "John Doe","JohnDoe@gmail.com", "24-12-2002","GAHDSE24.2"});
        // Adding multiple students
        students.add(new String[]{"002", "John Doe","JohnDoe@gmail.com", "03-01-2000","GADSE21.3"});
        students.add(new String[]{"003", "Alice Smith","AliceSmith@gmail.com", "20-05-1999","GAHDSE23.2"});
        students.add(new String[]{"004", "Bob Johnson","BobJohnson@gmail.com", "25-02-2004","GADSE24.1"});

        // Add students to the request
        request.setAttribute("students", students);


        // Forward the request to students.jsp
        request.getRequestDispatcher("/pages/students.jsp").forward(request, response);
    }
}