package Project.Chat_Bot.chatbot;

import javax.management.RuntimeErrorException;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ChatRestController {
	
	private AnswerGenerator answerGenerator;
	
	public ChatRestController(AnswerGenerator answerGenerator) {
		super();
		this.answerGenerator = answerGenerator;
	}

	@GetMapping("/query/{chat}")
	public String generateResponse(@PathVariable String chat) {
		String answer = "response generated";
		return answer;
//		try {
//			String response = answerGenerator.generateContent(chat);
//			return response;
//		}catch (Exception e) {
//			throw new RuntimeException(e);
//		}		
	}
}
