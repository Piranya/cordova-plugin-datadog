module.exports = {
    sayHello: function (accept, successCallback, failureCallback) {
        var result = new Promise(function (resolve, reject) {
            cordova.exec(
                function (json) {
                    if (json === 'RESULT_CANCELED') {
                        resolve();
                        return;
                    }

                    try {
                        var o = JSON.parse(json);
                        resolve(o);
                    }
                    catch (err) {
                        reject(err);
                    }
                },
                reject,
                'Hello',
                'sayHello',
                [(typeof accept === 'string' ? accept.replace(/\s/g, '') : undefined) || '*/*']
            );
        });

        if (typeof successCallback === 'function') {
            result.then(successCallback);
        }
        if (typeof failureCallback === 'function') {
            result.catch(failureCallback);
        }

        return result;
    }
};
