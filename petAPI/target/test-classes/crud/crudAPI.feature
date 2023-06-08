Feature: petstore CRUD operations

  Background: 
    Given url baseUrl

  @get
  Scenario: Positive test for GET request
    * def expectedOutput = read("classpath:data/getResult.json")
    Given path '/6'
    When method GET
    Then status 200
    And karate.log(response)
    And match response.name == 'Princess'
    And match response == expectedOutput

  @get
  Scenario: Negative test for GET request
    * def expectedOutput = read("classpath:data/getResult.json")
    Given path '/7'
    When method GET
    Then status 200
    And karate.log(response)
    And karate.log(expectedOutput)
    And match response.name != null
    And match response != expectedOutput

  @post
  Scenario: Positive test for POST request
    * header Content-Type = 'application/json'
    * def postRequest = read('classpath:data/postData.json')
    And request postRequest
    When method POST
    Then status 200

  @post
  Scenario: Negative test for POST request
    * header Content-Type = 'application/json'
    * def postRequest = read('classpath:data/postData.json')
    * def statusSuccess = function(){ var status = karate.get('responseStatus'); return status >= 400 && status < 500 }
    Given path "/pet"
    And request postRequest
    When method POST
    Then assert statusSuccess()

  @put
  Scenario: Positive test for PUT request
    * def requestJson = read("classpath:data/putData.json")
    * header Content-Type = 'application/json'
    And request requestJson
    When method PUT
    Then status 200
    And match response == requestJson
    And karate.log(response)
    And karate.log(requestJson)

  @put
  Scenario: Negative test for PUT request
    * def requestJson = read("classpath:data/putData.json")
    * header Content-Type = 'application/json'
    Given path '/1'
    And request requestJson
    When method PUT
    Then status 405
    And match response != requestJson
    And karate.log(response)
    And karate.log(requestJson)

  @delete
  Scenario: Positive test for DELETE request
    Given path '/5'
    When method DELETE
    Then status 200
    And karate.log(response)
    And match response.code == 200
    And match response.type == 'unknown'

  @delete
  Scenario: Positive test for DELETE request
    Given path '/5'
    When method DELETE
    Then status 404
    And karate.log(response)
    And match response.code != 200
    And match response.type != 'unknown'
