package com.example.eventspherefrontend.service;

import com.example.eventspherefrontend.model.User;
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

public class UserService {
    private static final String USERS_API_URL = "http://13.60.250.63:8081/user/getAll"; // Replace with actual API endpoint
    private final Gson gson = new GsonBuilder().create();

    /**
     * Fetches all users from the backend API using the provided JWT token.
     *
     * @param jwtToken The JWT token for authentication.
     * @param type     The type for deserializing the JSON response.
     * @return A list of User objects or an empty list if an error occurs.
     */

    public <T> List<T> fetchUsers(String jwtToken, Type type) {
        List<T> users = new ArrayList<>();
        try {
            URL url = new URL(USERS_API_URL);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");
            connection.setRequestProperty("Accept", "application/json");
            connection.setRequestProperty("Authorization", "Bearer " + jwtToken);

            if (connection.getResponseCode() == 200) { // HTTP OK
                BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                StringBuilder jsonResponse = new StringBuilder();
                String line;
                while ((line = reader.readLine()) != null) {
                    jsonResponse.append(line);
                }
                reader.close();

                // Parse the JSON response into the specified type
                users = gson.fromJson(jsonResponse.toString(), type);
            } else {
                System.out.println("Failed to fetch users. HTTP response code: " + connection.getResponseCode());
            }
            connection.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }
}
