Expense::Application.routes.draw do
    get "accounts/login"
    get "expense/myList"
    resources :posts
    root to: 'expense#myList'
    get '/login'    =>  'accounts#login', as: 'login'
    post '/login'   =>  'accounts#login', as: 'do_login'
    get '/logout'   =>  'accounts#logout', as: 'logout'
end
