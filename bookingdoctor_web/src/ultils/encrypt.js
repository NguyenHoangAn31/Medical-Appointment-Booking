import CryptoJS from 'crypto-js';


// Hàm để mã hóa token trước khi lưu vào sessionStorage
function encryptToken(token) {
    return CryptoJS.AES.encrypt(token, 'your-secret-key').toString();
  }
  
  // Hàm để giải mã token từ sessionStorage
  export const decryptToken = (encryptedToken) => {
    const bytes = CryptoJS.AES.decrypt(encryptedToken, 'your-secret-key');
    return bytes.toString(CryptoJS.enc.Utf8);
  }