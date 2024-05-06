import React, { useEffect, useState } from 'react'
import { useParams } from 'react-router-dom';
import { findNewsById } from '../../../../services/API/news';

function DetailNews() {

  // lấy id từ url
  const { id } = useParams();

  // gọi hàm loadNews 1 lần
  useEffect(() => {
    loadNews();
  }, []);

  // xét giá trị cho news
  const loadNews = async () => {
    setNews(await findNewsById(id));

  };

  // khởi tạo đối tượng news
  const [news, setNews] = useState({
    title: '',
    content: '',
    url: '',
    image: '',
    status: '',
    creator_email: ''
  });
  return (
    <>
      <h2>Detail News</h2>
      <div style={{width:'75%',margin:'auto'}}>
        <h1 style={{ textAlign: 'center', marginTop: '50px' }}>{news.title}</h1>
        <img src={"http://localhost:8080/images/news/" + news.image} alt="" width='100%' />
        <p>{news.content}</p>
      </div>

    </>
  )
}

export default DetailNews