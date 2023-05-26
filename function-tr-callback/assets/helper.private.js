// Load Libraries
const request = require("request-promise-native");
const twilio = require("twilio");

const validateTwilioSignature = (client, context, signature, payload) => {
  try {
    const url = `https://${context.DOMAIN_NAME}${context.PATH}`;
    return twilio.validateRequest(context.AUTH_TOKEN, signature, url, payload);
  } catch (err) {
    console.log(err);
    return false;
  }
};

const processCallForwarding = async (client, context, callSid) => {
  try {
    const twilMLURL = `https://${context.DOMAIN_NAME}/twiml-redirect-call`;
    console.log(twilMLURL);
    console.log(`Call SID: ${callSid}`);
    const forwardCallStatus = await client
      .calls(callSid)
      .update({ method: "GET", url: twilMLURL });
    console.log(forwardCallStatus);
  } catch (err) {
    console.log(err);
    return false;
  }
};
module.exports = { validateTwilioSignature, processCallForwarding };
