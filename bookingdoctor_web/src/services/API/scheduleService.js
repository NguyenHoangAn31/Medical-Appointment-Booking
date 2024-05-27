import * as request from "../../ultils/request";

export const updateScheduleForAdmin = async (clinicId , departmentId , slotId , doctorList) => {
    console.log(doctorList)
    try {
        await request.put(`schedules/updatelistschedule/${clinicId}/${departmentId}/${slotId}`,doctorList);
    } catch (error) {
        console.log(error);
        throw error;
    }
};