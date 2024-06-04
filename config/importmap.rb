# Pin npm packages by running ./bin/importmap

pin "bootstrap", to: "bootstrap.min.js", preload: true
pin "@popperjs/core", to: "popper.js", preload: true
pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "el-transition" # @0.0.7
pin "axios" # @1.7.2
pin "#lib/adapters/http.js", to: "#lib--adapters--http.js.js" # @2.0.1
pin "#lib/platform/node/classes/FormData.js", to: "#lib--platform--node--classes--FormData.js.js" # @2.0.1
pin "#lib/platform/node/index.js", to: "#lib--platform--node--index.js.js" # @2.0.1
