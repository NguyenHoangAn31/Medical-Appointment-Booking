package vn.aptech.backendapi.service.Report;

import java.time.LocalDate;
import java.util.List;

import vn.aptech.backendapi.dto.ReportDto;

public interface ReportService {
    List<ReportDto> findDoctorAppointmentsReport();
    List<ReportDto> findDoctorAppointmentsReport(LocalDate starDate , LocalDate enDate);
}
