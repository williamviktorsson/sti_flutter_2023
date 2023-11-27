

const {initializeApp} = require("firebase-admin/app");
const {getFirestore} = require("firebase-admin/firestore");
const {onDocumentWritten} = require("firebase-functions/v2/firestore");
const {getMessaging} = require("firebase-admin/messaging");

initializeApp();

const db = getFirestore();
const messaging = getMessaging();

const OrderStatus = {
  queue: 0,
  progress: 1,
  completed: 2,
};


exports.brewCoffe = onDocumentWritten({
  document: "orders/{orderId}",
  region: "europe-west1",
}, async (event) => {
 
    

});


 // an order was created or an order finished brewing.
  // check if there's no order brewing, then start brewing the coffe
  // that's been waiting the longest.

  const orders = (await db.collection("orders").get())
      .docs.map((doc) => {
        return {...doc.data(), id: doc.id};
      });
  const brewingOrders = orders.filter((order) => {
    return order.status === OrderStatus.progress;
  });


  if (brewingOrders.length > 0) {
    return;
  } else {
    const queueOrders = orders.filter((order) => {
      return order.status === OrderStatus.queue;
    });
    queueOrders.sort((a, b) => {
      return new Date(a.placedAt).getTime() - new Date(b.placedAt).getTime();
    },
    );

    if (queueOrders.length > 0) {
      const order = queueOrders[0];
      order.status = OrderStatus.progress;
      await db.collection("orders").doc(order.id).set(order);

      try {
        if (order.fcmToken) {
          messaging.send({
            notification: {
              title: "Your coffee is brewing!",
              body: "Get ready to pick it up!",
            },
            token: order.fcmToken,
          });
        }

        // wait 5-15 seconds to simulate brewing
        const sleepTime = Math.floor(Math.random() * 10000) + 5000;
        await new Promise((resolve) => setTimeout(resolve, sleepTime));

        // update order to completed
        order.status = OrderStatus.completed;
        await db.collection("orders").doc(order.id).set(order);
        if (order.fcmToken) {
          messaging.send({
            notification: {
              title: "Your coffee is ready!",
              body: "Come pick it up!",
            },
            token: order.fcmToken,
          });
        }
      } catch (error) {
        // something went wrong, reset order to "in queue"
        order.status = OrderStatus.queue;
        await db.collection("orders").doc(order.id).set(order);
      }
    }
  }