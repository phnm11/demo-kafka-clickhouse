CREATE DATABASE IF NOT EXISTS alarm;

CREATE TABLE alarm.alarm_logs_stored
(
    alarmIdentifier       String,
    alarmChangeTime       DateTime,
    severity              String,
    detectionTime         DateTime,
    manufacturer          String,
    productClass          String,
    serialNumber          String,
    eventType             String,
    eventTime             DateTime,
    category              String,
    probableCause         String,
    specificProblem       String,
    additionalText        String,
    additionalInformation String,
    notificationType      String,
    managedObjectInstance String,
    pppoeAccount          String,
    controllerSerial      String
) ENGINE = ReplacingMergeTree(eventTime)
      ORDER BY alarmIdentifier;

CREATE TABLE alarm.alarm_logs_kafka
(
    alarmIdentifier       String,
    alarmChangeTime       DateTime,
    severity              String,
    detectionTime         DateTime,
    manufacturer          String,
    productClass          String,
    serialNumber          String,
    eventType             String,
    eventTime             DateTime,
    category              String,
    probableCause         String,
    specificProblem       String,
    additionalText        String,
    additionalInformation String,
    notificationType      String,
    managedObjectInstance String,
    pppoeAccount          String,
    controllerSerial      String
) ENGINE = Kafka
      SETTINGS kafka_broker_list = '210.245.74.43:9092',
          kafka_topic_list = 'alarm',
          kafka_group_name = 'clickhouse-alarm',
          kafka_format = 'JSONEachRow',
          kafka_num_consumers = 8,
          kafka_flush_interval_ms = 5000;

CREATE
MATERIALIZED VIEW alarm.alarm_logs_mv TO alarm.alarm_logs_stored AS
SELECT *
FROM alarm.alarm_logs_kafka;