import * as encrypt from '../../../ultils/encrypt';

const userData = {
  user: {
    id: 42,
    email: "admi01@gmail.com",
    roles: ["ADMIN"],
  },
  accessToken:
    "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwicm9sZXMiOiJVU0VSIiwiZXhwIjoxNzEzNjExNjkwfQ.pX0Pgsd--J7WmqHt8ZuVfZVx3XmdiVeYwxqeyaN4iQ7I6a-bjLjPsFKdzzggPfvAM66L2kR2XFjuRwQ-tEy_Zw",
  refreshToken: "33c8659f-9f28-4bac-96fc-9cf1d0295495",
  expiredAt: [2024, 4, 20, 18, 14, 50, 125040200],
};
sessionStorage.setItem("Token",encrypt.encryptToken(JSON.stringify(userData)));



let getUserData = null;
const TokenReult = sessionStorage.getItem("Token");

//console.log(JSON.parse(encrypt.decryptToken(TokenReult)))
if (TokenReult != null && TokenReult != '') {
  const result = JSON.parse(encrypt.decryptToken(TokenReult));
  const isTokenExpired = () => {
    const currentDate = new Date(); // Lấy ngày giờ hiện tại
    const expiredAt = new Date(result.expiredAt); // Chuyển mảng expiredAt thành đối tượng Date
    // So sánh ngày giờ hiện tại với expiredAt
    return currentDate.getTime() > expiredAt.getTime();
  };
  if (isTokenExpired()) {
    getUserData = null;
    sessionStorage.setItem("Token", '');
  } else {
    getUserData = result;
  }
  //getUserData = JSON.parse(encrypt.decryptToken(TokenReult));
}
export default getUserData;
