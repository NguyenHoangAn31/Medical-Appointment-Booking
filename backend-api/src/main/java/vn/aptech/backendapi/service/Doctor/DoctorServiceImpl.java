package vn.aptech.backendapi.service.Doctor;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import vn.aptech.backendapi.dto.DepartmentDto;
import vn.aptech.backendapi.dto.DoctorDto;
import vn.aptech.backendapi.dto.Feedback.FeedbackDto;
import vn.aptech.backendapi.dto.QualificationDto;
import vn.aptech.backendapi.dto.WorkingDto;

import vn.aptech.backendapi.entities.*;
import vn.aptech.backendapi.repository.DepartmentRepository;
import vn.aptech.backendapi.repository.DoctorRepository;

import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class DoctorServiceImpl implements DoctorService {

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private DepartmentRepository departmentRepository;

    @Autowired
    private ModelMapper mapper;

    private DoctorDto toDto(Doctor p) {
        return mapper.map(p, DoctorDto.class);
    }

    private DoctorDto mapToDoctorDto(Doctor doctor) {
        DoctorDto doctorDto = new DoctorDto();
        doctorDto.setId(String.valueOf(doctor.getId()));
        doctorDto.setFullName(doctor.getFullName());
        doctorDto.setTitle(doctor.getTitle());
        doctorDto.setGender(doctor.getGender());
        doctorDto.setBirthday(doctor.getBirthday().toString());
        doctorDto.setAddress(doctor.getAddress());
        doctorDto.setImage(doctor.getImage());
        doctorDto.setBiography(doctor.getBiography());
        doctorDto.setPrice(doctor.getPrice());
        doctorDto.setStatus(doctor.isStatus());
        doctorDto.setDepartment(doctor.getDepartment());
        return doctorDto;
    }

    private WorkingDto mapToWorkingDto(Working working) {
        WorkingDto workingDto = new WorkingDto();
        workingDto.setId(working.getId());
        workingDto.setCompany(working.getCompany());
        workingDto.setAddress(working.getAddress());
        workingDto.setStartWork(working.getStartWork().toString());
        workingDto.setEndWork(working.getEndWork().toString());
        workingDto.setDoctor_id(working.getDoctor().getId());
        return workingDto;
    }

    private QualificationDto mapToQualificationDto(Qualification qualification) {
        QualificationDto qualificationDto = new QualificationDto();
        qualificationDto.setId(qualification.getId());
        qualificationDto.setDegreeName(qualification.getDegreeName());
        qualificationDto.setUniversityName(qualification.getUniversityName());
        qualificationDto.setCourse(qualificationDto.getCourse());
        return qualificationDto;
    }
    private FeedbackDto mapToFeedbackDto(Feedback feedback) {
        FeedbackDto feedbackDto = new FeedbackDto();
        feedbackDto.setId(feedback.getId());
        feedbackDto.setPatientId(feedback.getPartient().getId());
        feedbackDto.setComment(feedback.getComment());
        feedbackDto.setRate(feedback.getRate());
        return feedbackDto;
    }

    public List<DoctorDto> findAll(){
        List<Doctor> doctors = doctorRepository.findAll();
        doctors = doctors.stream()
                .filter(Doctor::isStatus) // Giả sử trường status là isActive
                .collect(Collectors.toList());
        List<DoctorDto> doctorDtos = doctors.stream()
                .map(this::mapToDoctorDto)
                .collect(Collectors.toList());

        for (DoctorDto doctorDto : doctorDtos) {
            Doctor doctor = doctorRepository.findById(Integer.valueOf(doctorDto.getId())).orElse(null);
            if (doctor != null) {
                List<WorkingDto> workingList = doctor.getWorkings().stream()
                        .map(this::mapToWorkingDto)
                        .collect(Collectors.toList());
                List<QualificationDto> qualificationList = doctor.getQualifications().stream()
                        .map(this::mapToQualificationDto)
                        .collect(Collectors.toList());
                List<FeedbackDto> feedbackList = doctor.getFeedbacks().stream().map(this::mapToFeedbackDto)
                                .collect(Collectors.toList());

                double totalRating = 0;
                if (!feedbackList.isEmpty()) {
                    totalRating = feedbackList.stream()
                            .mapToDouble(FeedbackDto::getRate)
                            .sum() / feedbackList.size();
                }
                doctorDto.setWorkings(workingList);
                doctorDto.setQualifications(qualificationList);
                doctorDto.setFeedbackDtoList(feedbackList);
                doctorDto.setRate(totalRating);
            }
        }
        return doctorDtos;
    }

    public Optional<DoctorDto> findById(int doctorId) {
        Optional<Doctor> optionalDoctor = doctorRepository.findById(doctorId);

        if (optionalDoctor.isPresent()) {
            Doctor doctor = optionalDoctor.get();
            List<WorkingDto> workingList = doctor.getWorkings().stream()
                    .map(this::mapToWorkingDto)
                    .collect(Collectors.toList());
            List<QualificationDto> qualificationList = doctor.getQualifications().stream()
                    .map(this::mapToQualificationDto)
                    .collect(Collectors.toList());

            List<FeedbackDto> feedbackList = doctor.getFeedbacks().stream().map(this::mapToFeedbackDto)
                    .collect(Collectors.toList());

            double totalRating = 0;
            if (!feedbackList.isEmpty()) {
                totalRating = feedbackList.stream()
                        .mapToDouble(FeedbackDto::getRate)
                        .average()
                        .orElse(0);
            }
            DoctorDto doctorDto = mapToDoctorDto(doctor);
            doctorDto.setWorkings(workingList);
            doctorDto.setQualifications(qualificationList);
            doctorDto.setFeedbackDtoList(feedbackList);
            doctorDto.setRate(totalRating);
            return Optional.of(doctorDto);
        } else {
            return Optional.empty(); // Trả về Optional rỗng nếu không tìm thấy Doctor
        }
    }

    // Hien Create 30/4/2024
    @Override
    public List<DoctorDto> findDoctorsByDepartmentId(int departmentId) {
        // Truy vấn danh sách bác sĩ có cùng chuyên khoa
        List<Doctor> doctors = doctorRepository.findDoctorsByDepartmentId(departmentId);
        List<Doctor> activeDoctors = doctors.stream()
                .filter(Doctor::isStatus) // Giả sử trường status là isActive
                .collect(Collectors.toList());

        List<DoctorDto> doctorDtos = activeDoctors.stream()
                .map(doctor -> {
                    DoctorDto doctorDto = mapToDoctorDto(doctor);

                    // Tính trung bình của các đánh giá
                    double totalRating = 0;
                    List<FeedbackDto> feedbackList = doctor.getFeedbacks().stream()
                            .map(this::mapToFeedbackDto)
                            .collect(Collectors.toList());
                    if (!feedbackList.isEmpty()) {
                        totalRating = feedbackList.stream()
                                .mapToDouble(FeedbackDto::getRate)
                                .average()
                                .orElse(0); // Nếu danh sách trống, trả về 0
                    }
                    doctorDto.setFeedbackDtoList(feedbackList);
                    doctorDto.setRate(totalRating);

                    return doctorDto;
                })
                .collect(Collectors.toList());

        // Sắp xếp danh sách theo rate giảm dần
        doctorDtos.sort(Comparator.comparingDouble(DoctorDto::getRate).reversed());
        return doctorDtos;
    }

    // writed by An in 5/11
    @Override
    public boolean changeStatus(int id, int status) {
        Doctor d = doctorRepository.findById(id).get();
        boolean newStatus = (status == 1) ? false : true;
        d.setStatus(newStatus);
        try {
            doctorRepository.save(d);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public DoctorDto updatePriceAndDepartment(int id, double price, int departmentId) {
        Doctor d = doctorRepository.findById(id).get();
        d.setPrice(price);
        d.setDepartment(null);

        if(departmentId > 0){
            Optional<Department> department = departmentRepository.findById(departmentId);
            department.ifPresent(de -> d.setDepartment(department.get())); 
        }
        doctorRepository.save(d);
        return mapToDoctorDto(d);
    }



}
