package com.trycatch.coffee.util;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class WebsocketEndPoint extends TextWebSocketHandler {
	private static List<WebSocketSession> sessions = new ArrayList<>();
	@Override
	protected void handleTextMessage(WebSocketSession session,
			TextMessage message) throws Exception {
		
		TextMessage returnMessage = message;
		System.out.println(returnMessage.toString());
		//session.sendMessage(returnMessage);
		for(int i=0; i<sessions.size();i++){
			if(!sessions.get(i).getId().equals(session.getId())){
				sessions.get(i).sendMessage(returnMessage);}
		}
	}
	/* (non-Javadoc)
	 * @see org.springframework.web.socket.handler.AbstractWebSocketHandler#afterConnectionEstablished(org.springframework.web.socket.WebSocketSession)
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println(session.getId());
		sessions.add(session);
		super.afterConnectionEstablished(session);
	}
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("���� ����:");
		super.afterConnectionClosed(session, status);
	}
}