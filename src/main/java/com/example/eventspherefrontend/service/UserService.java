package com.example.eventspherefrontend.service;

import com.example.eventspherefrontend.model.User;
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

public class UserService {
    private static final String USERS_API_URL = "http://13.60.250.63:8081/user/getAll";
    private static final String ADD_USER_API_URL = "http://13.60.250.63:8081/user/register"; // Replace with actual API endpoint
    // Replace with actual API endpoint
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

    public boolean addUser(User user, String jwtToken) {
        try {
            URL url = new URL(ADD_USER_API_URL);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestProperty("Authorization", "Bearer " + jwtToken);
            connection.setDoOutput(true);

            // Convert the User object to JSON
            String userJson = gson.toJson(user);

            // Write the JSON to the request body
            System.out.println("User JSON Payload: " + userJson);

            // Write the JSON to the request body
            try (OutputStream os = connection.getOutputStream()) {
                byte[] input = userJson.getBytes("utf-8");
                os.write(input, 0, input.length);
            }

            // Get the response code
            int responseCode = connection.getResponseCode();

            // Check the response code
            // Check the response code
            if (responseCode == HttpURLConnection.HTTP_OK || responseCode == HttpURLConnection.HTTP_CREATED) {
                return true;
            } else {
                // Read the response body to get more information about the failure
                InputStream errorStream = connection.getErrorStream();
                if (errorStream != null) {
                    BufferedReader reader = new BufferedReader(new InputStreamReader(errorStream));
                    StringBuilder errorResponse = new StringBuilder();
                    String line;
                    while ((line = reader.readLine()) != null) {
                        errorResponse.append(line);
                    }
                    System.out.println("Error Response: " + errorResponse.toString());
                }
                System.out.println("Failed to add user. HTTP response code: " + responseCode);
                return false;
            }

        }   catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}
