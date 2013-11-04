module.exports = function (karma) {
    var config = require(__dirname + "/shared.conf.js").shared;

    // level of logging
    // possible values: karma.LOG_DISABLE || karma.LOG_ERROR || karma.LOG_WARN || karma.LOG_INFO || karma.LOG_DEBUG
//    logLevel: karma.LOG_INFO,

    config.files = config.files.concat([
        'http://localhost:3000/assets/application.js',
        'spec/javascripts/angular/**/*.coffee',
        'spec/javascripts/unit/**/*_spec.coffee'
    ]);

    config.plugins = config.plugins.concat([
        'karma-jasmine'
    ]);

    config.frameworks = config.frameworks.concat([
        'jasmine'
    ]);

    karma.configure(config)
};

