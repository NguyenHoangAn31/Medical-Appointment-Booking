package vn.aptech.backendapi.dto;

import jakarta.persistence.Column;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import vn.aptech.backendapi.entities.Doctor;
import vn.aptech.backendapi.entities.Slot;

import java.time.LocalDate;

public class ScheduleDto {
    private int id;
    private LocalDate dayWorking;
    private Slot slot;
    private Doctor doctor;
    private boolean status;
}
