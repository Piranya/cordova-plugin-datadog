module.exports = {
    sayHello: function (name, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "Hello", "sayhello", [name]);
    }
};
