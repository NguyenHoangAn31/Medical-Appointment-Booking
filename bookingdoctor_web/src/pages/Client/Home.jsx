import React, {useEffect} from 'react'

import { SeachHome, ImageHome, HomeService, HomeAbout } from '../../components/UI/Home'
import { useNavigate } from "react-router-dom"

import getUserData from '../../route/CheckRouters/token/Token'

const Home = () => {
    const navigateTo = useNavigate();
     useEffect(() =>{
      if(getUserData != null){
          var role = getUserData.user.roles[0];
          if(role == 'ADMIN'){
            navigateTo(`/dashboard/admin`);
          }else if(role == 'DOCTOR'){
            navigateTo(`/dashboard/doctor`);
          }else{
            navigateTo(`/`);
          }
       }else{
         localStorage.setItem('currentPath', '');
         navigateTo(`/`); 
       }
     }, []);
    
  return (
    <>
      <SeachHome />
      <ImageHome />
      <HomeService />
      <HomeAbout />
    </>
  )
}

export default Home