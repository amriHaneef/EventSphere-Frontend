package com.example.eventspherefrontend.service;

import com.example.eventspherefrontend.model.Announcement;
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

    public boolean sendBatchAnnouncement(Announcement announcement, String jwtToken) {
        try {
            URL url = new URL(ANNOUNCEMENT_Add_Batch_API_URL);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestProperty("Authorization", "Bearer " + jwtToken);
            connection.setDoOutput(true);

            String jsonPayload = gson.toJson(announcement);
            try (OutputStream os = connection.getOutputStream()) {
                os.write(jsonPayload.getBytes());
                os.flush();
            }

            int responseCode = connection.getResponseCode();
            connection.disconnect();

            return responseCode == 200 || responseCode == 201;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
