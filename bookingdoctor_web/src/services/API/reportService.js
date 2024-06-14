import * as request from "../../ultils/request";

export const getAllReport = async () => {
    try {
        const response = await request.get(`report/today`);
        return response;
    } catch (error) {
        console.log(error);
        throw error;
    }
}
export const getAllReportByDay = async (startDate,endDate) => {
    try {
        const response = await request.get(`report/findbyday/${startDate}/${endDate}`);
        return response;
    } catch (error) {
        console.log(error);
        throw error;
    }
}