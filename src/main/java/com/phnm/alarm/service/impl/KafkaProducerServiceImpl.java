package com.phnm.alarm.service.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.phnm.alarm.service.KafkaProducerService;
import lombok.RequiredArgsConstructor;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class KafkaProducerServiceImpl implements KafkaProducerService {
    private final KafkaTemplate<String, String> kafkaTemplate;

    private final ObjectMapper objectMapper;


    @Override
    public <T> void sendLog(String topic, T log) {
        try {
            String jsonLog = objectMapper.writeValueAsString(log);
            kafkaTemplate.send(topic, jsonLog);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
