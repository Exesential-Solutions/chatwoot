Rails.application.config.middleware.insert_before 0, Rack::SAMEORIGIN, ->(app) {
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, response = @app.call(env)
      headers['X-Frame-Options'] = 'ALLOW-FROM https://localhost:8084'
      [status, headers, response]
    end
  end
  Middleware
}