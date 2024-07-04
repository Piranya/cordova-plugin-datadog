var exec = require('cordova/exec');


exports.InitTrack = function (success, error,clientToken,environment,appID,trackingConsentInt,serviceName,sessionId,userName,sessionReplayRate) {
    exec(success, error, 'Datadog', 'InitTrack', [clientToken,environment,appID,trackingConsentInt,serviceName,sessionId,userName,sessionReplayRate]);
};


exports.logger = function (success, error,type,message) {
    exec(success, error, 'Datadog', 'loggerMessage', [type,message]);
};

// exports.setSessionId = function (success, error, sessionId) {
//     exec(success, error, 'Datadog', 'setSessionId',[sessionId]);
// };

// exports.setUserName = function (success, error,userName) {
//     exec(success, error, 'Datadog', 'setUserName',[userName]);
// };
