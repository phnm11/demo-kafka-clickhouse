CREATE TABLE alarm.productClass_report
(
    productClass  String,
    detectionTime DateTime,
    alarmCount    AggregateFunction(count)
)
    ENGINE = AggregatingMergeTree()
        PARTITION BY toYYYYMM(detectionTime)
        ORDER BY (productClass, detectionTime);

-- create mv to count data to productClass_report

CREATE MATERIALIZED VIEW alarm.productClass_to_report_mv
    TO alarm.productClass_report
AS
SELECT productClass,
       detectionTime,
       countState() as alarmCount
FROM alarm.alarm_logs_stored
GROUP BY productClass, detectionTime;

-- --------------------------------------------------

CREATE TABLE alarm.severity_report
(
    severity      String,
    detectionTime DateTime,
    alarmCount    AggregateFunction(count)
)
    ENGINE = AggregatingMergeTree()
        PARTITION BY toYYYYMM(detectionTime)
        ORDER BY (severity, detectionTime);

-- create mv to count data to severity_report

CREATE MATERIALIZED VIEW alarm.severity_to_report_mv
    TO alarm.severity_report
AS
SELECT severity,
       detectionTime,
       countState() as alarmCount
FROM alarm.alarm_logs_stored
GROUP BY severity, detectionTime;

-- --------------------------------------------------

CREATE TABLE alarm.eventType_report
(
    eventType     String,
    detectionTime DateTime,
    alarmCount    AggregateFunction(count)
)
    ENGINE = AggregatingMergeTree()
        PARTITION BY toYYYYMM(detectionTime)
        ORDER BY (eventType, detectionTime);

-- create mv to count data to eventType_report

CREATE MATERIALIZED VIEW alarm.eventType_to_report_mv
    TO alarm.eventType_report
AS
SELECT eventType,
       detectionTime,
       countState() as alarmCount
FROM alarm.alarm_logs_stored
GROUP BY eventType, detectionTime;

SELECT productClass,
       countMerge(alarmCount) AS TotalRecords
FROM alarm.productClass_report
-- WHERE detectionTime BETWEEN '2025-01-10 00:00:00' AND '2025-01-10 23:59:59'
GROUP BY productClass
ORDER BY productClass