module.exports = {
  ci: {
    collect: {
      url: ['http://localhost:3000/', 'http://localhost:3000/primary-teachers', 'http://localhost:3000/secondary-teachers'],
      startServerCommand: 'bin/rails server',
      numberOfRuns: 1,
      settings: {
        onlyCategories: ['accessibility', 'best-practices', 'seo'],
        skipAudits: ['cumulative-layout-shift'],
        maxWaitForLoad: 90000,
        verbose: true,
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
