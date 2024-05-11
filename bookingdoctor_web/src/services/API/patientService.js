import * as request from "../../ultils/request";

export const getPatientByUserId = async (userId) => {
    try {
        const res =  await request.get('patient/', {data: data});
        return res.data;

    } catch (error) {
    }
}

export default {getPatientByUserId}



//writed by An in 5/11
export const getAllPatient = async () => {
    try {
        const response = await request.get('patient/all');
        return response
    } catch (error) {
        console.log(error);
        throw error;
    }
};

export const detailPatient = async (id) => {
    try {
        const response = await request.get(`patient/${id}`);
        return response;
    } catch (error) {
        console.log(error);
        throw error;
    }
}