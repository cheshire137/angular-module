module.exports = function (karma) {
    config = require(__dirname + "/shared.conf.js").shared;

    config.frameworks = config.frameworks.concat([
        'ng-scenario'
    ]);

    config.plugins = config.plugins.concat([
        'karma-ng-scenario'
    ]);

    // level of logging
    // possible values: karma.LOG_DISABLE || karma.LOG_ERROR || karma.LOG_WARN || karma.LOG_INFO || karma.LOG_DEBUG
//    logLevel: karma.LOG_INFO,

    config.files = config.files.concat([
        'spec/javascripts/e2e/**/*_spec.coffee'
    ]);

    config.urlRoot = '/__e2e/';

    config.proxies = {
        '/': 'http://localhost:3000/'
    };

    karma.configure(config)
};

