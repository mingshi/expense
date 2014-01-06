Expense::Application.routes.draw do
    get "accounts/login"
    get "expense/myList"
    resources :posts
    root to: 'expense#myList'
    get '/login'    =>  'accounts#login', as: 'login'
    post '/login'   =>  'accounts#login', as: 'do_login'
    get '/logout'   =>  'accounts#logout', as: 'logout'
    get '/expense/add'  =>  'expense#add', as: 'add_expense'
    post '/expense/do_add' => 'expense#do_add', as: 'do_add_ex'
end
