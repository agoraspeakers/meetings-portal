module.exports = {
  env: {
    browser: true
  },
  // Loads ESLint rules
  extends: [
    "airbnb-base",
    "eslint:recommended",
    "plugin:import/typescript",
    "plugin:@typescript-eslint/recommended",
  ],

  parser: "@typescript-eslint/parser",
  plugins: ["import", "@typescript-eslint"],

  settings: {
    "import/resolver": {
      node: {
        extensions: [".tsx", ".ts"]
      },
      "eslint-import-resolver-typescript": true,
    },
    "import/parsers": {
      "@typescript-eslint/parser": [".tsx", ".ts"]
    }
  },

  rules: {
    "max-len": ["error", {"code": 112}]
  }
};
