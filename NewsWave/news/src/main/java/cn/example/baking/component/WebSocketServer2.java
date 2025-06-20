package cn.example.baking.component;

import cn.hutool.json.JSONArray;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @author: KaiyanWang
 * @version: 1.0
 * @DateTime: 2025-06-19 9:18
 */
@ServerEndpoint(value = "/imserver2/{username}")
@Component
public class WebSocketServer2 {
    private static final Logger log = LoggerFactory.getLogger(WebSocketServer.class);

    /** 记录当前在线连接（用户名 -> Session） */
    public static final Map<String, Session> sessionMap = new ConcurrentHashMap<>();

    /** 连接建立成功时调用 */
    @OnOpen
    public void onOpen(Session session, @PathParam("username") String username) {
        sessionMap.put(username, session);
        log.info("用户 {} 加入，当前在线人数: {}", username, sessionMap.size());
        sendOnlineUsers(); // 发送在线用户列表
    }

    /** 连接关闭时调用 */
    @OnClose
    public void onClose(@PathParam("username") String username) {
        sessionMap.remove(username);
        log.info("用户 {} 离开，当前在线人数: {}", username, sessionMap.size());
        sendOnlineUsers(); // 发送在线用户列表
    }

    /** 收到客户端消息时调用 */
    @OnMessage
    public void onMessage(String message, Session session, @PathParam("username") String username) {
        log.info("收到用户 {} 的消息: {}", username, message);
        JSONObject obj = JSONUtil.parseObj(message);

        // 处理连接请求（前端发送的连接请求）
        if (obj.containsKey("type") && "requestConnect".equals(obj.getStr("type"))) {
            String toUsername = obj.getStr("to");
            Session toSession = sessionMap.get(toUsername);
            if (toSession != null) {
                // 向目标用户发送连接请求
                JSONObject connectMsg = new JSONObject();
                connectMsg.put("type", "connectRequest");
                connectMsg.put("from", username);
                sendMessage(connectMsg.toString(), toSession);
                log.info("已通知用户 {} 连接用户 {}", toUsername, username);
            } else {
                log.info("目标用户 {} 不在线，无法建立连接", toUsername);
            }
        }
        // 处理普通聊天消息
        else {
            String toUsername = obj.getStr("to");
            String text = obj.getStr("text");
            Session toSession = sessionMap.get(toUsername);
            if (toSession != null) {
                // 组装消息并发送给目标用户
                JSONObject msg = new JSONObject();
                msg.put("from", username);
                msg.put("text", text);
                sendMessage(msg.toString(), toSession);
                log.info("发送消息给用户 {}: {}", toUsername, msg.toString());
            } else {
                log.info("目标用户 {} 不在线，消息发送失败", toUsername);
            }
        }
    }

    @OnError
    public void onError(Session session, Throwable error) {
        log.error("WebSocket错误", error);
    }

    /** 发送消息给指定Session */
    private void sendMessage(String message, Session toSession) {
        try {
            log.info("发送消息给用户 [{}]: {}", toSession.getId(), message);
            toSession.getBasicRemote().sendText(message);
        } catch (Exception e) {
            log.error("发送消息失败", e);
        }
    }

    /** 发送在线用户列表给所有客户端 */
    private void sendOnlineUsers() {
        JSONObject result = new JSONObject();
        JSONArray array = new JSONArray();
        result.put("users", array);

        for (String key : sessionMap.keySet()) {
            JSONObject user = new JSONObject();
            user.put("username", key);
            array.add(user);
        }

        sendAllMessage(result.toString());
    }

    /** 发送消息给所有客户端 */
    private void sendAllMessage(String message) {
        for (Session session : sessionMap.values()) {
            sendMessage(message, session);
        }
    }
}