package com.phnm.alarm.controller;

import com.phnm.alarm.dto.AlarmDTO;
import com.phnm.alarm.service.AlarmService;
import com.phnm.alarm.service.KafkaProducerService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/alarm")
public class AlarmController {
    private final KafkaProducerService kafkaProducerService;

    private final AlarmService alarmService;

    @PostMapping
    public ResponseEntity<String> sendLog(@RequestBody AlarmDTO alarmDTO) {
        kafkaProducerService.sendLog("alarm-topic", alarmDTO);
        return ResponseEntity.ok("Alarm sent to Kafka successfully");
    }

    @GetMapping("/search")
    public ResponseEntity<List<AlarmDTO>> search(
            @RequestParam(required = false) String severity,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime detectionTime,
            @RequestParam(required = false) String manufacturer,
            @RequestParam(required = false) String productClass,
            @RequestParam(required = false) String serialNumber,
            @RequestParam(required = false) String eventType) {
        return ResponseEntity.ok(alarmService.search(severity, detectionTime, manufacturer, productClass, serialNumber, eventType));
    }
}
