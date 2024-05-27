import * as request from "../../ultils/request";


export const findAllWorkDay = async () => {
    try {
        const response = await request.get(`schedules/getdays`);
        return response;
    } catch (error) {
        console.log(error);
        throw error;
    }
}

export const findScheduleByDay = async (day) => {
    try {
        const response = await request.get(`schedules/findschedulebyday/${day}`);
        return response;
    } catch (error) {
        console.log(error);
        throw error;
    }
}

export const updateScheduleForAdmin = async (clinicId , departmentId , slotId , doctorList) => {
    console.log(doctorList)
    try {
        await request.put(`schedules/updatelistschedule/${clinicId}/${departmentId}/${slotId}`,doctorList);
    } catch (error) {
        console.log(error);
        throw error;
    }
};