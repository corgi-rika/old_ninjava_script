# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "quiz", to: "quiz.js" # この行を追加してquiz.jsを指定
pin "flash", to: "flash.js"
pin "word_table", to: "word_table.js"
