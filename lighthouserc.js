module.exports = {
  ci: {
    collect: {
      url: ['http://localhost:3000/'],
      startServerCommand: 'bundle exec rails server -e production',
      settings: {
        onlyCategories: ['performance', 'accessibility', 'best-practices', 'seo'],
        skipAudits: ['cumulative-layout-shift'],

      },
    },
    // assert: {
      // preset: 'lighthouse:no-pwa'
    // },
    upload: {
      target: 'temporary-public-storage',
    },
  },
};
