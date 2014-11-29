Package.describe({
  name: 'oorabona:fview-boxlayout',
  summary: 'A BoxLayout plugin for Meteor Famous Views',
  version: '0.1.0',
  git: 'https://github.com/oorabona/fview-boxlayout.git'
});

Package.onUse(function(api) {
  api.versionsFrom('1.0');
  // Made with Coffee
  api.use('coffeescript@1.0.1', 'client');

  // Both famo.us packages generally used in the Meteor community are
  // included as weak references.
  api.use('mjn:famous@0.3.1_2', 'client', { weak: true });
  api.use('raix:famono@0.9.19', { weak: true });
  // famous-views is integrated a mandatory reference.
  api.use([
    'gadicohen:famous-views@0.1.27'
    ], 'client');
  api.addFiles([
    'fview-boxlayout.coffee'
    ], 'client');
});
