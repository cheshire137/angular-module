var shared = {
    // base path, that will be used to resolve files and exclude
    basePath: '../../..',


    // frameworks to use
    frameworks: [],

    // list of files / patterns to load in the browser
    files: [
        { pattern: 'app/assets/javascripts/**/*.js',
            watched: true,
            included: false,
            served: false },
        { pattern: 'app/assets/javascripts/**/*.coffee',
            watched: true,
            included: false,
            served: false },
        { pattern: 'app/assets/javascripts/application*.js.erb',
            watched: true,
            included: false,
            served: false }
    ],

    // list of files to exclude
    exclude: [

    ],


    // test results reporter to use
    // possible values: 'dots', 'progress', 'junit', 'growl', 'coverage'
    reporters: ['progress'],


    // web server port
    port: 9876,


    // cli runner port
    runnerPort: 9100,


    // enable / disable colors in the output (reporters and logs)
    colors: true,

    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: true,


    // Start these browsers, currently available:
    // - Chrome
    // - ChromeCanary
    // - Firefox
    // - Opera
    // - Safari (only Mac)
    // - PhantomJS
    // - IE (only Windows)
    browsers: ['Chrome', 'ChromeCanary'/*, 'FirefoxNightly'*/],
//    browsers: ['chrome_without_security'],
//
//    customLaunchers: {
//        chrome_without_security: {
//            base: 'Chrome',
//            flags: ['--web-security-disabled']
//        }
//    },


    // If browser does not capture in given timeout [ms], kill it
    captureTimeout: 60000,


    // Continuous Integration mode
    // if true, it capture browsers, run tests and exit
    singleRun: false,


    preprocessors: {
        '**/*.coffee': 'coffee'
    },

    plugins: [
        'karma-coffee-preprocessor',
        'karma-chrome-launcher',
        'karma-firefox-launcher'
    ]

};

exports.shared = shared;
