package com.example.eventspherefrontend.service;

import com.example.eventspherefrontend.model.Announcement;
import com.example.eventspherefrontend.model.StudentAnnouncement;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import java.io.*;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class AnnouncementService {
    private static final String ANNOUNCEMENTS_API_URL = "http://13.60.250.63:8081/Announcement/getAll";
    private static final String CREATE_ANNOUNCEMENT_API_URL = "http://13.60.250.63:8081/Announcement/add";
    private static final String ANNOUNCEMENT_Add_Batch_API_URL = "http://13.60.250.63:8081/Announcement/addBatch";
    private static final String ANNOUNCEMENT_Add_Student_API_URL = "http://13.60.250.63:8081/Announcement/addStudent";


    private final Gson gson = new GsonBuilder().create();

    public <T> List<T> fetchAnnouncements(String jwtToken, Type type) {
        List<T> data = new ArrayList<>();
        try {
            URL url = new URL(ANNOUNCEMENTS_API_URL);
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

    public boolean createAnnouncement(Announcement announcement, String jwtToken) {
        boolean isCreated = false;
        try {
            URL url = new URL(CREATE_ANNOUNCEMENT_API_URL);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestProperty("Authorization", "Bearer " + jwtToken);
            connection.setDoOutput(true);

            String jsonPayload = String.format("{\"title\": \"%s\", \"content\": \"%s\", \"createdBy\": \"%s\", \"role\": \"%s\"}",
                    announcement.getTitle(), announcement.getContent(), announcement.getCreatedBy(), announcement.getRole());

            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = jsonPayload.getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_CREATED) {
                isCreated = true;
            }

            connection.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isCreated;
    }

    public boolean sendBatchAnnouncement(StudentAnnouncement studentAnnouncement, String jwtToken) {
        try {
            System.out.println("Preparing to send batch announcement...");

            URL url = new URL(ANNOUNCEMENT_Add_Batch_API_URL);
            System.out.println("API URL: " + ANNOUNCEMENT_Add_Batch_API_URL);

            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestProperty("Authorization", "Bearer " + jwtToken);
            connection.setDoOutput(true);

            System.out.println("Request properties set. Preparing JSON payload...");

            String jsonPayload = gson.toJson(studentAnnouncement);
            System.out.println("JSON Payload: " + jsonPayload);

            try (OutputStream os = connection.getOutputStream()) {
                os.write(jsonPayload.getBytes());
                os.flush();
                System.out.println("Payload sent to the API.");
            }

            int responseCode = connection.getResponseCode();
            System.out.println("Response Code: " + responseCode);

            connection.disconnect();
            System.out.println("Connection closed.");

            boolean success = responseCode == 200 || responseCode == 201;
            System.out.println("Operation success: " + success);
            return success;
        } catch (Exception e) {
            System.out.println("An error occurred: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean sendStudentAnnouncement(StudentAnnouncement studentAnnouncement, String jwtToken) {
        try {
            System.out.println("Preparing to send student announcement...");

            URL url = new URL(ANNOUNCEMENT_Add_Student_API_URL);
            System.out.println("API URL: " + ANNOUNCEMENT_Add_Student_API_URL);

            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestProperty("Authorization", "Bearer " + jwtToken);
            connection.setDoOutput(true);

            System.out.println("Request properties set. Preparing JSON payload...");

            String jsonPayload = gson.toJson(studentAnnouncement);
            System.out.println("JSON Payload: " + jsonPayload);

            try (OutputStream os = connection.getOutputStream()) {
                os.write(jsonPayload.getBytes());
                os.flush();
                System.out.println("Payload sent to the API.");
            }

            int responseCode = connection.getResponseCode();
            System.out.println("Response Code: " + responseCode);

            connection.disconnect();
            System.out.println("Connection closed.");

            boolean success = responseCode == 200 || responseCode == 201;
            System.out.println("Operation success: " + success);
            return success;
        } catch (Exception e) {
            System.out.println("An error occurred: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

}
