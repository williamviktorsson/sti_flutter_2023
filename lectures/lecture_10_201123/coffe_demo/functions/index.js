
// call initializeApp before accessing firebase API:s
const { initializeApp } = require("firebase-admin/app");

// get references to firestore / messaging API:s
const { getFirestore } = require("firebase-admin/firestore");
const { getMessaging } = require("firebase-admin/messaging");

// trigger for document changes
const { onDocumentWritten } = require("firebase-functions/v2/firestore");

initializeApp()

const db = getFirestore()
const messaging = getMessaging()

const OrderStatus = {
    queue: 0,
    progress: 1,
    completed: 2,
};

exports.handleOrder = onDocumentWritten({
    document: 'orders/{orderId}',
    region: 'europe-west1'
}, async (event) => {


    // find how many orders are in progress.
    // if < 4 , go to progress.

    const result = await db.collection("orders").get();
    const orders_as_json = result.docs.map((e) => {
        return { ...e.data(), id: e.id }
    })

    // {status: 0, userId: "foobar"} <- .data()
    // {status: 0, userId: "foobar", id: "123"}

    const progress_orders = orders_as_json.filter((e) => e.status == OrderStatus.progress);

    if (progress_orders.length >= 4) {
        // we are occupied, we will not put any others to progress
        return;
    }

    // Its okay to start brewing another coffe.
    // select the longest waiting order
    // start brewing

    const queued_orders = orders_as_json.filter((e) => e.status == OrderStatus.queue);

    if (queued_orders.length > 0) {

        queued_orders.sort((a, b) => {
            return new Date(a.placedAt).getTime() - new Date(b.placedAt).getTime()
        })

        const order = queued_orders[0]
        order.status = OrderStatus.progress;

        // THIS CALL TRIGGERS onDocumentWritten
        await db.collection("orders").doc(order.id).set(order)

        // let brewing take 5-15 seconds
        const sleepTime = Math.floor(Math.random() * 10000) + 5000;
        await new Promise((resolve) => setTimeout(resolve, sleepTime));

        order.status = OrderStatus.completed;

        // THIS CALL TRIGGERS onDocumentWritten
        await db.collection("orders").doc(order.id).set(order)

        if (order.fcmToken) {

            messaging.send({
                notification: {
                    title: "Order complete",
                    body: "Please pick up your coffe!"
                },
                token: order.fcmToken
            })
        }

    }





});