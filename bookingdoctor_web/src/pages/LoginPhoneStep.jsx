
import React, { useState, useEffect } from 'react'
import axios from 'axios';
import bg_login from '../../public/images/image-login.png';
import { motion } from 'framer-motion';
import {Link, useNavigate} from 'react-router-dom';
import queryString from 'query-string';
const LoginPhoneStep = () => {
    const [username, setUsername] = useState('');
    const [keycode, setKeycode] = useState('');
    const navigateTo = useNavigate();
    useEffect(() => {
        const queryParams = queryString.parse(window.location.search);
        setUsername(queryParams.username);
        // Bây giờ bạn có thể làm gì đó với giá trị của username
      }, []);
    
    const handleSubmit = async (e) =>{
        e.preventDefault();
        const data = {
            username: username,
            keycode: keycode,
            provider: ''
        }
        console.log(data);
        try {

            const result =  await axios.post('http://localhost:8080/api/auth/login', data);
               
                console.log(result.data);

                if (result && result.data) {
                    // Lưu kết quả vào localStorage
                    sessionStorage.setItem('Token', JSON.stringify(result.data));
                    navigateTo(`/`);
                }

        } catch (error) {
            console.error('Error sending OTP: ', error)
        }
    }
    
  return (
    <>
            <div className='container mt-5'>
                <div className="row">
                    <div className="col-md-6">
                        <div className="col-12">
                            <img src={bg_login} alt="" className='img-fluid' />
                        </div>
                    </div>
                    <div className="col-md-1"></div>
                    <div className='col-md-5'>
                        <div className="col-12">
                            <div className="text-center justify-content-center px-5 mt-xxl-5">
                                <h3 className='login__title'>Login</h3>
                                <h5 className='login__title_sup'>Booking appointment</h5>
                                <div className='py-5 border-top border-dark border-2 mt-3'>
                                    {/* <h5 className='mb-2 text-black-50'>Step 2: Xác thực sms đã send qua điện thoại</h5> */}
                                    <form onClick={handleSubmit}>
                                        <input type="hidden" name="provider" value="phone" />
                                        <div className="mb-3">
                                            <input type="text" className="input__username"
                                             id="input__phone"
                                             placeholder="Enter keycode"
                                             value={keycode}
                                             onChange={(e) => setKeycode(e.target.value)}
                                             />
                                        </div>
                                        <div className="mb-4">
                                            <motion.div whileTap={{ scale: 0.8 }}>
                                                <button type='submit' className='btn__submit'>Submit</button>
                                            </motion.div>
                                        </div>
                                    </form>
                                </div>

                                <div className='mt-xl-5'>
                                    <p>Quay về trang login. <Link to="/login" className='text-decoration-none ms-2'>Back to login</Link></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </>
  )
}

export default LoginPhoneStep