<!DOCTYPE html>
<html>
<head>
    <title>Chatbot Interface</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            height: 100vh;
            background-color: #f4f4f9;
        }
        #chatbox {
            flex: 1;
            padding: 20px;
            overflow-y: auto;
            border-bottom: 1px solid #ccc;
            background-color: #ffffff;
        }
        #chatbox .message {
            margin-bottom: 10px;
        }
        #chatbox .user {
            text-align: right;
            color: blue;
        }
        #chatbox .bot {
            text-align: left;
            color: green;
        }
        #input-container {
            display: flex;
            padding: 10px;
            background-color: #eaeaea;
        }
        #user-input {
            flex: 1;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        #send-button {
            margin-left: 10px;
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            background-color: #007bff;
            color: white;
            cursor: pointer;
            border-radius: 5px;
        }
        #send-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div id="chatbox">
        <!-- Chat messages will appear here -->
    </div>
    <div id="input-container">
        <input type="text" id="user-input" placeholder="Type your message here...">
        <button id="send-button">Send</button>
    </div>

    <script>
        const chatbox = document.getElementById('chatbox');
        const userInput = document.getElementById('user-input');
        const sendButton = document.getElementById('send-button');

        function addMessage(message, sender) {
            const messageDiv = document.createElement('div');
            messageDiv.classList.add('message', sender);
            messageDiv.textContent = message;
            chatbox.appendChild(messageDiv);
            chatbox.scrollTop = chatbox.scrollHeight; // Scroll to the latest message
        }

        async function sendMessage() {
            const message = userInput.value.trim();
            if (!message) return;

            // Display user message
            addMessage(message, 'user');

            // Clear input field
            userInput.value = '';

            try {
                // Send the message to the backend
                const response = await fetch(`http://localhost:8081/query/${message}`);
                if (!response.ok) {
                    throw new Error('Failed to fetch response');
                }

                const botResponse = await response.text();

                // Display bot response
                addMessage(botResponse, 'bot');
            } catch (error) {
                addMessage('Error: Unable to fetch response. Please try again later.', 'bot');
                console.error(error);
            }
        }

        // Event listener for send button
        sendButton.addEventListener('click', sendMessage);

        // Event listener for Enter key
        userInput.addEventListener('keypress', (event) => {
            if (event.key === 'Enter') {
                sendMessage();
            }
        });
    </script>
</body>
</html>
