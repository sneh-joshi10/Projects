import React from 'react';
import { BrowserRouter as Router, Routes, Route, Link } from 'react-router-dom';
import './App.css'; // Import your CSS file for styling
import logo from './Delphi.png';
import Login from './Login';
import Signup from './Signup';

// Header Component
const Header = () => {
  return (
    <header className="header">
      <div className="logo">
        <img src={logo} alt="Logo" className='logo img'/>
      </div>
      <nav className="navigation">
        <ul>
          <li><Link to="/">Home</Link></li>
          <li><Link to="/tutorial">Tutorial</Link></li>
          <li><Link to="/assistant">Your Voice Assistant</Link></li>
          <li><Link to="/animation">Animation</Link></li>
          <li><Link to="/login">Login</Link></li>
          <li><Link to="/signup">Sign Up</Link></li>
        </ul>
      </nav>
    </header>
  );
};
const Footer = () => {
  return (
    <footer className="footer">
      <ul>
        <li><Link to="/know-more">Know More</Link></li>
        <li><Link to="/contact-us">Contact us</Link></li>
      </ul>
    </footer>
  );
};


// Main Content Component
const MainContent = () => {
  return (
    <div className="main-content">
      <h1>Welcome to Delphi</h1>
      <p>Delphi is your personal voice assistant for all your needs.</p>
      <Link to="/get-started" className="get-started-button">Let's Get Started</Link>
    </div>
  );
};

// App Component
const App = () => {
  return (
    <Router>
      <div className="app">
        <Routes>
        <Route exact path="/" element={
          <div>
            <Header />
            <MainContent />
            <Footer />
          </div> 
        } />
          <Route path="/login" element={<Login />} />
          <Route path="/signup" element={<Signup />} />
        </Routes>
      </div>
    </Router>
  );
};

export default App;
