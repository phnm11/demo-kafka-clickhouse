package com.phnm.alarm.service.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.phnm.alarm.service.KafkaProducerService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.kafka.support.KafkaHeaders;
import org.springframework.kafka.support.SendResult;
import org.springframework.messaging.Message;
import org.springframework.messaging.support.MessageBuilder;
import org.springframework.stereotype.Service;

import java.util.concurrent.CompletableFuture;


@Service
@RequiredArgsConstructor
public class KafkaProducerServiceImpl implements KafkaProducerService {
    private static final Logger logger = LoggerFactory.getLogger(KafkaProducerServiceImpl.class);
    private final KafkaTemplate<String, String> kafkaTemplate;
    private final ObjectMapper objectMapper;

    @Override
    public <T> void sendLog(String topic, T log) {
        try {
            String jsonLog = objectMapper.writeValueAsString(log);

            CompletableFuture<SendResult<String, String>> future = kafkaTemplate.send(topic, jsonLog);

            future.whenComplete((result, ex) -> {
                if (ex != null) {
                    // Chỉ log khi có lỗi
                    logger.error("Failed to send message to topic {}: {}", topic, ex.getMessage());
                }
            });
        } catch (Exception e) {
            // Log lỗi serialization
            logger.error("Error serializing log: {}", e.getMessage());
        }
    }
}
