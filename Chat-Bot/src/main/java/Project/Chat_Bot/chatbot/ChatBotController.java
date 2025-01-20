package Project.Chat_Bot.chatbot;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChatBotController {
	@RequestMapping("chat-bot")
	public String chatBot() {
		return "chatpage";
	}
}
