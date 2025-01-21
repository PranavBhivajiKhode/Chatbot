<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chatbot</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f9;
	margin: 0;
	padding: 0;
}

.chat-container {
	max-width: 600px;
	margin: 70px auto;
	background: #fff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.chat-header {
	font-size: 24px;
	text-align: center;
	margin-bottom: 20px;
	color: #333;
}

.chat-box {
	border: 1px solid #ddd;
	border-radius: 5px;
	padding: 10px;
	height: 300px;
	overflow-y: auto;
	background: #f9f9f9;
	margin-bottom: 10px;
}

.chat-message {
	margin: 5px 0;
}

.user-message {
	text-align: right;
	color: #0066cc;
}

.bot-message {
	text-align: left;
	color: #333;
}

.chat-input {
	display: flex;
}

.chat-input input {
	flex: 1;
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 5px 0 0 5px;
	outline: none;
}

.chat-input button {
	padding: 10px 15px;
	border: none;
	background: #0066cc;
	color: #fff;
	border-radius: 0 5px 5px 0;
	cursor: pointer;
}

.chat-input button:hover {
	background: #005bb5;
}
</style>
</head>
<body>
	<div class="chat-container">
		<div class="chat-header">Chatbot</div>
		<div class="chat-box" id="chatBox">
			<div class="chat-message bot-message">Hello! How can I assist
				you today?</div>
		</div>
			<div class="chat-input">
				<input type="text" id="userMessage" name="message"
					placeholder="Type your message here..." required>
				<button id="sendButton" onclick="sendMessage()">Send</button>
			</div>
	</div>

	<script>
	async function sendMessage() {
			const chatBox = document.getElementById('chatBox');
			const userMessage = document.getElementById('userMessage').value;

			// Add user message to chat box
			const userMessageElement = document.createElement('div');
			userMessageElement.className = 'chat-message user-message';
			userMessageElement.innerText = userMessage;
			chatBox.appendChild(userMessageElement);

			// Clear the input
			// document.getElementById('userMessage').value = '';

			// Simulate "Processing your query..." response
			const botMessageElement = document.createElement('div');
			botMessageElement.className = 'chat-message bot-message';
			botMessageElement.innerText = 'Processing your query...';
			chatBox.appendChild(botMessageElement);
			chatBox.scrollTop = chatBox.scrollHeight;

			// Call REST API
			const encodedMessage = `<c:out value="${fn:replace(fn:replace(userMessage, ' ', '%20'), '?', '%3F')}"/>`;
            const apiUrl = `http://localhost:8081/query/${encodedMessage}`;
			fetch(apiUrl, {
                method: 'GET', // Use the appropriate HTTP method
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok ' + response.statusText);
                }
                console.log(response.text());
                return response.text(); // Parse response as plain text
            })
            .then(data => {
                console.log(data);
                document.getElementById('result').innerText = data; // Display plain string response
            })
            .catch(error => {
                console.error('There was a problem with the fetch operation:', error);
                document.getElementById('result').innerText = 'Error: ' + error.message;
            });
        }

			chatBox.scrollTop = chatBox.scrollHeight;
	</script>

</body>
</html>























