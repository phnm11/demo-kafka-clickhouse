CREATE DATABASE IF NOT EXISTS alarm;

DROP TABLE alarm.alarm_logs_stored;

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
) ENGINE = MergeTree()
      ORDER BY detectionTime;

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

DROP TABLE alarm.alarm_logs_kafka;

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
      SETTINGS kafka_broker_list = 'kafka:9093',
          kafka_topic_list = 'alarm',
          kafka_group_name = 'clickhouse-alarm',
          kafka_format = 'JSONEachRow',
          kafka_num_consumers = 8,
          kafka_flush_interval_ms = 5000;

CREATE TABLE alarm.alarm_logs_kafka
(
    alarmIdentifier       String,
    alarmChangeTime       DateTime,
    severity              UInt32,
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
      SETTINGS kafka_broker_list = '25.0.0.250:9092',
          kafka_topic_list = 'tbl_history_alarm',
          kafka_group_name = 'alarm_group',
          kafka_format = 'JSONEachRow',
          kafka_flush_interval_ms = 5000;

DROP TABLE alarm.alarm_logs_mv;

CREATE MATERIALIZED VIEW alarm.alarm_logs_mv TO alarm.alarm_logs_stored AS
SELECT *
FROM alarm.alarm_logs_kafka;

-- ----- Create materialized view filter severity, eventType, productClass ------

-- Table to store alarm logs with severity Cleared
CREATE TABLE alarm.cleared_severity_alarm
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
) ENGINE = MergeTree()
      ORDER BY detectionTime;

CREATE MATERIALIZED VIEW alarm.cleared_severity_alarm_mv
    TO alarm.cleared_severity_alarm
AS
SELECT *
FROM alarm.alarm_logs_stored
WHERE severity = 'Cleared';

-- Table to store alarm logs with severity Indeterminate
CREATE TABLE alarm.indeterminate_severity_alarm
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
) ENGINE = MergeTree()
      ORDER BY detectionTime;

CREATE MATERIALIZED VIEW alarm.indeterminate_severity_alarm_mv
    TO alarm.indeterminate_severity_alarm
AS
SELECT *
FROM alarm.alarm_logs_stored
WHERE severity = 'Indeterminate';

-- Table to store alarm logs with severity Warning
CREATE TABLE alarm.warning_severity_alarm
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
) ENGINE = MergeTree()
      ORDER BY detectionTime;

CREATE MATERIALIZED VIEW alarm.warning_severity_alarm_mv
    TO alarm.warning_severity_alarm
AS
SELECT *
FROM alarm.alarm_logs_stored
WHERE severity = 'Warning';

-- Table to store alarm logs with eventType

-- Bảng cho eventType = 'mesh.04'
CREATE TABLE alarm.mesh_04_eventType_alarm
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
) ENGINE = MergeTree()
      ORDER BY detectionTime;

-- Bảng cho eventType = 'mesh.06'
CREATE TABLE alarm.mesh_06_eventType_alarm
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
) ENGINE = MergeTree()
      ORDER BY detectionTime;

-- Bảng cho eventType = 'sta.01'
CREATE TABLE alarm.sta_01_eventType_alarm
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
) ENGINE = MergeTree()
      ORDER BY detectionTime;

-- Bảng cho eventType = 'sta.06'
CREATE TABLE alarm.sta_06_eventType_alarm
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
) ENGINE = MergeTree()
      ORDER BY detectionTime;

-- Bảng cho eventType = 'eth.01'
CREATE TABLE alarm.eth_01_eventType_alarm
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
) ENGINE = MergeTree()
      ORDER BY detectionTime;

-- Bảng cho eventType = 'eth.02'
CREATE TABLE alarm.eth_02_eventType_alarm
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
) ENGINE = MergeTree()
      ORDER BY detectionTime;

-- Bảng cho eventType = 'sta.02'
CREATE TABLE alarm.sta_02_eventType_alarm
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
) ENGINE = MergeTree()
      ORDER BY detectionTime;

-- Bảng cho eventType = 'sta.14'
CREATE TABLE alarm.sta_14_eventType_alarm
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
) ENGINE = MergeTree()
      ORDER BY detectionTime;

