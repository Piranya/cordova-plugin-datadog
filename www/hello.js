module.exports = {
    sayHello: function (inputParams, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "Hello", "sayHello", [inputParams]);
    }
};
