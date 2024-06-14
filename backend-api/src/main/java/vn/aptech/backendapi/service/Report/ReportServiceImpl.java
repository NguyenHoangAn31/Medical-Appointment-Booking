package vn.aptech.backendapi.service.Report;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import vn.aptech.backendapi.dto.ReportDto;
import vn.aptech.backendapi.repository.AppointmentRepository;

@Service
public class ReportServiceImpl implements ReportService {
    @Autowired
    private AppointmentRepository appointmentRepository;

    @Override
    public List<ReportDto> findDoctorAppointmentsReport() {
        List<ReportDto> result = appointmentRepository.findDoctorAppointmentsReport(LocalDate.now(), LocalDate.now());
        // for (ReportDto reportDto : result) {
        //     reportDto.setTotal(reportDto.getPrice() * reportDto.getCountSuccess()
        //             + (reportDto.getPrice() * 0.3) * reportDto.getCountCancel());
        // }
        return result;
    }

    @Override
    public List<ReportDto> findDoctorAppointmentsReport(LocalDate startDate, LocalDate endDate) {
        List<ReportDto> result = appointmentRepository.findDoctorAppointmentsReport(startDate, endDate);
        // for (ReportDto reportDto : result) {
        //     reportDto.setTotal(reportDto.getPrice() * reportDto.getCountSuccess()
        //             + (reportDto.getPrice() * 0.3) * reportDto.getCountCancel());
        // }
        return result;
    }
}
