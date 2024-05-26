import * as request from "../../ultils/request";

export const findAllWorkDay = async () => {
    try {
        const response = await request.get(`clinic/allday`);
        return response;
    } catch (error) {
        console.log(error);
        throw error;
    }
}

export const findScheduleByDay = async (date) => {
    try {
        const response = await request.get(`clinic/work_day/${date}`);
        return response;
    } catch (error) {
        console.log(error);
        throw error;
    }
}

export const updateSchedule = async (doctoId,scheduleId) => {
    try {
        await request.put(`clinic/updateschedule/${scheduleId}/${doctoId}`);
    } catch (error) {
        console.log(error);
        throw error;
    }
};