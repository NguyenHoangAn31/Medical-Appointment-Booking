package vn.aptech.backendapi.service.Patient;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import vn.aptech.backendapi.dto.MedicalDto;
import vn.aptech.backendapi.dto.PatientDto;

import vn.aptech.backendapi.entities.Medical;
import vn.aptech.backendapi.entities.Partient;
import vn.aptech.backendapi.repository.MedicalRepository;
import vn.aptech.backendapi.repository.PartientRepository;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class PatientServiceImpl implements PatientService {
    // writed by An in 5/6
    @Autowired
    private MedicalRepository medicalRepository;
    // end
    @Autowired
    private PartientRepository partientRepository;
    @Autowired
    private ModelMapper mapper;

    public PatientDto toDto(Partient p) {
        return mapper.map(p, PatientDto.class);
    }

    private PatientDto mapToPatientDto(Partient partient) {
        PatientDto patientDto = new PatientDto();
        patientDto.setId(partient.getId());
        patientDto.setFullName(partient.getFullName());
        patientDto.setGender(partient.getGender());
        patientDto.setBirthday(partient.getBirthday().toString());
        patientDto.setAddress(partient.getAddress());
        patientDto.setImage(partient.getImage());
        // patientDto.setMedicals(partient.getMedicals());
        // Không gán WorkingDto ở đây vì sẽ gán sau trong findById
        return patientDto;
    }

    private MedicalDto mapToMedicalDto(Medical m) {
        MedicalDto medicalDto = new MedicalDto();
        medicalDto.setId(m.getId());
        medicalDto.setName(m.getName());
        medicalDto.setContent(m.getContent());
        medicalDto.setPatientId(m.getId());
        return medicalDto;
    }

    public Optional<PatientDto> getPatientByUserId(int userId) {
        Partient patient = partientRepository.getPatientByUserId(userId);
        if (patient != null) {
            List<MedicalDto> medicalList = patient.getMedicals().stream()
                    .map(this::mapToMedicalDto)
                    .collect(Collectors.toList());
            PatientDto patientDto = mapToPatientDto(patient);
            patientDto.setMedicals(medicalList);
            return Optional.of(patientDto);
        } else {
            return Optional.empty();
        }
    }

    // writed by An in 5/6
    private MedicalDto toMedicalDto(Medical m) {
        MedicalDto dto = mapper.map(m, MedicalDto.class);
        return dto;
    }

    private PatientDto toPatientDto(Partient p) {
        PatientDto dto = mapper.map(p, PatientDto.class);
        dto.setMedicals(medicalRepository.findByPartientId(p.getId()).stream().map(this::toMedicalDto)
                .collect(Collectors.toList()));
        return dto;
    }

    @Override
    public Optional<PatientDto> getPatientByPatientId(int patientId) {
        Optional<Partient> result = partientRepository.findById(patientId);
        return result.map(this::toPatientDto);
    }

    // writed by An in 5/11
    @Override
    public List<PatientDto> getAll() {
        List<Partient> p = partientRepository.findAll();
        return p.stream().map(this::toDto)
                .collect(Collectors.toList());
    }
    

}
