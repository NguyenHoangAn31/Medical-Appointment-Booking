import * as request from "../../ultils/request";

export const sendOtp = async (q, provider) =>{
    try {
        const res =  await request.post('auth/send-otp', {
            params: {
                q: q,
                provider: provider,
            },
        });

        return res.data;

    } catch (error) {
        console.log(error);
    }
}