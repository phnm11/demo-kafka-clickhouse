package com.phnm.alarm.controller;

import com.phnm.alarm.dto.DeviceLog;
import com.phnm.alarm.service.impl.KafkaProducerServiceImpl;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/device-log")
public class DeviceLogController {
    private final KafkaProducerServiceImpl kafkaProducerService;

    @PostMapping
    public ResponseEntity<String> sendLog(@RequestBody DeviceLog deviceLog) {
        kafkaProducerService.sendLog("device-log", deviceLog);
        return ResponseEntity.ok("Log sent to Kafka successfully");
    }
}
