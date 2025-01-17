package com.example.eventspherefrontend.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.example.eventspherefrontend.model.Batch;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "BatchController", urlPatterns = "/pages/batches")
public class BatchController extends HttpServlet {
    private static final String BATCHES_API_URL = "http://13.60.250.63:8081/batch/getAll";

    private final Gson gson = new GsonBuilder().create();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String jwtToken = (String) session.getAttribute("jwtToken");

        // Redirect to login if no JWT token is found
        if (jwtToken == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Fetch batches from API
        List<Batch> batches = fetchBatchesFromApi(BATCHES_API_URL, jwtToken);

        // Handle null case for batches
        if (batches == null) {
            batches = new ArrayList<>();
        }

        // Prepare batch details for JSP
        List<String[]> batchDetails = new ArrayList<>();
        for (Batch batch : batches) {
            String[] details = {
                    String.valueOf(batch.getId()),
                    batch.getName(),
                    batch.getConsultantName(),
                    batch.getStartDate(),
                    batch.getStatus(),
                    batch.getCreatedAt(),
                    batch.getUpdatedAt()
            };
            batchDetails.add(details);
        }

        // Set attributes and forward to JSP
        request.setAttribute("batches", batchDetails);
        request.getRequestDispatcher("/pages/batch.jsp").forward(request, response);
    }

    private List<Batch> fetchBatchesFromApi(String apiUrl, String jwtToken) {
        HttpURLConnection connection = null;
        BufferedReader reader = null;

        try {
            URL url = new URL(apiUrl);
            connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Authorization", "Bearer " + jwtToken);
            connection.setRequestProperty("Content-Type", "application/json");

            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                StringBuilder responseBuilder = new StringBuilder();
                String line;

                while ((line = reader.readLine()) != null) {
                    responseBuilder.append(line);
                }

                // Parse JSON response into Batch list
                return gson.fromJson(responseBuilder.toString(), new TypeToken<List<Batch>>() {}.getType());
            } else {
                System.err.println("Error fetching batches: HTTP " + responseCode);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Clean up resources
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                connection.disconnect();
            }
        }
        return null;
    }
}
