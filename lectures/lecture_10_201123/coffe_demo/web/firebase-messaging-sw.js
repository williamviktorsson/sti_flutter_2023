importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({

    apiKey: "AIzaSyCXHH75dkMWFY4bXXMFJ1W-gsgX7ml18No",

    authDomain: "coffe-demo-aec39.firebaseapp.com",
  
    projectId: "coffe-demo-aec39",
  
    storageBucket: "coffe-demo-aec39.appspot.com",
  
    messagingSenderId: "888798613444",
  
    appId: "1:888798613444:web:1e11b22c5872d5178d5e91"

});

const messaging = firebase.messaging();
