
import * as encrypt from '../../../ultils/encrypt';

    

    let getUserData = null;
    const TokenReult = sessionStorage.getItem("Token");
    
    //console.log(JSON.parse(encrypt.decryptToken(TokenReult)))
    if(TokenReult != null && TokenReult != ''){
        const result = JSON.parse(encrypt.decryptToken(TokenReult));
        const isTokenExpired = () => {
            const currentDate = new Date(); // Lấy ngày giờ hiện tại
            const expiredAt = new Date(result.expiredAt); // Chuyển mảng expiredAt thành đối tượng Date
            // So sánh ngày giờ hiện tại với expiredAt
            return currentDate.getTime() > expiredAt.getTime();
          };
          if(isTokenExpired()){
            getUserData = null;
            sessionStorage.setItem("Token",  '');
          }else{
            getUserData = result;
          } 
    }

export default getUserData;