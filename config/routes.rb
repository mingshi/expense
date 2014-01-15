Expense::Application.routes.draw do
    get "accounts/login"
    get "expense/myList"
    resources :posts
    root to: 'expense#myList'
    get '/login'    =>  'accounts#login', as: 'login'
    post '/login'   =>  'accounts#login', as: 'do_login'
    get '/logout'   =>  'accounts#logout', as: 'logout'
    get '/expense/add'  =>  'expense#add', as: 'add_expense'
    post '/expense/add'  =>  'expense#add', as: 'do_add_expense'
    get '/expense/get_json_user' => 'expense#get_json_user', as: 'jsonUser'
    get "/expense/edit/:id"   =>  'expense#edit', as: 'editEx', :constraints => {:id => /\d/}
    get "/expense/show/:id"   =>  'expense#show', as: 'showEx', :constraints => {:id => /\d/}
    get '/expense/myManage' =>  'expense#myManage', as: 'exManage'
end
