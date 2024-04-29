const userData = {
  user: {
    id: 1,
    email: "docterlinktest12345@gmail.com",
    roles: ["ADMIN"],
  },
  accessToken:
    "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxIiwicm9sZXMiOiJET0NUT1IiLCJleHAiOjE3MTQ0MDMwMTZ9.F7kO37lB8kDDLVS4tJ4g3AolcrbNQYDpH7iVVWrrCP3obBGGeTpZ-cHIlyItEy_EXVsqah1wLSvRrJW235D4og",
  refreshToken: "84f9101f-cd4b-40d4-9ab2-c42a7092acb8",
  expiredAt: [
    2024,
    4,
    29,
    22,
    3,
    36,
    861256300],
};
//chú ý : token tự tạo và lưu vào session storage mục đích để test , sau này lấy token từ spring api và lưu và session storage
sessionStorage.setItem("Token", JSON.stringify(userData));
const getUserData = JSON.parse(sessionStorage.getItem("Token"));

export default getUserData;