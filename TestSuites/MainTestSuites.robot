*** Settings ***
Suite Setup
Test Setup        MainFunctions.Launch Browser  ${BROWSER}  ${url}
Test Teardown     MainFunctions.When Test Fail Take Screenshot
Resource          ../Variables/MainFunctions.robot
Resource          ../Facilities/LoginPageFacilities.robot
Resource          ../Facilities/HomePageFacilities.robot
Resource          ../Facilities/ProductDetailFacilities.robot
Resource          ../Facilities/ShopingCardFacilities.robot

*** Variables ***
${BROWSER}=   Chrome

*** Test Cases ***
01.Last Seen Products
    Login HB
    Visit Product in Home Page  0
    ${productFirst}   Get Product Name
    Go To Home Page
    Visit Product in Home Page  1
    ${productSecond}   Get Product Name
    Go To Home Page
    Visit Product in Home Page  2
    ${productThird}   Get Product Name
    Go To Basket
    Check Products On Last Seen  ${productFirst}
    Check Products On Last Seen  ${productSecond}
    Check Products On Last Seen  ${productThird}
