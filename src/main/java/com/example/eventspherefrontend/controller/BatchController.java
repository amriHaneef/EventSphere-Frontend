package com.example.eventspherefrontend.controller;

import com.example.eventspherefrontend.model.Batch;
import com.example.eventspherefrontend.service.BatchService;
import com.google.gson.Gson;
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

@WebServlet(name = "BatchController", urlPatterns = "/pages/batches")
public class BatchController extends HttpServlet {
    private final BatchService batchService = new BatchService();
    private final Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String jwtToken = (String) session.getAttribute("jwtToken");

        if (jwtToken == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // Get form data
            String batchName = request.getParameter("batchName");
            String consultantId = request.getParameter("consultant");
            String startDate = request.getParameter("startDate");
            String status = request.getParameter("lecturer");

            // Create a Batch object
            Batch batch = new Batch();
            batch.setName(batchName);
            batch.setConsultantId(Integer.parseInt(consultantId));
            batch.setStartDate(startDate);
            batch.setStatus(status);

            // Convert Batch object to JSON
            String batchJson = gson.toJson(batch);

            // Call the service to submit the data
            boolean isSuccess = batchService.addBatch(jwtToken, batchJson);

            if (isSuccess) {
                // Redirect to the batch list page on success
                response.sendRedirect(request.getContextPath() + "/pages/Home?redirected=true&success=addBatch");
            } else {
                // Handle failure
                request.setAttribute("error", "Failed to add batch. Please try again.");
                request.getRequestDispatcher("/pages/addBatch.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while processing the request.");
            request.getRequestDispatcher("/pages/addBatch.jsp").forward(request, response);
        }
    }



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
        request.getRequestDispatcher("/pages/batch.jsp").forward(request, response);
    }
}
