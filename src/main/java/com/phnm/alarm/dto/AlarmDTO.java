package com.phnm.alarm.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class AlarmDTO {
    private String alarmIdentifier;

    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime alarmChangeTime;

    private String severity;

    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime detectionTime;

    private String manufacturer;
    private String productClass;
    private String serialNumber;
    private String eventType;

    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss")
    private LocalDateTime eventTime;

    private String category;
    private String probableCause;
    private String specificProblem;
    private String additionalText;
    private String additionalInformation;
    private String notificationType;
    private String managedObjectInstance;
    private String pppoeAccount;
    private String controllerSerial;
}
