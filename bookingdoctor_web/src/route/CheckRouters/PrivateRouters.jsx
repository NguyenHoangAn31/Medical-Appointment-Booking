import { Outlet, Navigate } from "react-router-dom";
import getUserData from "./token/Token";
const PrivateRouters = () => {
    if(!getUserData){
        return <Navigate to="/login" />
    }
    else if(["DOCTOR", "ADMIN"].some(role => getUserData.user.roles.includes(role))){
        return <Outlet />;
    }
    return (<div>Not Access</div>)

};
export default PrivateRouters;
