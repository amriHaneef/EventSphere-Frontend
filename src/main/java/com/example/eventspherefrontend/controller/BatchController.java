
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

        String userRole = "admin"; // This should be dynamically retrieved

        // Set the role in the request or session
        HttpSession session = request.getSession();
        session.setAttribute("role", userRole);

        request.getRequestDispatcher("/pages/batch.jsp").forward(request, response);
    }

}
