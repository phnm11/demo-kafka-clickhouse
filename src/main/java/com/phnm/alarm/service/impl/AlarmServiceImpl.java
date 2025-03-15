package com.phnm.alarm.service.impl;

import com.phnm.alarm.dto.AlarmDTO;
import com.phnm.alarm.service.AlarmService;
import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AlarmServiceImpl implements AlarmService {

    private final JdbcTemplate jdbcTemplate;

    @Override
    public List<AlarmDTO> search(
            String severity,
            LocalDateTime detectionTime,
            String manufacturer,
            String productClass,
            String serialNumber,
            String eventType) {
        StringBuilder sql = new StringBuilder("SELECT * FROM alarm.alarm_logs_stored WHERE 1=1");

        List<Object> params = new ArrayList<>();

        if (severity != null) {
            sql.append(" AND severity = ?");
            params.add(severity);
        }
        if (detectionTime != null) {
            sql.append(" AND detectionTime >= ?");
            params.add(Timestamp.valueOf(detectionTime));
        }
        if (manufacturer != null) {
            sql.append(" AND manufacturer = ?");
            params.add(manufacturer);
        }
        if (productClass != null) {
            sql.append(" AND productClass = ?");
            params.add(productClass);
        }
        if (serialNumber != null) {
            sql.append(" AND serialNumber = ?");
            params.add(serialNumber);
        }
        if (eventType != null) {
            sql.append(" AND eventType = ?");
            params.add(eventType);
        }
        sql.append(" ORDER BY detectionTime DESC");

        return jdbcTemplate.query(sql.toString(), params.toArray(), this::mapRowToAlarmDTO);
    }

    private AlarmDTO mapRowToAlarmDTO(ResultSet rs, int rowNum) throws SQLException {
        AlarmDTO alarm = new AlarmDTO();

        alarm.setAlarmIdentifier(rs.getString("alarmIdentifier"));
        alarm.setAlarmChangeTime(rs.getTimestamp("alarmChangeTime").toLocalDateTime());
        alarm.setSeverity(rs.getString("severity"));
        alarm.setDetectionTime(rs.getTimestamp("detectionTime").toLocalDateTime());
        alarm.setManufacturer(rs.getString("manufacturer"));
        alarm.setProductClass(rs.getString("productClass"));
        alarm.setSerialNumber(rs.getString("serialNumber"));
        alarm.setEventType(rs.getString("eventType"));
        alarm.setEventTime(rs.getTimestamp("eventTime").toLocalDateTime());
        alarm.setCategory(rs.getString("category"));
        alarm.setProbableCause(rs.getString("probableCause"));
        alarm.setSpecificProblem(rs.getString("specificProblem"));
        alarm.setAdditionalText(rs.getString("additionalText"));
        alarm.setAdditionalInformation(rs.getString("additionalInformation"));
        alarm.setNotificationType(rs.getString("notificationType"));
        alarm.setManagedObjectInstance(rs.getString("managedObjectInstance"));
        alarm.setPppoeAccount(rs.getString("pppoeAccount"));
        alarm.setControllerSerial(rs.getString("controllerSerial"));

        return alarm;
    }
}
