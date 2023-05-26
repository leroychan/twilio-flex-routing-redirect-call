exports.handler = async function (context, event, callback) {
  try {
    // Load Libraries
    const helper = require(Runtime.getAssets()["/helper.js"].path);
    const client = context.getTwilioClient();

    // Debug: Console Log Incoming Events
    console.log("---Start of Raw Event---");
    console.log(`Event Type: ${event.EventType}`);
    console.log(`Task SID: ${event.TaskSid}`);
    console.log(event.EventDescription);
    console.log("---End of Raw Event---");

    // Optional: Validate Twilio Signature (Use this only if you set your functions to be public)
    // const twilioSignature = event.request.headers["x-twilio-signature"];
    // const payload = event;
    // delete payload["request"];
    // const validSiganture = helper.validateTwilioSignature(
    //   client,
    //   context,
    //   twilioSignature,
    //   payload
    // );
    // if (!validSiganture) {
    //   console.log("Invalid Signature - No Actions Done");
    //   return callback(null);
    // }

    // Step 1: Check Incoming Event's Attributes
    const taskAttributes = JSON.parse(event.TaskAttributes);
    if (!event.TaskQueueSid || !taskAttributes || !taskAttributes.call_sid) {
      console.log(
        "Attributes Incomplete (TaskQueueSid or TaskAttributes.call_sid) - No Actions Done"
      );
      return callback(null);
    }

    // Step 2: Invole Logic Only For Specific Task Queue
    const forwardCallTaskQueueSid = context.FORWARD_CALL_TASK_QUEUE_SID;
    switch (event.TaskQueueSid) {
      case forwardCallTaskQueueSid:
        await helper.processCallForwarding(
          client,
          context,
          taskAttributes.call_sid
        );
        return callback(null);
      default:
        return callback(null);
    }
  } catch (err) {
    console.log(err);
    return callback("Unexpected Error: Please check logs");
  }
};
