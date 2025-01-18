package com.example.eventspherefrontend.service;

import com.example.eventspherefrontend.model.Event;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class EventService {
    private static final String EVENTSAll_API_URL = "http://13.60.250.63:8081/events/getAll";
    private static final String EVENTS_API_URL = "http://13.60.250.63:8081/events/getAllEvents?eventDate=";
    private final Gson gson = new GsonBuilder().create();


    public List<Event> fetchEvents(String selectedDate, String jwtToken) {
        List<Event> events = new ArrayList<>();
        try {
            String apiUrl = EVENTS_API_URL + selectedDate;
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

                Type eventListType = new TypeToken<List<Event>>() {}.getType();
                events = gson.fromJson(jsonResponse.toString(), eventListType);
            } else {
                System.out.println("Failed to fetch events. HTTP response code: " + connection.getResponseCode());
            }
            connection.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return events;
    }
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
}
