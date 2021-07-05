module.exports = {
  ci: {
    collect: {
      url: ['http://localhost:3000/'],
      startServerCommand: 'bundle exec rails server -e production',
    },
    upload: {
      target: 'temporary-public-storage',
    },
    settings: {
      skipAudits: [
        'cumulative-layout-shift'
      ]
    }
  },
};
