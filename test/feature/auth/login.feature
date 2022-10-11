Feature: User login
#  Background:
#    Given the app is running

  Scenario: User is presented with login screen
    Given the app is running
    And I'm is not logged in
    Then I see {'login_page'}
    And I see {'phone_number_field'}
    And I see {'password_field'}
    And I see {'submit'}

  Scenario Outline: User submits correct data to login successfully
    Given the app is running
    When I enter <phone_number> into {0} input field
    And I enter <password> into {1} input field
    And I tap {'submit'} button
    Then I see {'home_page'}
    Examples:
      | phone_number     | password          |
      | "test@gmail.com" | "helloThere@1234" |

  Scenario Outline: User submits with missing required parameters
    Given the app is running
    And I see {'submit'}
    When I enter <phone_number> into {0} input field
    And I enter <password> into {1} input field
    And I tap {'submit'} button
    Then I see {'error_message'}
    Examples:
      |phone_number               |password          |
      |""                         |"helloThere@1234" |
      |"test@gmail.com"           |""                |