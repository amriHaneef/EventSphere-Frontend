package com.example.eventspherefrontend.service;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class BatchService {
    private static final String BATCHES_API_URL = "http://13.60.250.63:8081/batch/getAll";
    private final Gson gson = new GsonBuilder().create();

    public <T> List<T> fetchBatches(String jwtToken, Type type) {
        List<T> data = new ArrayList<>();
        try {
            URL url = new URL(BATCHES_API_URL);
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


    public <T> List<T> fetchBatchStudents(String jwtToken, String batchId, Type type) {
        List<T> data = new ArrayList<>();
        String apiUrl = "http://13.60.250.63:8081/batch/getStudents?batchId=" + 1;

        try {
            System.out.println("API URL: " + apiUrl);
            URL url = new URL(apiUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Accept", "application/json");
            connection.setRequestProperty("Authorization", "Bearer " + jwtToken);

            // Log request headers for debugging
            System.out.println("Request Method: " + connection.getRequestMethod());
            System.out.println("Request Property - Accept: " + connection.getRequestProperty("Accept"));
            System.out.println("Request Property - Authorization: " + connection.getRequestProperty("Authorization"));

            int responseCode = connection.getResponseCode();
            System.out.println("Response Code: " + responseCode);

            if (responseCode == 200) { // HTTP OK
                System.out.println("Successfully connected to the API.");

                BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                StringBuilder jsonResponse = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    jsonResponse.append(line);
                }
                reader.close();

                System.out.println("JSON Response: " + jsonResponse.toString());
                data = new Gson().fromJson(jsonResponse.toString(), type);

                // Log parsed data
                System.out.println("Parsed Data: " + data);
            } else {
                System.out.println("Failed to fetch students. HTTP response code: " + responseCode);
            }

            connection.disconnect();
        } catch (Exception e) {
            System.out.println("An error occurred while fetching batch students.");
            e.printStackTrace();
        }
        return data;
    }

    public boolean addBatch(String jwtToken, String batchJson) {
        String apiUrl = "http://13.60.250.63:8081/batch/add";
        try {
            URL url = new URL(apiUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestProperty("Authorization", "Bearer " + jwtToken);
            connection.setDoOutput(true);

            // Write the JSON data to the request body
            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = batchJson.getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            int responseCode = connection.getResponseCode();

            if (responseCode == HttpURLConnection.HTTP_OK || responseCode == HttpURLConnection.HTTP_CREATED) {
                return true;
            } else {
                System.out.println("Failed to add batch. HTTP response code: " + responseCode);
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }



}
