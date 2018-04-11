let AWS = require('aws-sdk');
let lambda = new AWS.Lambda();

exports.handler = (event, context, callback) => {
    callback(null, {
        id: '1',
    });
};