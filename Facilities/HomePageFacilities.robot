*** Settings ***
Library           Selenium2Library
Resource          ../Variables/HomePageVariables.robot
Resource          ../Variables/MainFunctions.robot


*** Keywords ***
Visit Product in Home Page
    [Arguments]  ${index}
    ${product}  replace string  ${productMainPath}  $Index$  ${index}
    Wait And Click Element  ${product}

Go To Home Page
    Wait And Click Element  ${homeIcon}

Go To Basket
    Wait And Click Element  ${shoppingCart}
