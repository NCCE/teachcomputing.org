module.exports = {
  ci: {
    collect: {
      url: ['http://localhost:3000/'],
      startServerCommand: 'bundle exec rails server -e production',
      settings: {skipAudits: ['cumulative-layout-shift']},
    },
    upload: {
      target: 'temporary-public-storage',
    },
  },
};
