CREATE DATABASE IF NOT EXISTS alarm;

CREATE TABLE device_logs_stored
(
    deviceId String,
    timestamp DateTime,
    metric    String,
    value     Float64
) ENGINE = MergeTree()
      ORDER BY (deviceId, timestamp);

CREATE TABLE device_logs
(
    deviceId  String,
    timestamp DateTime,
    metric    String,
    value     Float64
) ENGINE = Kafka
      SETTINGS kafka_broker_list = 'kafka:9093',
          kafka_topic_list = 'device-log',
          kafka_group_name = 'clickhouse-alarm',
          kafka_format = 'JSONEachRow',
          kafka_flush_interval_ms = 5000;

-- Tạo Materialized View để chuyển dữ liệu từ Kafka sang bảng đích
CREATE MATERIALIZED VIEW device_logs_mv TO device_logs_stored AS
SELECT
    deviceId,
    timestamp,
    metric,
    value
FROM device_logs;
