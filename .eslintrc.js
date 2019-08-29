module.exports = {
  extends: ["eslint-config-airbnb-base"],

  env: {
    browser: true
  },

  parser: "babel-eslint",

  settings: {
    "import/resolver": {
      webpack: {
        config: {
          resolve: {
            extensions: [".js", ".ts"],
            modules: ["app/javascript", "node_modules"]
          }
        }
      }
    }
  },

  rules: {
    "max-len": ["error", {"code": 112}]
  }
};
