import * as request from "../../ultils/request";

export const getAllFeedback = async () => {
    try {
        const response = await request.get('feedback/all');
        return response
    } catch (error) {
        console.log(error);
        throw error;
    }
};

export const detailFeedback = async (id) => {
    try {
        await request.remove(`feedback/${id}`);
    } catch (error) {
        console.log(error);
        throw error;
    }
};