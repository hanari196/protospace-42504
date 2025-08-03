Rails.application.routes.draw do

  #deviseによるﾕｰｻﾞｰ認証ﾙｰﾃｨﾝｸﾞ
  devise_for :users
  
  #prototypeに紐づくｺﾒﾝﾄ作成ﾙｰﾃｨﾝｸﾞ(ﾈｽﾄ)
  resources :prototypes do
    resources :comments, only: :create
  end
  
  resources :users, only: [:show]

  root to: "prototypes#index"
end
