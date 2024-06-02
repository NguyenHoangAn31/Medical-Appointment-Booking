import * as request from "../../ultils/request";


export const getAllAppointment = async () => {
    try {
        const response = await request.get(`appointment/all`);
        return response;
    } catch (error) {
        console.log(error);
        throw error;
    }
}