package vn.aptech.backendapi.service.Feedback;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.swing.text.html.Option;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import vn.aptech.backendapi.dto.Feedback.FeedbackDetail;
import vn.aptech.backendapi.dto.Feedback.FeedbackDto;
import vn.aptech.backendapi.dto.Feedback.FeedbackShowDto;
import vn.aptech.backendapi.entities.Doctor;
import vn.aptech.backendapi.entities.Feedback;
import vn.aptech.backendapi.entities.Partient;
import vn.aptech.backendapi.repository.DoctorRepository;
import vn.aptech.backendapi.repository.FeedbackRepository;
import vn.aptech.backendapi.repository.PartientRepository;
import vn.aptech.backendapi.service.Doctor.DoctorService;
import vn.aptech.backendapi.service.Patient.PatientService;

@Service
public class FeedbackServiceImpl implements FeedbackService {
    @Autowired
    private ModelMapper mapper;

    @Autowired
    private FeedbackRepository feedbackRepository;
    @Autowired
    private DoctorRepository doctorRepository;
    @Autowired
    private PartientRepository partientRepository;
    @Autowired
    private PatientService patientService;
    @Autowired
    private DoctorService doctorService;

    private FeedbackShowDto toShowDto(Doctor d) {
        FeedbackShowDto feedback = mapper.map(d, FeedbackShowDto.class);
        feedback.setDepartment(d.getDepartment().getName());
        feedback.setRate(feedbackRepository.averageRateByDoctorId(d.getId()));
        return feedback;
    }

    private FeedbackDto toCreateDto(Feedback f) {
        FeedbackDto feedback = mapper.map(f, FeedbackDto.class);
        feedback.setDoctorId(f.getDoctor().getId());
        feedback.setPatientId(f.getPartient().getId());
        return feedback;
    }

    private FeedbackDto toFeedbackDto(Feedback f) {
        FeedbackDto feedback = mapper.map(f, FeedbackDto.class);
        feedback.setPatientId(f.getPartient().getId());
        feedback.setDoctorId(f.getDoctor().getId());
        feedback.setPatient(patientService.getPatientByPatientId(f.getPartient().getId()).get());

        return feedback;
    }

    @Override
    public List<FeedbackShowDto> findAll() {
        List<Doctor> doctor = doctorRepository.findAll();
        return doctor.stream().map(this::toShowDto)
                .collect(Collectors.toList());
    }

    public List<FeedbackDto> findList(int doctorId) {
        List<Feedback> result = feedbackRepository.findListByDoctorId(doctorId);
        return result.stream().map(this::toFeedbackDto).collect(Collectors.toList());
    }

    @Override
    public FeedbackDetail feedbackDetail(int doctorId) {
        FeedbackDetail f = new FeedbackDetail();
        f.setDoctor(doctorService.findById((doctorId)).get());
        f.setFeedbackList(findList(doctorId));
        return f;
    }

    @Override
    public boolean deleteById(int id) {
        try {
            feedbackRepository.deleteById(id);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean changeStatus(int id, int status) {
        Feedback f = feedbackRepository.findById(id).get();
        boolean newStatus = (status == 1) ? false : true;
        f.setStatus(newStatus);
        try {
            feedbackRepository.save(f);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public FeedbackDto save(FeedbackDto dto) {
        Feedback f = mapper.map(dto, Feedback.class);
        if (dto.getDoctorId() > 0) {
            Optional<Doctor> d = doctorRepository.findById(dto.getDoctorId());
            d.ifPresent(doctor -> f.setDoctor(mapper.map(d, Doctor.class)));
        }
        if (dto.getPatientId() > 0) {
            Optional<Partient> p = partientRepository.findById(dto.getPatientId());
            p.ifPresent(partient -> f.setPartient(mapper.map(p, Partient.class)));
        }
        Feedback result = feedbackRepository.save(f);
        return toCreateDto(result);
    }

}
