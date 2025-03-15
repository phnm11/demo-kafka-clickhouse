package com.phnm.alarm.service;

import com.phnm.alarm.dto.AlarmDTO;

import java.time.LocalDateTime;
import java.util.List;

public interface AlarmService {
    List<AlarmDTO> search(
            String severity,
            LocalDateTime detectionTime,
            String manufacturer,
            String productClass,
            String serialNumber,
            String eventType);
}
