
# H1 Himeneu  | https://www.himeneu.com/

>Website para facilitar a comunicação entre provedores de serviços e as noivas
>no estilo do easyroommate. http://www.easyroommate.com

### Set up the env
 - Install rbenv and ruby-build for controlling different ruby versions in your machine
  - For mac users ```$ brew update $ brew install rbenv ruby-build```
  - Others OS 
    - ```git clone https://github.com/sstephenson/rbenv.git ~/.rbenv```
    - ```git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build```
  - ```echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile```
  - ```echo 'eval "$(rbenv init -)"' >> ~/.bash_profile```
  - ```source ~/.bash_profile```
  - In your terminal ```$ type rbenv``` . It should display #=> "rbenv is a function"
- Installing a ruby version type it on your terminal ```rbenv install 2.2.0```
 - after installing ```rbenv rehash``` and ```rbenv global 2.2.0```
 - check the ruby version `ruby -v' it must show the version 2.2.0
For mor information: https://github.com/sstephenson/rbenv

- Install nodejs in your machine
- `echo 'gem: --no-document' >> ~/.gemrc`
- `gem install bundler`
- In the add root dir `bundle install --without production`
### Starting the app
`rake db:migrate`
`rake db:seed`
=> `bundle exec rails s`


#### Not necessary in development env
To start the sidekiq, type:  ` bundle exec sidekiq -C config/sidekiq.yml`
To start the mailcatcher, type : ` bundle exec mailcatcher `
To start redis: `redis-server`
To install nodejs `brew install node`



