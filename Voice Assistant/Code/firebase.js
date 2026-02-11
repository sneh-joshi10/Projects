// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyCAxC-m052yO9etxcqk1HUDjQyRyxuKSEw",
  authDomain: "voice-assistant-signup.firebaseapp.com",
  projectId: "voice-assistant-signup",
  storageBucket: "voice-assistant-signup.appspot.com",
  messagingSenderId: "800497608084",
  appId: "1:800497608084:web:0c454d564cd19e0b7adb81",
  measurementId: "G-WWQCNZTQ5W"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);