import * as request from "../../ultils/request";

export const findUserById = async (id) => {
    try {
        const response = await request.get(`user/${id}`);
        return response;
    } catch (error) {
        console.log(error);
        throw error;
    }
}
export const updateUser = async (id,user) => {
    try {
        const response = await request.put(`user/update/${id}`,user);
        return response;
    } catch (error) {
        console.log(error);
        throw error;
    }
}