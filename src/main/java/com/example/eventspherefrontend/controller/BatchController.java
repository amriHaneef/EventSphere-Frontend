
package com.example.eventspherefrontend.controller;

import com.example.eventspherefrontend.model.Batch;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "BatchController", urlPatterns = "/pages/batches")
public class BatchController extends HttpServlet {
    private static final String BATCHES_API_URL = "http://13.60.250.63:8081/batch/getAll";


    private final Gson gson = new GsonBuilder()
            .create();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String jwtToken = (String) session.getAttribute("jwtToken");

        if (jwtToken == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        List<Batch> batches = fetchBatchesFromApi(BATCHES_API_URL, jwtToken, new TypeToken<List<Batch>>() {}.getType());

        if (batches == null) {
            batches = new ArrayList<>();
        }

        request.setAttribute("batches", batches);

        request.getRequestDispatcher("/pages/batch.jsp").forward(request, response);
    }



    private <T> List<T> fetchBatchesFromApi(String apiUrl, String jwtToken, Type type) {
        List<T> data = new ArrayList<>();
        try {
            URL url = new URL(apiUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Accept", "application/json");
            connection.setRequestProperty("Authorization", "Bearer " + jwtToken);

            if (connection.getResponseCode() == 200) {
                BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                StringBuilder jsonResponse = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    jsonResponse.append(line);
                }
                reader.close();

                data = gson.fromJson(jsonResponse.toString(), type);
            } else {
                System.out.println("Failed to fetch data. HTTP response code: " + connection.getResponseCode());
            }
            connection.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }

}
