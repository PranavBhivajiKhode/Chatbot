package Project.Chat_Bot.chatbot;

import org.springframework.stereotype.Component;
import okhttp3.*;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import java.io.IOException;

@Component
public class AnswerGenerator {

    private static final String API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent";
    private static final String API_KEY = "AIzaSyD7Ue92YSSq5FLe2OpEU99Yv50HkQwLEgc"; 

    public static String generateContent(String prompt) throws IOException {
        OkHttpClient client = new OkHttpClient();

        String json = "{\"contents\": [{\n    \"parts\": [{\n      \"text\": \"" + prompt + "\"\n    }]\n  }]}";

        MediaType mediaType = MediaType.parse("application/json");
        RequestBody body = RequestBody.create(mediaType, json);

        Request request = new Request.Builder()
                .url(API_URL + "?key=" + API_KEY)
                .post(body)
                .addHeader("Content-Type", "application/json")
                .build();

        try (Response response = client.newCall(request).execute()) {
            if (!response.isSuccessful()) {
                throw new IOException("Unexpected code " + response);
            }

            String responseBody = response.body().string();

            // Parse JSON response using Gson
            Gson gson = new Gson();
            JsonObject jsonObject = gson.fromJson(responseBody, JsonObject.class);

            JsonArray candidates = jsonObject.getAsJsonArray("candidates");
            if (candidates != null && candidates.size() > 0) {
                JsonObject candidate = candidates.get(0).getAsJsonObject();
                JsonArray contentParts = candidate.getAsJsonObject("content").getAsJsonArray("parts");
                if (contentParts!=null && contentParts.size() > 0) {
                    StringBuilder generatedText = new StringBuilder();
                    for(JsonElement part:contentParts){
                        generatedText.append(part.getAsJsonObject().get("text").getAsString());
                    }
                    return generatedText.toString();

                }
                else{
                    return "No text content found in the response";
                }

            } else {
                return "No candidates found in the response";
            }
        }
    }

    
}