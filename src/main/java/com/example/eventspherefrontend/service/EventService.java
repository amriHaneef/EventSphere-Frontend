package com.example.eventspherefrontend.service;

import com.example.eventspherefrontend.model.Event;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class EventService {
    private static final String EVENTSAll_API_URL = "http://13.60.250.63:8081/events/getAll";
    private static final Gson gson = new GsonBuilder().create();


    public <T> List<T> fetchAllEvents(String jwtToken, Type type) {
        List<T> data = new ArrayList<>();
        try {
            URL url = new URL(EVENTSAll_API_URL);
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
    public boolean addEvent(Event event, String jwtToken) {
        boolean isEventAdded = false;

        try {
            URL url = new URL("http://13.60.250.63:8081/events/addEvent"); // Replace with your actual API URL
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json; utf-8");
            connection.setRequestProperty("Authorization", "Bearer " + jwtToken);
            connection.setDoOutput(true);

            // Create JSON payload using String.format
            String jsonPayload = String.format(
                    "{\"title\": \"%s\", \"type\": \"%s\", \"eventDate\": \"%s\", \"timePeriod\": \"%s\", \"platform\": \"%s\", \"status\": \"%s\", \"createdAt\":\"%s\"}",
                    event.getTitle(),
                    event.getType(),
                    event.getEventDate(),
                    event.getTimePeriod(),
                    event.getPlatform(),
                    event.getStatus(),
                    event.getCreatedAt()
            );

            System.out.println("JSON Payload: " + jsonPayload); // Debug payload

            // Write JSON to request body
            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = jsonPayload.getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            // Get the response code
            int responseCode = connection.getResponseCode();
            System.out.println("HTTP Response Code: " + responseCode);

            if (responseCode == HttpURLConnection.HTTP_OK || responseCode == HttpURLConnection.HTTP_CREATED) {
                isEventAdded = true;
            } else {
                System.out.println("Failed to add event. HTTP response code: " + responseCode);

                // Print error response
                InputStream errorStream = connection.getErrorStream();
                if (errorStream != null) {
                    String errorResponse = new BufferedReader(new InputStreamReader(errorStream))
                            .lines()
                            .reduce("", String::concat);
                    System.out.println("Error Response: " + errorResponse);
                }
            }

        } catch (Exception e) {
            e.printStackTrace(); // Log exceptions
        }

        return isEventAdded;
    }



}