-- Bảng cho eventType = 'sta.05'
CREATE TABLE alarm.sta_05_eventType_alarm
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
) ENGINE = MergeTree()
      ORDER BY detectionTime;

-- Create mv to filter eventType

CREATE MATERIALIZED VIEW alarm.mesh_04_eventType_alarm_mv
    TO alarm.mesh_04_eventType_alarm
AS
SELECT *
FROM alarm.alarm_logs_stored
WHERE eventType = 'mesh.04';

CREATE MATERIALIZED VIEW alarm.mesh_06_eventType_alarm_mv
    TO alarm.mesh_06_eventType_alarm
AS
SELECT *
FROM alarm.alarm_logs_stored
WHERE eventType = 'mesh.06';

CREATE MATERIALIZED VIEW alarm.sta_01_eventType_alarm_mv
    TO alarm.sta_01_eventType_alarm
AS
SELECT *
FROM alarm.alarm_logs_stored
WHERE eventType = 'sta.01';

CREATE MATERIALIZED VIEW alarm.sta_06_eventType_alarm_mv
    TO alarm.sta_06_eventType_alarm
AS
SELECT *
FROM alarm.alarm_logs_stored
WHERE eventType = 'sta.06';

CREATE MATERIALIZED VIEW alarm.eth_01_eventType_alarm_mv
    TO alarm.eth_01_eventType_alarm
AS
SELECT *
FROM alarm.alarm_logs_stored
WHERE eventType = 'eth.01';

CREATE MATERIALIZED VIEW alarm.eth_02_eventType_alarm_mv
    TO alarm.eth_02_eventType_alarm
AS
SELECT *
FROM alarm.alarm_logs_stored
WHERE eventType = 'eth.02';

CREATE MATERIALIZED VIEW alarm.sta_02_eventType_alarm_mv
    TO alarm.sta_02_eventType_alarm
AS
SELECT *
FROM alarm.alarm_logs_stored
WHERE eventType = 'sta.02';

CREATE MATERIALIZED VIEW alarm.sta_14_eventType_alarm_mv
    TO alarm.sta_14_eventType_alarm
AS
SELECT *
FROM alarm.alarm_logs_stored
WHERE eventType = 'sta.14';

CREATE MATERIALIZED VIEW alarm.sta_05_eventType_alarm_mv
    TO alarm.sta_05_eventType_alarm
AS
SELECT *
FROM alarm.alarm_logs_stored
WHERE eventType = 'sta.05';

-- Table to store alarm logs with productClass

CREATE TABLE alarm.vgp42x6v1_productClass_alarm
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
) ENGINE = MergeTree()
      ORDER BY detectionTime;

CREATE TABLE alarm.vgp42x6v1_productClass_alarm
(
    alarmIdentifier       String,
    alarmChangeTime       DateTime,
    severity              UInt32,
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

CREATE TABLE alarm.vg421wdv2_productClass_alarm
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
) ENGINE = MergeTree()
      ORDER BY detectionTime;

CREATE TABLE alarm.vg421wdv2_productClass_alarm
(
    alarmIdentifier       String,
    alarmChangeTime       DateTime,
    severity              UInt32,
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

CREATE TABLE alarm.vap120wd_productClass_alarm
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
) ENGINE = MergeTree()
      ORDER BY detectionTime;

CREATE TABLE alarm.vap120wd_productClass_alarm
(
    alarmIdentifier       String,
    alarmChangeTime       DateTime,
    severity              UInt32,
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

-- Create mv to filter productClass

CREATE MATERIALIZED VIEW alarm.vap120wd_productClass_alarm_mv
    TO alarm.vap120wd_productClass_alarm
AS
SELECT *
FROM alarm.alarm_logs_stored
WHERE productClass = 'vAP-120WD';

CREATE MATERIALIZED VIEW alarm.vg421wdv2_productClass_alarm_mv
    TO alarm.vg421wdv2_productClass_alarm
AS
SELECT *
FROM alarm.alarm_logs_stored
WHERE productClass = 'vG-421WD-v2';

CREATE MATERIALIZED VIEW alarm.vgp42x6v1_productClass_alarm_mv
    TO alarm.vgp42x6v1_productClass_alarm
AS
SELECT *
FROM alarm.alarm_logs_stored
WHERE productClass = 'vGP-42X6V1';