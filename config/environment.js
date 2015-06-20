/* jshint node: true */

module.exports = function(environment) {
  var ENV = {
    modulePrefix: 'live',
    environment: environment,
    firebase: 'https://avalonstar.firebaseio.com/',
    baseURL: '/',
    locationType: 'auto',
    contentSecurityPolicy: {
      'connect-src': "'self' wss://*.firebaseio.com imraising.tv ",
      'font-src': "'self' data: cdn.symbolset.com ",
      'img-src': "'self' avalonstar-tv.s3.amazonaws.com static-cdn.jtvnw.net p.typekit.net ",
      'script-src': "'self' *.firebaseio.com ",
      'style-src': "'self' 'unsafe-inline' cdn.symbolset.com use.typekit.net cloud.typography.com "
    },
    EmberENV: {
      FEATURES: {
        // Here you can enable experimental features on an ember canary build
        // e.g. 'with-controller': true
      }
    },

    APP: {
      // Here you can pass flags/options to your application instance
      // when it is created
    }
  };

  if (environment === 'development') {
    // ENV.APP.LOG_RESOLVER = true;
    // ENV.APP.LOG_ACTIVE_GENERATION = true;
    // ENV.APP.LOG_TRANSITIONS = true;
    // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
    // ENV.APP.LOG_VIEW_LOOKUPS = true;

    ENV.contentSecurityPolicy['connect-src'] += "*.atv.dev ws://live.atv.dev:35729 localhost:5000 ws://localhost:5000";
    ENV.contentSecurityPolicy['script-src'] += "'unsafe-inline' 'unsafe-eval' live.atv.dev:35729 use.typekit.net";

    ENV.APP.SOCKET_HOST = 'ws://localhost:5000';
    ENV.APP.API_HOST = 'http://localhost:8000';
  }

  if (environment === 'test') {
    // Testem prefers this...
    ENV.baseURL = '/';
    ENV.locationType = 'none';

    // keep test console output quieter
    ENV.APP.LOG_ACTIVE_GENERATION = false;
    ENV.APP.LOG_VIEW_LOOKUPS = false;

    ENV.APP.rootElement = '#ember-testing';
  }

  if (environment === 'production') {
    ENV.contentSecurityPolicy['connect-src'] += "*.avalonstar.tv ws://socket.avalonstar.tv";
    ENV.contentSecurityPolicy['script-src'] += "use.typekit.net";

    ENV.APP.SOCKET_HOST = 'ws://socket.avalonstar.tv';
    ENV.APP.API_HOST = 'http://avalonstar.tv';
  }

  return ENV;
};
