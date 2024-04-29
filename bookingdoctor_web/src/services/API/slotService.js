import * as request from "../../ultils/request";

export const getAllSlot = async () => {
    try {
        const response = await request.get('slot/all');
        return response
    } catch (error) {
        console.log(error);
        throw error;
    }
};

export const deleteSlot = async (id) => {
    try {
        await request.remove(`slot/delete/${id}`);
    } catch (error) {
        console.log(error);
        throw error;
    }
};

