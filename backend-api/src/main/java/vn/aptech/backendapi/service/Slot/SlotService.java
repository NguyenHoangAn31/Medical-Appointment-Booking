package vn.aptech.backendapi.service.Slot;

import java.util.List;
import java.util.Optional;

import vn.aptech.backendapi.dto.SlotDto;

public interface SlotService {
    List<SlotDto> findAll();
    Optional<SlotDto> findById(int id);
    SlotDto save(SlotDto dto);
    boolean deleteById(int id);
}
