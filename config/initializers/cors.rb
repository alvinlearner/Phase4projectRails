Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'https://main--velvety-sawine-df90ba.netlify.app/' # Update this with the domains allowed to access your API
      resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head]
    end
  end
  