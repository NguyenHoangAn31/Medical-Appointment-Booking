import * as request from "../../ultils/request";

export const getAllDepartment = async () => {
    try {
        const response = await request.get('department/all');
        return response
    } catch (error) {
        console.log(error);
        throw error;
    }
};

export const deleteDepartment = async (id) => {
    try {
        await request.remove(`department/delete/${id}`);
    } catch (error) {
        console.log(error);
        throw error;
    }
};
export const findDepartmentById = async (id) => {
    try {
        const response = await request.get(`department/${id}`);
        return response;
    } catch (error) {
        console.log(error);
        throw error;
    }
}
export const addDepartment = async (slot) => {
    try {
        await request.post(`department/create`,slot);
    } catch (error) {
        console.log(error);
        throw error;
    }
};
export const updateDepartment = async (id,slot) => {
    try {
        await request.put(`department/update/${id}`,slot);
    } catch (error) {
        console.log(error);
        throw error;
    }
};

