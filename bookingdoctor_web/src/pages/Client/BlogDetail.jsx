import React, { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import axios from 'axios';

const BlogDetail = () => {
  const { id } = useParams();
  const [newsItem, setNewsItem] = useState(null);

  useEffect(() => {
    fetchNewsItem();
  }, [id]);

  const fetchNewsItem = async () => {
    try {
      const response = await axios.get(`http://localhost:8080/api/news/${id}`);
      setNewsItem(response.data);
    } catch (error) {
      console.error('Error fetching the news item:', error);
    }
  };

  if (!newsItem) {
    return <div>Loading...</div>;
  }

  // Define styles directly in the component
  const imageStyle = {
    maxWidth: '540px',
    maxHeight: '780px',
    width: '100%',
    height: 'auto',
    objectFit: 'cover',
    display: 'block',
    margin: '0 auto'  // Center the image
  };

  return (
    <div className="container mt-5">
      <div className="row">
        <div className="col-md-12">
          <h1 className="mb-4"><strong>{newsItem.title}</strong></h1>
          <img 
            src={`http://localhost:8080/images/news/${newsItem.image}`} 
            style={imageStyle} 
            className="img-fluid mb-4" 
            alt={newsItem.title} 
          />
          <div dangerouslySetInnerHTML={{ __html: newsItem.content }}></div>
          <p className="mt-4"><strong>By:</strong> {newsItem.creator_email}</p>
        </div>
      </div>
    </div>
  );
};

export default BlogDetail;
