module.exports = {
  ci: {
    collect: {
      url: ['http://localhost:3000/', 'http://localhost:3000/primary-teachers', 'http://localhost:3000/secondary-teachers'],
      startServerReadyTimeout: 60000,
      startServerCommand: 'bundle exec rails server',
      settings: {
        onlyCategories: ['performance', 'accessibility', 'best-practices', 'seo'],
        skipAudits: ['cumulative-layout-shift'],

      },
    },
    // If we want to start failing the test suite on lighthouse failures we add
    // the assertions
    // assert: {
      // preset: 'lighthouse:no-pwa'
    // },
    upload: {
      target: 'temporary-public-storage',
    },
  },
};
