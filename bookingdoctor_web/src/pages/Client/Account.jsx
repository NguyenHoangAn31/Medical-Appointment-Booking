import { Content } from 'antd/es/layout/layout'
import React, { useContext, useEffect } from 'react'
import { UserContext } from '../../components/Layouts/Client';
import { useNavigate } from 'react-router-dom';

const Account = () => {
  const { currentUser } = useContext(UserContext);
  const navigate = useNavigate();

  useEffect(() => {
    if (!currentUser) {
      navigate('/login');
    }
  }, [currentUser, navigate]);


  return (
    <h1>Account</h1>
  )
}

export default Account;
