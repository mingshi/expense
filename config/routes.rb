Expense::Application.routes.draw do
  get "accounts/login"
  get "expense/myList"
    resources :posts
    root to: 'expense#myList'
    get '/login'    =>  'accounts#login', as: 'login'
    post '/accounts/do_login' =>  'accounts#do_login', as: 'do_login'
end
