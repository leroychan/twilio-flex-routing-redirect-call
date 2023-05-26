exports.handler = async function (context, event, callback) {
  try {
    const VoiceResponse = require("twilio").twiml.VoiceResponse;
    const response = new VoiceResponse();
    response.dial(context.FORWARD_TO_NUMBER);
    return callback(null, response);
  } catch (err) {
    console.log(err);
    return callback("Unexpected Error: Please check logs");
  }
};
