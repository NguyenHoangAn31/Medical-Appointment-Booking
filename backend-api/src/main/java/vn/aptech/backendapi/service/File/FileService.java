package vn.aptech.backendapi.service.File;

import java.nio.file.Paths;
import java.util.UUID;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

import org.apache.commons.io.FilenameUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileService {
    private final String UPLOAD_DIR = Paths.get("src/main/resources/static/images/").toString();

    public String uploadFile(String folderName , MultipartFile file) throws IOException {
        Path uploadPath = Paths.get(UPLOAD_DIR).resolve(folderName);

        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        byte[] bytes = file.getBytes();
        String fileExtension = FilenameUtils.getExtension(file.getOriginalFilename());
        String uuidFileName = UUID.randomUUID().toString() + "." + fileExtension;
        Path path = Paths.get(uploadPath.toString()).resolve(uuidFileName);
        Files.write(path, bytes);
        return uuidFileName;

    }

    public boolean deleteFile(String folderName, String fileName) {
        Path deletePath = Paths.get(UPLOAD_DIR).resolve(folderName).resolve(fileName);
        try {
            Files.delete(deletePath);
            return true;

        } catch (Exception e) {
            return false;
        }

    }
}