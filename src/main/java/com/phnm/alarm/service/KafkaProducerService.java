package com.phnm.alarm.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.phnm.alarm.dto.DeviceLog;
import lombok.RequiredArgsConstructor;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class KafkaProducerService {
    private final KafkaTemplate<String, String> kafkaTemplate;

    private final ObjectMapper objectMapper;

    public void sendLog(String topic, DeviceLog log) {
        try {
            String jsonLog = objectMapper.writeValueAsString(log);
            kafkaTemplate.send(topic, jsonLog);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
