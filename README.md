[![CircleCI](https://circleci.com/gh/agoraspeakers/meetings-portal.svg?style=svg)](https://circleci.com/gh/agoraspeakers/meetings-portal)
[![Maintainability](https://api.codeclimate.com/v1/badges/d29313dd7d7c391ca6c5/maintainability)](https://codeclimate.com/github/agoraspeakers/meetings-portal/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/d29313dd7d7c391ca6c5/test_coverage)](https://codeclimate.com/github/agoraspeakers/meetings-portal/test_coverage)

# Meetings Portal

Prototype for [Agora Speakers International](https://www.agoraspeakers.org)
Portal.

## Code / Issues

https://github.com/agoraspeakers/meetings-portal

## Requirements

This project is build with Ruby and Ruby on Rails.

* Ruby version: `ruby-2.7.0-preview1`
* Ruby on Rails version: `Rails 6.0.0`

Usual installation path requires:

0. install JavaScript engine like `nodejs`
1. install [`ruby`](ruby-lang.org)
2. install foreman: `gem install foreman`
3. install project dependencies: `bundle install`
4. install javascript dependencies: `yarn install`

## Running project

0. run `rails db:prepare` to setup or update database
1. run `rails credentials:edit --environment development` to set credentials in development environment
  * Fill the file with required credentials listed below:
    ```
    facebook_app_id: your_facebook_app_id
    facebook_app_secret: your_facebook_app_secret
    ```
    To get these credentials you should:
    1. create [Facebook Developer Account](https://developers.facebook.com/apps)
    2. create [Facebook App](https://developers.facebook.com/) called e.g. "meetings-portal"
    3. set up Facebook Login product with default settings
    4. go to Settings -> Basic, there you can find your App ID and App Secret
    
2. *OPTIONAL:* run `rails credentials:edit --environment test` to set credentials in test environment
3. run `foreman start` to start the rails and the webpack-dev servers
4. open browser at http://localhost:3000

## Linting

### Stylesheets
We are using stylelint to check syntax in scss files.

To check if all written styles have correct syntax, please type:
- `yarn stylelint-all`

To check if only one file has correct syntax, please type:
- `yarn stylelint path_to_scss_file`

### JavaScript
We are using ESLint to check syntax in JavaScript files.

To check if all written js files have correct syntax, please type:
- `yarn eslint-all`

To check if only one file has correct syntax, please type:
- `yarn eslint path_to_js_file`

## Facebook data
For now, the Meetings Portal application retrieves only [default user's data](https://developers.facebook.com/docs/facebook-login/permissions/#reference-default) from facebook.

## License

[GNU Afero GPL](https://www.gnu.org/licenses/agpl-3.0.html)

## Contributions

0. Discuss,
1. Clone,
2. Update,
3. Comment your code,
4. Write, change, run tests,
5. Open PR.

Before putting any effort into the project please discuss with other
developers to avoid duplicate work or unnecessary efforts.

