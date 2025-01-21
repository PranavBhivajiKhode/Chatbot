<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Chatbot</title>
    <script>
    async function sendMessage() {
        const userMessage = document.getElementById("userMessage").value;
        const chatBox = document.getElementById("chatBox");

        if (userMessage.trim() === "") {
            alert("Please enter a message!");
            return;
        }

        // Display user's message in chat
        const userChat = `<div style="text-align: right;"><b>You:</b> ${userMessage}</div>`;
        chatBox.innerHTML += userChat;

        // Fetch response from the server
        const apiUrl = `http://localhost:8081/query/${userMessage}`;
        try {
            const response = await fetch(apiUrl, {
                method: 'GET',
            });
            const generatedResponse = await response.text();

            // Display system response in chat
            const botChat = `<div style="text-align: left;"><b>Bot:</b> ${generatedResponse}</div>`;
            chatBox.innerHTML += botChat;

            // Scroll chat box to the bottom
            chatBox.scrollTop = chatBox.scrollHeight;

        } catch (error) {
            console.error("Error fetching response:", error);
            chatBox.innerHTML += `<div style="text-align: left;"><b>Error:</b> Could not fetch response.</div>`;
        }

        // Clear input box
        document.getElementById("userMessage").value = "";
    }
</script>

    <style>
        body {
            font-family: Arial, sans-serif;
        }
        #chatContainer {
            width: 50%;
            margin: auto;
            margin-top: 50px;
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 10px;
            background-color: #f9f9f9;
        }
        #chatBox {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 10px;
            height: 300px;
            overflow-y: scroll;
            background-color: #ffffff;
            margin-bottom: 20px;
        }
        #inputContainer {
            display: flex;
            gap: 10px;
        }
        #userMessage {
            flex: 1;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        #sendButton {
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        #sendButton:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div id="chatContainer">
        <h2>Chatbot</h2>
        <div id="chatBox"></div>
        <div id="inputContainer">
            <input type="text" id="userMessage" placeholder="Type your message here..." />
            <button id="sendButton" onclick="sendMessage()">Submit</button>
        </div>
    </div>
</body>
</html>
