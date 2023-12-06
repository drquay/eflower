package com.eflower.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;

@Component
@RequiredArgsConstructor
public class SocketHandler extends TextWebSocketHandler {
    private final ObjectMapper objectMapper;

    private List<WebSocketSession> sessions = new CopyOnWriteArrayList<>();

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message)
            throws InterruptedException, IOException {

        Map<String, String> value = objectMapper.readValue(message.getPayload(), Map.class);

        if (value.keySet().contains("subscribe")) {
            // connect.
        } else if (value.keySet().contains("unsubscribe")) {
            // disconnect.
        } else {
            // Send message to all sessions
            this.sendNotify(message);
        }
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        sessions.add(session);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) {
    }

    @Override
    protected void handleBinaryMessage(WebSocketSession session, BinaryMessage message) {
    }

    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) {
    }

    /**
     * Send message to all sessions
     * @param textMessage is a message.
     * @throws IOException is an exception.
     */
    public void sendNotify(TextMessage textMessage) throws IOException {
        for (int i = 0; i < sessions.size(); i++) {
            var webSocketSession = sessions.get(i);
            if (webSocketSession.isOpen()) {
                webSocketSession.sendMessage(textMessage);
            } else {
                sessions.remove(i--);
            }
        }
    }
}