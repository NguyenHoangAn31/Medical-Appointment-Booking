import * as request from "../../ultils/request";

export const getAllDoctor = async () => {
    try {
        const response = await request.get('doctor/all');
        return response
    } catch (error) {
        console.log(error);
        throw error;
    }
};



export const detailDoctor = async (id) => {
    try {
        const response = await request.get(`doctor/${id}`);
        return response;
    } catch (error) {
        console.log(error);
        throw error;
    }
}


