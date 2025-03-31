SELECT productClass,
       countMerge(alarmCount) AS TotalRecords
FROM alarm.productClass_report
-- WHERE detectionTime BETWEEN '2025-01-10 00:00:00' AND '2025-01-10 23:59:59'
GROUP BY productClass
ORDER BY productClass;

-- ------------------------------------

SELECT severity,
       countMerge(alarmCount) AS TotalRecords
FROM alarm.severity_report
-- WHERE detectionTime BETWEEN '2025-01-10 00:00:00' AND '2025-01-10 23:59:59'
GROUP BY severity
ORDER BY severity;

-- ------------------------------------

SELECT eventType,
       countMerge(alarmCount) AS TotalRecords
FROM alarm.eventType_report
-- WHERE detectionTime BETWEEN '2025-01-10 00:00:00' AND '2025-01-10 23:59:59'
GROUP BY eventType
ORDER BY eventType

SELECT * FROM alarm.alarm_logs_stored final;