import React from 'react';
import { Link } from 'react-router-dom';

const SecondPage = () => {
  return (
    <div>
      <h1>Second Page</h1>
      <p>This is the second page of our application.</p>
      <Link to="/">Go Back to Homepage</Link>
    </div>
  );
};

export default SecondPage;
