Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile +=
  %w[admin.css staff.css customer.css admin.js staff.js customer.js]
Rails.application.config.assets.paths << Rails.root.join('node_modules')
