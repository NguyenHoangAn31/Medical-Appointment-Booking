import * as request from "../../ultils/request";

export const getAllDepartment = async () => {
    try {
        const response = await request.get('department/all');
        return response;
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
export const addDepartment = async (department) => {
    try {
        await request.post(`department/create`,department);
    } catch (error) {
        console.log(error);
        throw error;
    }
};
export const updateDepartment = async (id,department) => {
    try {
        await request.put(`department/update/${id}`,department);
    } catch (error) {
        console.log(error);
        throw error;
    }
};

