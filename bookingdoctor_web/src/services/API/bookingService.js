import * as request from "../../ultils/request";


export const addAppointment = async (appointment) => {
    console.log(appointment)
    try {
        await request.post(`appointment/create`,appointment);
    } catch (error) {
        console.log(error);
        throw error;
    }
};