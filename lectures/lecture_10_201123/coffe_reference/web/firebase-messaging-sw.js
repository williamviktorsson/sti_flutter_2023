importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/9.10.0/firebase-messaging-compat.js");

firebase.initializeApp({
    apiKey: "AIzaSyDqPmPNL74h-tTp-J2HRhaFv6A2AyB8EG4",

    authDomain: "coffe-reference.firebaseapp.com",

    projectId: "coffe-reference",

    storageBucket: "coffe-reference.appspot.com",

    messagingSenderId: "149482148378",

    appId: "1:149482148378:web:a7674dd026e14b8a35b7a3"

});
// Necessary to receive background messages:
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
    console.log("onBackgroundMessage", m);
});

messaging.onMessage((m) => {
    console.log(m)
});
