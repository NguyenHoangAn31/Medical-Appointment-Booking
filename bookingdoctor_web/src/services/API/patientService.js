import * as request from "../../ultils/request";

export const getPatientByUserId = async (userId) => {
    try {
        const res =  await request.get('patient/', {data: data});
        return res.data;

    } catch (error) {
    }
}

export default {getPatientByUserId}