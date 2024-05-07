package vn.aptech.backendapi.service.Doctor;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.aptech.backendapi.dto.DoctorDto;
import vn.aptech.backendapi.dto.QualificationDto;
import vn.aptech.backendapi.dto.WorkingDto;
import vn.aptech.backendapi.entities.Doctor;
import vn.aptech.backendapi.entities.Qualification;
import vn.aptech.backendapi.entities.Working;
import vn.aptech.backendapi.repository.DoctorRepository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;


@Service
public class DoctorServiceImpl implements DoctorService{

    @Autowired
    private DoctorRepository doctorRepository;

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
        doctorDto.setPrice(doctor.getPrice());
        doctorDto.setDepartment(doctor.getDepartment().getName());
        // Không gán WorkingDto ở đây vì sẽ gán sau trong findById
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

    public List<DoctorDto> findAll(){
        return doctorRepository.findAll().stream().map(this::toDto).toList();
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

            DoctorDto doctorDto = mapToDoctorDto(doctor);
            doctorDto.setWorkings(workingList);
            doctorDto.setQualifications(qualificationList);

            return Optional.of(doctorDto);
        } else {
            return Optional.empty(); // Trả về Optional rỗng nếu không tìm thấy Doctor
        }
    }
    // Hien Create 30/4/2024
    @Override
    public List<DoctorDto> findRelatedDoctors(String departmentName) {
        // Truy vấn danh sách bác sĩ có cùng chuyên khoa
        List<Doctor> doctors = doctorRepository.findByDepartmentName(departmentName);

        // Chuyển đổi danh sách bác sĩ sang DoctorDto
        return doctors.stream()
                .map(doctor -> mapper.map(doctor, DoctorDto.class))
                .collect(Collectors.toList());
    }


}
