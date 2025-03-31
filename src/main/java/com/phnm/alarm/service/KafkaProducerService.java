package com.phnm.alarm.service;

public interface KafkaProducerService {
    <T> void sendLog(String topic, T log);
}
