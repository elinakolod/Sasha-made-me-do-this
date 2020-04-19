Rails.application.routes.draw do
  mount_graphql_devise_for 'User', at: 'auth'

  root to: "graphql#execute"

  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute"

  post "graphql", to: "graphql#execute"

  get 'health', to: proc { [200, {}, ['success']] }

  namespace :api do
    namespace :v1 do
      resource :signups, only: %i[create]

      resource :refreshs, only: %i[create]

      resource :signins, only: %i[create]

      resources :projects, only: %i[index create update destroy] do
        resources :tasks, only: %i[create update destroy], shallow: true do
          resources :comments, only: %i[create destroy], shallow: true
        end
      end
    end
  end
end
